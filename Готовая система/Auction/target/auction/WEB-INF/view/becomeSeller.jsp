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
            background: linear-gradient(135deg, #ffffff 0%, #f5f5f5 50%, #e0e0e0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;

        }

        .form-container {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h2 {
            color: #1a3a6c;
            font-weight: 700;
            font-size: 1.8rem;
            letter-spacing: -0.5px;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
            font-size: 0.95rem;
        }

        input[type="email"],
        input[type="text"] {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5ee;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        input:focus {
            outline: none;
            border-color: #2c5aa0;
            background-color: white;
            transform: translateY(-2px);
        }

        .hint {
            font-size: 0.8rem;
            color: #6c757d;
            margin-top: 0.25rem;
            font-style: italic;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .btn {
            flex: 1;
            padding: 12px 24px;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1rem;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2c5aa0 0%, #1a3a6c 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(44, 90, 160, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(44, 90, 160, 0.4);
        }

        .required::after {
            content: " *";
            color: #dc3545;
        }

        footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            text-align: center;
            padding: 1rem;
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-header">
            <h2>Стать продавцом</h2>
        </div>

        <form action="${pageContext.request.contextPath}/profile/becomeSeller" method="post">
            <input type="hidden" name="userId" value="${user.id}">
            <input type="hidden" name="role" value="SELLER">

            <div class="form-group">
                <label for="email" class="required">Email</label>
                <input type="text" id="email" name="email"
                       value="${fn:escapeXml(user.email)}"
                       readonly required maxlength="200">
                <div class="hint">Проверьте email</div>
            </div>

            <div class="form-group">
                <label for="lastName" class="required">Фамилия</label>
                <input type="text" id="lastName" name="lastName"
                       value="${fn:escapeXml(user.lastName)}"
                       readonly required maxlength="150">
                <div class="hint">Проверьте фамилию</div>
            </div>

            <div class="form-group">
                <label for="firstName" class="required">Имя</label>
                <input type="text" id="firstName" name="firstName"
                       value="${fn:escapeXml(user.firstName)}"
                       readonly required maxlength="150">
                <div class="hint">Проверьте имя</div>
            </div>

            <div class="form-group">
                <label for="numberPhone">Телефон</label>
                <input type="text" id="numberPhone" name="numberPhone"
                       value="${fn:escapeXml(user.numberPhone)}"
                       readonly>
                <div class="hint">Проверьте номер телефона</div>
            </div>

            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">Стать продавцом</button>
            </div>
        </form>
    </div>

    <footer>
        © 2026 Аукцион картин. Все права защищены.
    </footer>
</body>
</html>