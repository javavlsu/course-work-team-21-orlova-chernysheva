<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Подтверждение удаления лота</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .confirm-box {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 400px;
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
        }
        .btn-primary {
            background: #2c5aa0;
            color: white;
        }
        .btn-secondary {
            background: transparent;
            color: #2c5aa0;
            border: 1px solid #2c5aa0;
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
    <div class="confirm-box">
        <h3>Подтверждение удаления</h3>
        <p>Вы уверены, что данный лот ("<strong>${lot.title}</strong>") необходимо удалить?</p>
        <p>Лот будет удален и возврату не подлежит</p>

        <div style="margin-top: 1.5rem;">
            <form action="${pageContext.request.contextPath}/admin/deleteLot" method="post">
                <input type="hidden" name="lotId" value="${lot.id}">
                <button type="submit" class="btn btn-primary">Да, удалить</button>
                <a href="#" onclick="window.history.go(-1); return false;" class="btn btn-secondary">Нет, вернуться</a>
            </form>
        </div>
    </div>
</body>
</html>
