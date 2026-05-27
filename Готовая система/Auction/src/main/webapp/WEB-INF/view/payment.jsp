<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Оплата лота</title>
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%); /* Переход: белый → светло‑серый */
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        color: #333;
    }

    .payment-container {
        background: white;
        border-radius: 16px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
        width: 90%;
        max-width: 500px;
        overflow: hidden;
        border: 1px solid #e0e6f0;
    }

    .payment-header {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); /* Глубокий синий градиент */
        color: white;
        padding: 30px;
        text-align: center;
    }

    .payment-header h1 {
        font-size: 28px;
        margin-bottom: 10px;
        font-weight: 600;
    }

    .lot-info h2 {
        font-size: 22px;
        margin-bottom: 5px;
        font-weight: 500;
    }

    .amount {
        font-size: 32px;
        font-weight: bold;
        color: #a3d5ff; /* Светло‑голубой акцент */
    }

    .payment-body {
        padding: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2a5298; /* Синий цвет для заголовков полей */
    }

    input[type="text"],
    input[type="number"] {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #d0d9e5; /* Светло‑синий контур */
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.3s ease;
        background-color: #f8fbff; /* Лёгкий голубой фон */
    }

    input:focus {
        outline: none;
        border-color: #2a5298; /* Насыщенный синий при фокусе */
        background-color: white;
        box-shadow: 0 0 0 3px rgba(42, 82, 152, 0.1);
    }

    .card-info {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
    }

    .payment-footer {
        text-align: center;
        padding: 20px 30px 30px;
    }

    .pay-button {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); /* Яркий синий градиент кнопки */
        color: white;
        border: none;
        padding: 15px 30px;
        border-radius: 8px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        width: 100%;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(79, 172, 254, 0.2);
    }

    .pay-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(79, 172, 254, 0.3);
    }

    .pay-button:active {
        transform: translateY(0);
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
    }
    </style>
</head>
<body>
    <div class="payment-container">
        <div class="payment-header">
            <h1>Оплата</h1>
            <div class="lot-info">
                <h2>Лот:<%= request.getAttribute("title") %></h2>
                <p class="amount"><%= request.getAttribute("amount") %> руб.</p>
            </div>
        </div>

        <div class="payment-body">
            <form action="${pageContext.request.contextPath}/payment" method="post">
            <!-- Скрытое поле для ID лота -->
            <input type="hidden" name="paymentId" value="${payment.id}">
                <div class="form-group">
                    <label for="cardNumber">Номер карты</label>
                    <input type="text" id="cardNumber" name="cardNumber"
                    placeholder="1234 5678 9012 3456" maxlength="19" required>
                </div>

                <div class="card-info">
                    <div class="form-group">
                        <label for="expiryDate">Срок действия</label>
                        <input type="text" id="expiryDate" name="expiryDate"
                        placeholder="ММ/ГГ" maxlength="5" required>
                    </div>

                    <div class="form-group">
                        <label for="cvv">CVV</label>
                        <input type="number" id="cvv" name="cvv"
                        placeholder="123" maxlength="3" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="cardName">Фамилия и имя владельца</label>
                    <input type="text" id="cardName" name="cardName"
                    placeholder="Имя и фамилия" required>
                </div>

                <div class="payment-footer">
                    <button type="submit" class="pay-button">Оплатить</button>
                    <a href="#" onclick="window.history.go(-1); return false;" class="btn btn-secondary">Назад</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
