<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Аукцион картин</title>
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

      main {
          max-width: 1400px;
          margin: 2.5rem auto;
          padding: 0 5%;
      }
.container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
            font-size: 1rem;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #007BFF;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
            line-height: 1.4;
        }

        .hint {
            font-size: 0.9rem;
            color: #666;
            margin-top: 5px;
            font-style: italic;
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

    <main class="container">
        <h2>Редактировать лот</h2>
        <form action="${pageContext.request.contextPath}/updateLot" method="post">
            <!-- Скрытое поле для ID лота -->
            <input type="hidden" name="lotId" value="${lot.id}">

            <div class="form-group">
                <label for="title" class="required">Название картины</label>
                <input type="text" id="title" name="title"
                       value="${fn:escapeXml(lot.title)}" required maxlength="200">
                <div class="hint">Введите полное название произведения искусства</div>
            </div>

            <div class="form-group">
                <label for="author" class="required">Автор</label>
                <input type="text" id="author" name="author"
                       value="${fn:escapeXml(lot.author)}" required maxlength="150">
                <div class="hint">Укажите автора картины (ФИО полностью)</div>
            </div>

            <div class="form-group">
                <label for="description" class="required">Описание картины</label>
                <textarea id="description" name="description" maxlength="1000">${fn:escapeXml(lot.description)}</textarea>
                <div class="hint">Чем подробнее описание, тем выше интерес покупателей</div>
            </div>

            <div class="form-group">
                <label for="image">URL изображения</label>
                <input type="text" id="image" name="image"
                       value="${fn:escapeXml(lot.image)}" placeholder="https://example.com/image.jpg">
                <div class="hint">Прямая ссылка на изображение картины (опционально)</div>
            </div>

            <div class="form-group">
                <label for="startPrice">Начальная цена (руб.)</label>
                <input type="number" id="startPrice" name="startPrice"
                       value="${lot.startPrice}" step="0.01" min="0.01" readonly disabled>
                <div class="hint">Начальная цена не может быть изменена после создания лота</div>
            </div>

            <!-- Кнопки -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">Сохранить изменения</button>
                <a href="#" onclick="window.history.go(-1); return false;" class="btn btn-secondary">Отмена</a>
            </div>
        </form>
    </main>
    <footer>
        <p>&copy; 2026 Аукцион картин. Все права защищены.</p>
    </footer>
</body>
</html>