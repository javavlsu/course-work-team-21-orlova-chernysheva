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
        main {
          max-width: 1400px;
          margin: 2.5rem auto;
          padding: 0 5%;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info img {
            width: 30px;
            height: 30px;
            margin-left: 10px;
        }
        .content {
            padding: 20px;
        }
        .message {
            background-color: #F0F0F0;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        .message p {
            margin: 0;
        }
        footer {
          margin-top: 4rem;
          padding: 2rem 5%;
          text-align: center;
          background: #1a3a6c;
          color: white;
          font-size: 0.9rem;
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
        <c:choose>
            <c:when test="${not empty notifications}">
            <c:forEach var="notification" items="${notifications}">
                <div class="message">
                    <p>${notification.content}</p>
                    <c:if test="${notification.admissionDate != null}">
                        <p><fmt:formatDate value="${notification.admission}"
                            pattern="dd.MM.yyyy HH:mm"/></p>
                    </c:if>
                </div>
            </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="message">
                    <p>У вас нет новых уведомлений</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
   </main>
    <footer>
        <p>&copy; 2026 Аукцион картин. Все права защищены.</p>
    </footer>
</body>
</html>