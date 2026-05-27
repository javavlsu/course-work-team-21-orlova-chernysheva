<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Мои лоты — Аукцион картин</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6/css/all.min.css">
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

      .btn-primary {
          background: #2c5aa0;
          color: white;
      }

      .btn-primary:hover {
          background: #1a3a6c;
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
          padding: 0.8rem 1.4rem; /* Немного больше padding для кнопки внутри карточки */
          margin-top: auto; /* Для прилипания к низу карточки */
      }

      .btn-details:hover {
          background: #1a3a6c;
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
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        .lots-list {
            width: 100%;
            border-collapse: collapse;
        }
        .lots-list th, .lots-list td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
        }
        .lots-list th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .lots-list tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            text-align: center;
        }
        .btn-view {
            background-color: #28a745;
            color: white;
        }
        .btn-edit {
            background-color: #ffc107;
            color: black;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn:hover {
            opacity: 0.8;
        }
        .no-lots {
            text-align: center;
            font-style: italic;
            color: #666;
            padding: 40px;
        }
      .error-message {
          color: #d9534f;
          background-color: #fce8e8;
          border: 1px solid #d9534f;
          padding: 1rem;
          border-radius: 8px;
          margin-bottom: 2rem;
          text-align: center;
          font-weight: bold;
      }

      .btn-disabled,
      a[disabled] {
        opacity: 0.6;
        pointer-events: none;
        cursor: not-allowed;
        color: #999;
        border-color: #ccc;
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
        <div class="container">
            <h2>Мои лоты</h2>

            <c:choose>
                <c:when test="${empty lots}">
                    <div class="no-lots">У вас пока нет созданных лотов.</div>
                </c:when>
                <c:otherwise>
                    <table class="lots-list">
                        <thead>
                            <tr>
                                <th>Название</th>
                                <th>Начальная цена</th>
                                <th>Текущая ставка</th>
                                <th>Дата окончания</th>
                                <th>Статус</th>
                                <th>Действия</th>
                            </tr>
                        </thead>
        <tbody>
            <c:forEach var="lot" items="${lots}">
                <tr>
                    <td>${lot.title}</td>
                    <td>$${lot.startPrice}</td>
                <td>
                <c:choose>
                    <c:when test="${lot.currentPrice != null}">
                $${lot.currentBid}
            </c:when>
            <c:otherwise>
                Нет ставок
            </c:otherwise>
        </c:choose>
    </td>
    <td>
        <c:out value="${lot.endTimeFormatted.format(DateTimeFormatter.ofPattern('dd.MM.yyyy HH:mm'))}" />
    </td>
    <td>
        <c:choose>
            <c:when test="${lot.status == 'на выставке'}">
                <span style="color: green;">На выставке</span>
            </c:when>
            <c:when test="${lot.status == 'завершен'}">
                <span style="color: red;">Завершён</span>
            </c:when>
            <c:when test="${lot.status == 'ожидает удаления'}">
                <span style="color: orange;">Ожидает удаления</span>
            </c:when>
            <c:when test="${lot.status == 'ожидает проверку'}">
                <span style="color: orange;">Ожидает проверку</span>
            </c:when>
            <c:otherwise>
                <span>${lot.status}</span>
            </c:otherwise>
        </c:choose>
    </td>
    <td class="action-buttons">
        <a href="${pageContext.request.contextPath}/detailLotSeller/${lot.id}" class="btn btn-view">
            <i class="fas fa-eye"></i> Просмотр
        </a>
        <a href="${pageContext.request.contextPath}/updateLot/${lot.id}" class="btn btn-edit">
            <i class="fas fa-edit"></i> Редактировать
        </a>
        <a href="${pageContext.request.contextPath}/deleteLot/${lot.id}"
           class="btn btn-delete ${lot.status == 'ожидает удаления' ? 'btn-disabled' : ''}"
           ${lot.status == 'ожидает удаления' ? 'disabled' : ''}>
          <i class="fas fa-trash"></i> Удалить
        </a>
    </td>
</tr>
</c:forEach>
</tbody>
</table>
</c:otherwise>
</c:choose>

<div style="margin-top: 20px; text-align: center;">
    <a class="btn btn-primary"
       href="${pageContext.request.contextPath}/createLot?page=${currentPage}&size=${pageSize}">
        Добавить лот
    </a>
</div>

</div>
</div>
</main>

    <footer>
        <p>&copy; 2026 Аукцион картин. Все права защищены.</p>
    </footer>

<script>

</script>
</body>
</html>
