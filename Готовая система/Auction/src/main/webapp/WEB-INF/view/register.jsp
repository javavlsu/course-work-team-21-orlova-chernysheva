<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            padding: 40px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .form-group {
            margin-bottom: 10px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
            outline: none;
        }

        input:focus {
            border-color: #667eea;
        }

        button {
            width: 100%;
            padding: 14px;
            color: black;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .links {
            text-align: center;
            margin-top: 25px;
        }

        .hint {
            font-size: 0.9rem;
            color: #666;
            margin-top: 5px;
            font-style: italic;
        }

        a {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .privacy-link {
            display: block;
            margin-top: 15px;
            font-size: 12px;
            color: #999;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Регистрация</h1>
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="firstName">Фамилия</label>
                <input type="text" id="firstName" name="firstName" required>
                <div class="hint">Укажите вашу фамилию</div>
            </div>
            <div class="form-group">
                <label for="lastName">Имя</label>
                <input type="text" id="lastName" name="lastName" required>
                <div class="hint">Укажите ваше имя</div>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" required>
                <div class="hint">Укажите email</div>
            </div>
            <div class="form-group">
                <label for="numberPhone">Номер телефона</label>
                <input type="text" id="numberPhone" name="numberPhone" required maxlength="11">
                <div class="hint">Укажите ваш номер телефона (формат: 89992542563)</div>
            </div>
            <div class="form-group">
                <label for="login">Логин</label>
                <input type="text" id="login" name="login" required>
                <div class="hint">Придумайте логин</div>
            </div>
            <div class="form-group">
                <label for="password">Пароль</label>
                <input type="password" id="password" name="password" required>
                <div class="hint">Придумайте пароль</div>
            </div>
            <button type="submit">Зарегистрироваться</button>
        </form>

        <div class="links">
            <a href="${pageContext.request.contextPath}/privacy-policy" class="privacy-link">Privacy Policy</a>
        </div>
    </div>
</body>
</html>
