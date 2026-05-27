<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Детали лота - Аукцион картин</title>
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

        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin: 2rem auto;
            max-width: 1200px;
        }

        .image-container {
            text-align: center;
        }

        .image-container img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .info-container h2 {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: #1a3a6c;
        }

        .info-container p {
            margin-bottom: 0.8rem;
            font-size: 1.1rem;
        }

        .history-container {
            grid-column: 1 / -1;
            margin-top: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        tr:hover {
            background: #f8f9fa;
        }

        .bid-form {
            grid-column: 1 / -1;
            margin-top: 2rem;
        }

        .bid-form h3 {
            margin-bottom: 1rem;
            color: #1a3a6c;
        }

        .bid-form input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 1rem;
            font-size: 1rem;
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

        .lot-actions {
            display: flex;
            gap: 0.8rem;
            margin-top: 1.5rem;
            flex-wrap: wrap;
        }

        .btn-danger {
            background: #d9534f;
            color: white;
            border: 1px solid #d9534f;
        }

        .btn-danger:hover {
            background: #c9302c;
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

<c:choose>
    <c:when test="${empty lot}">
        <div class="error-message">
            Лот с ID ${param.lotId} не найден.
        </div>
    </c:when>
    <c:otherwise>
        <main>
            <div class="container">
                <!-- Изображение лота -->
                <div class="image-container">
                    <c:choose>
                <c:when test="${not empty lot.image}">
                    <img src="${lot.image}" alt="${lot.title}" onerror="this.style.display='none'">
                </c:when>
                <c:otherwise>
                    <div style="width: 100%; height: 300px; background: #f0f0f0; display: flex; align-items: center; justify-content: center;">
                <span>Изображение отсутствует</span>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Информация о лоте -->
<div class="info-container">
    <h2>${lot.title}</h2>
    <p><strong>Автор:</strong> ${lot.author}</p>
    <p><strong>Описание:</strong> ${lot.description}</p>
    <p><strong>Начальная цена:</strong> ${lot.startPrice} руб.</p>
    <p><strong>Текущая ставка:</strong>
        ${lot.currentPrice != null ? lot.currentPrice : 'Ставок нет'} руб.
    </p>
    <p><strong>Статус:</strong> ${lot.status}</p>
    <p><strong>Дата добавления:</strong>
        <fmt:formatDate value="${formattedDateAdded}" pattern="dd.MM.yyyy HH:mm"/>
    </p>

    <!-- Кнопки редактирования и удаления -->
    <div class="lot-actions">
        <a href="${pageContext.request.contextPath}/updateLot/${lot.id}"
           class="btn btn-secondary">
            <i class="fas fa-edit"></i> Редактировать
        </a>
        <a href="${pageContext.request.contextPath}/deleteLot/${lot.id}"
           class="btn btn-danger">
            <i class="fas fa-trash"></i> Удалить
        </a>
    </div>
</div>

<!-- История ставок -->
<div class="history-container">
    <h3>История ставок (${fn:length(bids)} шт.)</h3>
    <table>
        <thead>
            <tr>
                <th>№</th>
                <th>Сумма (руб.)</th>
                <th>Дата и время</th>
                <th>Участник</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="bid" items="${bids}" varStatus="status">
                <tr>
                    <td>${status.count}</td>
            <td>${bid.bidAmount}</td>
            <td>
                <fmt:formatDate value="${bid.bidDateTimeFormatted}" pattern="dd.MM.yyyy HH:mm:ss"/>
            </td>
            <td>${bid.user != null ? bid.user.email : 'Аноним'}</td>
        </tr>
    </c:forEach>
</tbody>
</table>
</div>
</div>
</main>
</c:otherwise>
</c:choose>

    <footer>
        <p>&copy; 2026 Аукцион картин. Все права защищены.</p>
    </footer>
</body>
</html>
