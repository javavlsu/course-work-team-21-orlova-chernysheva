<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Аукцион картин</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f5f7fa;
      color: #333;
      line-height: 1.6;

    }
    main {
      max-width: 1400px;
      margin: 2.5rem auto;
      padding: 0 5%;
    }
    header {
      background: #ffffff;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
      position: sticky;
      top: 0;
      z-index: 100;
      border-bottom: 1px solid #eaeaea;
    }
    nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 5%;
      max-width: 1400px;
      margin: 0 auto;
    }
    .logo h1 {
      color: #1a3a6c;
      font-weight: 700;
      font-size: 1.8rem;
      letter-spacing: -0.5px;
    }
    .logo a {
      text-decoration: none;
      color: inherit;
    }
    .nav-right {
      display: flex;
      align-items: center;
      gap: 2rem;
    }
    .user-email {
      color: #2c5aa0;
      text-decoration: none;
      font-weight: 500;
      font-size: 0.95rem;
    }
    .notification-bell {
      color: #666;
      text-decoration: none;
      position: relative;
      font-size: 1.1rem;
    }
    .user-menu {
      position: relative;
      display: inline-block;
    }
    .dropdown-menu {
      display: none;
      position: absolute;
      top: 100%;
      right: 0;
      background: white;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border-radius: 6px;
      min-width: 150px;
      z-index: 10;
    }
    .dropdown-menu a {
      display: block;
      padding: 0.8rem 1rem;
      text-decoration: none;
      color: #333;
      border-bottom: 1px solid #eee;
    }
    .dropdown-menu a:hover {
      background: #f0f5ff;
    }
    .user-menu:hover .dropdown-menu {
      display: block;
    }
    /* Стили для каталога аукционов — только синие цвета */
    .auctions-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 1.5rem;
      margin-top: 2rem;
    }

    .auction-card {
      background: white;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(26, 58, 108, 0.15); /* Синий оттенок тени */
      transition: transform 0.2s, box-shadow 0.2s;
      cursor: pointer;
      text-decoration: none; /* Убрано подчёркивание ссылки */
      color: inherit; /* Убрано цветное подчёркивание */
    }

    .auction-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(26, 58, 108, 0.2); /* Более тёмный синий при наведении */
    }

    .auction-placeholder {
      height: 200px;
      background: linear-gradient(135deg, #1a3a6c 0%, #2c5aa0 100%); /* Синий градиент */
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 1.2rem;
      font-weight: 500;
    }

    .auction-info {
      padding: 1.2rem;
    }

    .auction-title {
      font-size: 1.1rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
      color: #1a3a6c; /* Тёмно‑синий */
    }

    .auction-dates {
      color: #4a7bbd; /* Средний синий */
      font-size: 0.9rem;
    }

    .date-label {
      font-weight: 500;
      color: #2c5aa0; /* Яркий синий */
    }
    //стили для пагинации
    .pagination {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 1rem;
      margin-top: 2rem;
    }

    .pagination-info {
      font-size: 0.9rem;
      color: #666;
    }

    .pagination-controls {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      flex-wrap: wrap;
      justify-content: center;
    }

    .page-link {
      padding: 0.4rem 0.8rem;
      text-decoration: none;
      color: #2c5aa0;
      border: 1px solid #d1d5da;
      border-radius: 4px;
      transition: all 0.2s ease;
    }

    .page-link:hover {
      background: #f0f5ff;
      border-color: #2c5aa0;
    }

    .page-current {
      padding: 0.4rem 0.8rem;
      background: #2c5aa0;
      color: white;
      border-radius: 4px;
      font-weight: 600;
    }

    .btn-disabled {
      padding: 0.7rem 1.4rem;
      background: #eaeaea;
      color: #999;
      cursor: not-allowed;
      border: 1px solid #d1d5da;
      border-radius: 6px;
    }
    .btn-secondary {
      background: transparent;
      color: #2c5aa0;
      border: 1px solid #2c5aa0;
    }

    .btn-secondary:hover {
      background: #f0f5ff;
    }
    .btn {
      padding: 0.7rem 1.4rem;
      border: none;
      border-radius: 6px;
      text-decoration: none;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s ease;
      font-size: 0.9rem;
      letter-spacing: 0.3px;
    }
    /* Стили для триггера "Мои лоты" */
    .seller-lots-trigger {
        position: relative;
        display: block;
        padding: 0.8rem 1rem;
        cursor: pointer;
        border-bottom: 1px solid #eee;
    }

    .seller-lots-label {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: #333;
    }

    /* Выпадающее меню для "Мои лоты" */
    .seller-lots-dropdown {
        display: none;
        position: absolute;
        top: 0;
        left: 100%;
        background: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        min-width: 150px;
        z-index: 1000;
    }

    /* Показ меню при наведении на триггер "Мои лоты" */
    .seller-lots-trigger:hover .seller-lots-dropdown {
        display: block;
    }

    /* Стили для ссылок внутри выпадающего списка "Мои лоты" */
    .seller-lots-dropdown a {
        display: block;
        padding: 0.8rem 1rem;
        text-decoration: none;
        color: #333;
        border-bottom: 1px solid #eee;
    }

    .seller-lots-dropdown a:hover {
        background: #f0f5ff;
    }
    footer {
      margin-top: 4rem;
      padding: 2rem 5%;
      text-align: center;
      background: #1a3a6c;
      color: white;
      font-size: 0.9rem;
    }
    </style>
</head>
<body>
   <header>
       <nav>
           <div class="logo">
               <a href="${pageContext.request.contextPath}/index"><h1>Аукцион Картин</h1></a>
           </div>
           <div class="nav-right">
               <c:choose>
                   <c:when test="${not empty sessionScope.role}">
                       <div class="user-menu">
                           <span class="user-email">${sessionScope.userEmail}</span>
                           <div class="dropdown-menu">
                               <a href="${pageContext.request.contextPath}/profile">
                                   <i class="fas fa-user dropdown-icon"></i>
                                   Профиль
                               </a>
                               <a href="${pageContext.request.contextPath}/notifications">
                                   <i class="fas fa-bell dropdown-icon"></i>
                                   Уведомления
                               </a>
                               <a href="${pageContext.request.contextPath}/auctions">
                                   <i class="fas fa-gavel dropdown-icon"></i>
                                   Все аукционы
                               </a>
                               <c:if test="${sessionScope.role == 'SELLER'}">
                                   <!-- Пункт "Мои лоты" — просто текст для наведения -->
                                   <div class="seller-lots-trigger">
                                       <span class="seller-lots-label">
                                           <i class="fas fa-box dropdown-icon"></i>
                                           Мои лоты
                                       </span>
                                       <!-- Выпадающее меню для "Мои лоты" -->
                                       <div class="seller-lots-dropdown">
                                           <a href="${pageContext.request.contextPath}/createLot">
                                               <i class="fas fa-plus dropdown-icon"></i>
                                               Создать лот
                                           </a>
                                           <a href="${pageContext.request.contextPath}/allLots">
                                               <i class="fas fa-list dropdown-icon"></i>
                                               Просмотр лотов
                                           </a>
                                       </div>
                                   </div>
                               </c:if>
                               <a href="${pageContext.request.contextPath}/logout">
                                   <i class="fas fa-sign-out-alt dropdown-icon"></i>
                                   Выход
                               </a>
                           </div>
                       </div>
                   </c:when>
                   <c:otherwise>
                       <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Войти</a>
                   </c:otherwise>
               </c:choose>
           </div>
       </nav>
   </header>
    <main>
        <div class="auctions-grid">
                <c:forEach items="${auctions}" var="auction">
                    <a href="${pageContext.request.contextPath}/allAuction/${auction.id}/lotsByAuction" class="auction-card">
                        <div class="auction-placeholder">
                            ${auction.title}
                        </div>
                        <div class="auction-info">
                            <div class="auction-title">${auction.title}</div>
                            <div class="auction-dates">
                                <span class="date-label">Начало:</span>
                                ${auction.startTime.format(DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm"))}
                                <br>
                                <span class="date-label">Окончание:</span>
                                ${auction.endTime.format(DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm"))}
                            </div>
                        </div>
                    </a>
                </c:forEach>
        </div>
        <div class="pagination">
             <div class="pagination-info">
                  Страница ${currentPage} из ${totalPages}
                  (всего каталогов: ${totalLots})
             </div>

             <div class="pagination-controls">
                  <!-- Кнопка «Назад» -->
                  <c:choose>
                      <c:when test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/allAuction?page=${currentPage - 1}&size=${pageSize}"
                               class="btn btn-secondary">Назад</a>
                      </c:when>
                      <c:otherwise>
                            <span class="btn btn-disabled">Назад</span>
                      </c:otherwise>
                  </c:choose>

                  <!-- Номера страниц -->
                  <c:forEach begin="1" end="${totalPages}" var="i">
                      <c:choose>
                          <c:when test="${i == currentPage}">
                              <span class="page-current">${i}</span>
                          </c:when>
                          <c:otherwise>
                              <a href="${pageContext.request.contextPath}/allAuction?page=${i}&size=${pageSize}"
                                 class="page-link">${i}</a>
                          </c:otherwise>
                      </c:choose>
                  </c:forEach>

                  <!-- Кнопка «Вперед» -->
                  <c:choose>
                     <c:when test="${currentPage < totalPages}">
                         <a href="${pageContext.request.contextPath}/allAuction?page=${currentPage + 1}&size=${pageSize}"
                            class="btn btn-primary">Вперед</a>
                     </c:when>
                     <c:otherwise>
                         <span class="btn btn-disabled">Вперед</span>
                     </c:otherwise>
                  </c:choose>
             </div>
        </div>
        <!-- Сообщение при отсутствии аукционов -->
        <c:if test="${empty auctions}">
                <div style="text-align: center; padding: 3rem; color: #666;">
                     <i class="fas fa-exclamation-circle" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                      <h3>Аукционы не найдены</h3>
                      <p>В данный момент нет активных аукционов.</p>
                </div>
        </c:if>
    </main>

    <footer>
        <p>&copy; 2026 Аукцион картин. Все права защищены.</p>
    </footer>
</body>
</html>