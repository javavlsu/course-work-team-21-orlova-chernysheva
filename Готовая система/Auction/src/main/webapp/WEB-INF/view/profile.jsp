<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Аукционный КАРТИН</title>
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

    .btn-danger {
        background: #d9534f;
        color: white;
    }

    .btn-danger:hover {
        background: #c82333;
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
      .content {
        max-width: 600px;
        margin: 30px auto;
        padding: 30px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        font-family: 'Roboto', sans-serif;
      }

      .profile-info {
        display: flex;
        align-items: center;
        gap: 20px;
        margin-bottom: 40px;
        padding-bottom: 20px;
        border-bottom: 1px solid #e0e0e0;
      }

      .profile-info img {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        object-fit: cover;
        transition: transform 0.3s ease;
      }

      .profile-info img:hover {
        transform: scale(1.05);
      }

      .profile-info span {
        font-size: 1.2rem;
        font-weight: 500;
        color: #1a3a6c;
      }

      .form-group {
        margin-bottom: 25px;
      }

      .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: #333;
        font-size: 0.95rem;
      }

      .form-group input {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid #e0e0e0;
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
        box-sizing: border-box;
        font-family: inherit;
      }

      .form-group input:focus {
        outline: none;
        border-color: #2c5aa0;
        box-shadow: 0 0 0 3px rgba(44, 90, 160, 0.1);
      }

      .form-group input::placeholder {
        color: #aaa;
      }

    .button-group {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-top: 30px;
    }

    .btn-seller {
        background: #4CAF50;
        color: white;
    }

    .btn-seller:hover {
        background: #388E3C;
    }

    .btn-lots {
        background: #FF9800;
        color: white;
    }

    .btn-lots:hover {
        background: #F57C00;
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

    /* Отдельные стили для подписей полей */
    .label-static {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: #333;
        font-size: 0.95rem;
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
    .avatar {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        object-fit: cover;
        transition: transform 0.3s ease;
        border: 3px solid #2c5aa0;
    }

    .avatar:hover {
        transform: scale(1.05);
    }

    .avatar-upload-btn {
        position: absolute;
        bottom: 5px;
        right: 5px;
        background: #2c5aa0;
        color: white;
        width: 28px;
        height: 28px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-size: 0.8rem;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    }

    .avatar-upload-btn:hover {
        background: #1a3a6c;
    }

    .avatar-input {
        display: none;
    }
    .feature-notification {
        position: absolute;
        bottom: -30px;
        left: 50%;
        transform: translateX(-50%);
        background-color: #ffeb3b;
        color: #333;
        padding: 8px 16px;
        border-radius: 4px;
        font-size: 14px;
        white-space: nowrap;
        z-index: 1000;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        animation: fadeInOut 3s forwards;
    }

    @keyframes fadeInOut {
        0% { opacity: 0; }
        10% { opacity: 1; }
        90% { opacity: 1; }
        100% { opacity: 0; }
    }

    .avatar-upload-btn {
        border: none;
        background: none;
        cursor: pointer;
        padding: 0;
    }

    .avatar-container {
        position: relative;
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
       <div class="content">
           <div class="profile-info">
               <div class="avatar-container">
                   <c:choose>
                       <c:when test="${not empty user.avatarUrl}">
                           <img id="profileAvatar"
                                src="${pageContext.request.contextPath}/uploads/${user.avatarUrl}"
                                alt="Аватар пользователя"
                                class="avatar">
                       </c:when>
                       <c:otherwise>
                           <img id="profileAvatar"
                                src="${pageContext.request.contextPath}/uploads/avatars/icon.jpg"
                                alt="Аватар пользователя"
                                class="avatar">
                       </c:otherwise>
                   </c:choose>
                   <button type="button" class="avatar-upload-btn" onclick="showFeatureInDevelopment()">
                       <i class="fas fa-camera"></i>
                   </button>
                   <div id="featureNotification"
                        class="feature-notification"
                        style="display: none;">
                       Функция загрузки аватара в разработке
                   </div>
               </div>
               <span>${user.email}</span>
           </div>
           <form>
               <div class="form-group">
                   <label class="label-static">Имя</label>
                   <div class="data-display">${user.lastName}</div>
               </div>
               <div class="form-group">
                   <label class="label-static">Email</label>
                   <div class="data-display">${user.email}</div>
               </div>
               <div class="form-group">
                   <label class="label-static">Телефон</label>
                   <div class="data-display">
                       ${not empty user.numberPhone ? user.numberPhone : 'Не указан'}
                   </div>
               </div>

               <div class="button-group">
                   <c:choose>
                       <c:when test="${sessionScope.role == 'SELLER'}">
                           <a class="btn btn-lots" href="${pageContext.request.contextPath}/allLots">Посмотреть мои лоты</a>
                       </c:when>
                       <c:otherwise>
                           <a class="btn btn-seller" href="${pageContext.request.contextPath}/profile/becomeSeller/${user.id}">Хочу стать продавцом</a>
                       </c:otherwise>
                   </c:choose>

                   <a class="btn btn-danger" href="${pageContext.request.contextPath}/profile/deleteUser/${user.id}">Удалить аккаунт</a>
               </div>
           </form>
       </div>
   </main>
    <footer>
        <p>&copy; 2026 Аукцион картин. Все права защищены.</p>
    </footer>

    <script>
        function handleAvatarUpload(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profileAvatar').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);

                const formData = new FormData();
                formData.append('avatar', input.files[0]);

                fetch('${pageContext.request.contextPath}/profile/uploadAvatar', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Аватар успешно загружен!');
                    } else {
                        alert('Ошибка при загрузке аватара: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert('Произошла ошибка при загрузке файла');
                });
            }
        }
        function showFeatureInDevelopment() {
            const notification = document.getElementById('featureNotification');
            notification.style.display = 'block';
            notification.style.opacity = '1';

            // Автоматически скрываем уведомление через 3 секунды с анимацией
            setTimeout(() => {
                notification.style.opacity = '0';
                // Ждём завершения анимации перед скрытием элемента
                setTimeout(() => {
                    notification.style.display = 'none';
                }, 300); // 300 мс — длительность анимации исчезновения
            }, 3000);
        }
    </script>
</body>
</html>