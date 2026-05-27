<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Определение победителя</title>
    <style>
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 90%;
        }
        .modal-title {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }
        .bid-info {
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.8rem;
        }
        .info-label {
            font-weight: bold;
            color: #555;
        }
        .action-buttons {
            display: flex;
            gap: 1rem;
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
        }
        .btn-notify {
            background-color: #28a745;
            color: white;
        }
        .btn-notify:hover {
            background-color: #218837;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        .btn-back:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>
    <!-- Модальное окно -->
    <div class="modal-overlay">
        <div class="modal">
            <h2 class="modal-title">Последняя ставка</h2>
            <div class="bid-info">
                <c:choose>
                    <c:when test="${not empty lot.winnerEmail}">
                        <div class="info-row">
                            <span class="info-label">Победитель:</span>
                            <span>${fn:escapeXml(lot.winnerEmail)}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Сумма ставки:</span>
                            <span>${lot.winnerBidAmount} руб.</span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p style="color: #666; text-align: center; font-style: italic;">
                            Ставок на этот лот не было
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="action-buttons">
                <form action="${pageContext.request.contextPath}/admin/notifyWinner" method="post">
                    <input type="hidden" name="lotId" value="${lot.id}">
                    <input type="hidden" name="winnerEmail" value="${winnerBid.user.email}">
                    <button type="submit" class="btn btn-notify">Уведомить победителя</button>
                </form>
                <a href="#" onclick="window.history.go(-1); return false;" class="btn btn-secondary">Назад</a>
            </div>
        </div>
    </div>
</body>
</html>
