<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- Добавляем fmt для форматирования чисел --%>
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

    .badge {
      position: absolute;
      top: -6px;
      right: -6px;
      background: #2c5aa0;
      color: white;
      border-radius: 50%;
      width: 16px;
      height: 16px;
      font-size: 0.65rem;
      display: flex;
      align-items: center;
      justify-content: center;
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

    .btn-secondary {
      background: transparent;
      color: #2c5aa0;
      border: 1px solid #2c5aa0;
    }

    .btn-secondary:hover {
      background: #f0f5ff;
    }

    .btn-details {
      background: #2c5aa0;
      color: white;
      display: inline-block;
      text-align: center;
      width: 100%;
      padding: 0.8rem 1.4rem;
      margin-top: auto;
    }

    .btn-details:hover {
      background: #1a3a6c;
    }

    main {
      max-width: 1400px;
      margin: 2.5rem auto;
      padding: 0 5%;
    }

    section {
      margin-bottom: 3.5rem;
    }

    h2 {
      color: #1a3a6c;
      margin-bottom: 1.8rem;
      font-size: 2rem;
      font-weight: 600;
      position: relative;
    }

    h2::after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 0;
      width: 80px;
      height: 3px;
      background: #2c5aa0;
    }

    input[type="text"] {
      flex: 1;
      padding: 0.9rem 1.2rem;
      border: 1px solid #d1d5da;
      border-radius: 8px;
      font-family: 'Roboto', sans-serif;
      font-size: 1rem;
      transition: border 0.2s;
    }

    input[type="text"]:focus {
      outline: none;
      border-color: #2c5aa0;
      box-shadow: 0 0 0 2px rgba(44, 90, 160, 0.2);
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

    .lot-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 2rem;
    }

    .lot-card {
      background: white;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
      display: flex;
      flex-direction: column;
    }

    .lot-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
    }

    .lot-image-container {
      height: 200px;
      overflow: hidden;
      background-color: #f0f0f0;
      display: flex;
      align-items: center;
      justify-content: center;
      border-bottom: 1px solid #eee;
    }

    .lot-image-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .lot-content {
      padding: 1.5rem;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
    }

    .lot-content h3 {
      font-size: 1.4rem;
      color: #1a3a6c;
      margin-bottom: 0.8rem;
      font-weight: 600;
    }

    .lot-content p {
      font-size: 0.95rem;
      color: #555;
      margin-bottom: 1rem;
      flex-grow: 1;
    }

    .lot-price {
      font-size: 1.2rem;
      font-weight: 700;
      color: #2c5aa0;
      margin-bottom: 1.5rem;
    }

    .no-lots-message {
      text-align: center
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
                               <a href="${pageContext.request.contextPath}/allAuction">
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
        <c:choose>
            <c:when test="${sessionScope.role == 'ADMIN'}">
                <!-- Страница администратора -->
                <jsp:include page="/WEB-INF/view/dashboard.jsp" />
            </c:when>
            <c:otherwise>
                 <c:if test="${not empty error}">
                     <div class="error-message">
                         <p>Ошибка: <c:out value="${error}" /></p>
                     </div>
                 </c:if>
                 <section class="current-lots">
                   <h2>
                   <c:choose>
                      <c:when test="${not empty param.query}">
                          Результаты поиска по запросу: "<c:out value="${param.query}" />"
                      </c:when>
                      <c:otherwise>
                          ${auction.title}
                      </c:otherwise>
                   </c:choose>
                   </h2>

                   <c:choose>
                     <c:when test="${empty lots}">
                        <div class="no-lots-message">
                          <p>
                        <c:choose>
                            <c:when test="${not empty param.query}">
                               По запросу "<c:out value="${param.query}" />" лоты не найдены.
                             </c:when>
                            <c:otherwise>
                                На данный момент активных лотов нет. Пожалуйста, зайдите позже!
                            </c:otherwise>
                        </c:choose>
                            </p>
                        </div>
                     </c:when>
                   <c:otherwise>
                      <div class="lot-grid">
                          <c:forEach var="lot" items="${lots}">
                              <div class="lot-card">
                                  <div class="lot-image-container">
                                      <c:if test="${not empty lot.image}">
                                          <img src="${lot.image}" alt="${lot.title}">
                                      </c:if>
                                      <c:if test="${empty lot.image}">
                                          <!-- Заглушка, если нет изображения -->
                                          <i class="fas fa-image fa-3x" style="color: #ccc;"></i>
                                      </c:if>
                              </div>
                              <div class="lot-content">
                                  <h3><c:out value="${lot.title}" /></h3>
                                   <p><c:out value="${lot.description}" /></p>
                                   <p class="lot-price">
                                      Начальная цена: <fmt:formatNumber value="${lot.startPrice}" type="currency" currencySymbol="$" maxFractionDigits="2" minFractionDigits="2" />
                                   </p>
                                   <a href="${pageContext.request.contextPath}/lot/${lot.id}" class="btn btn-details">Посмотреть детали</a>
                              </div>
                               </div>
                          </c:forEach>
                      </div>
                   </c:otherwise>
                   </c:choose>
                 </section>
            </c:otherwise>
        </c:choose>
    </main>

    <footer>
        <p>&copy; 2026 Аукцион картин. Все права защищены.</p>
    </footer>
</body>
</html>