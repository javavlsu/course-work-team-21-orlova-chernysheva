<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Аукцион картин</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
      /* Стили для панели администратора */
      .admin-container {
          padding: 2rem;
      }

      .tab-navigation {
          display: flex;
          border-bottom: 1px solid #ddd;
          margin-bottom: 2rem;
      }
      /* Стили для панели администратора */
      .admin-container {
          padding: 2rem;
      }

      .tab-navigation {
          display: flex;
          border-bottom: 1px solid #ddd;
          margin-bottom: 2rem;
      }

      .tab-button {
          background: none;
          border: none;
          padding: 1rem 2rem;
          cursor: pointer;
          font-size: 1rem;
          color: #666;
          transition: all 0.3s ease;
      }

      .tab-button:hover,
      .tab-button.active {
          color: #2c5aa0;
          border-bottom: 3px solid #2c5aa0;
      }

      .tab-content {
          display: none;
          padding: 2rem 0;
      }

      .tab-content.active {
          display: block;
      }

      .admin-table {
          width: 100%;
          border-collapse: collapse;
          background: white;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
          border-radius: 8px;
          overflow: hidden;
      }

      .admin-table th {
          background: #f8f9fa;
          padding: 1.2rem;
          text-align: left;
          font-weight: 600;
          color: #333;
      }

      .admin-table td {
          padding: 1rem 1.2rem;
          border-bottom: 1px solid #eee;
      }

      .admin-table tr:hover {
          background: #f5f7fa;
      }

      .status-badge {
          padding: 0.4rem 0.8rem;
          border-radius: 20px;
          font-size: 0.85rem;
          font-weight: 500;
      }

      .status-active {
          background: #d4edda;
          color: #155724;
      }

      .status-delete {
          background: #fff3cd;
          color: #856404;
      }

      .status-completed {
          background: #f8dce0;
          color: #f62341;
      }

      .status-check {
          background: #dce7f8;
          color: #004085;
      }

      .table-actions {
          margin-bottom: 1.5rem;
          display: flex;
      }

      .report-cards {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: 1.5rem;
          margin-bottom: 2rem;
      }

      .report-card {
          background: white;
          padding: 1.5rem;
          border-radius: 8px;
          text-align: center;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }

      .report-value {
          font-size: 2rem;
          font-weight: 700;
          color: #2c5aa0;
          margin: 0.5rem 0;
      }

      .switch {
          position: relative;
          display: inline-block;
          width: 52px;
          height: 26px;
      }

      .switch input {
          opacity: 0;
          width: 0;
          height: 0;
      }

      .slider {
          position: absolute;
          cursor: pointer;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background-color: #ccc;
          transition: .4s;
          border-radius: 34px;
      }

      .slider:before {
          position: absolute;
          content: "";
          height: 18px;
          width: 18px;
          left: 4px;
          bottom: 4px;
          background-color: white;
          transition: .4s;
          border-radius: 50%;
      }

      input:checked + .slider {
          background-color: #2c5aa0;
      }

      input:checked + .slider:before {
          transform: translateX(26px);
      }

      .btn-danger {
          background: #dc3545;
          color: white;
      }

      .btn-danger:hover {
          background: #c82333;
      }

      .chart-container {
          background: white;
          padding: 2rem;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }

      .filter-form {
          margin-bottom: 20px;
          padding: 15px;
          background: #f8f9fa;
          border-radius: 5px;
      }

      .filter-form label {
          margin-right: 10px;
          font-weight: bold;
      }

      .filter-form select {
          padding: 8px;
          margin-right: 10px;
          border: 1px solid #ddd;
          border-radius: 4px;
      }

      .btn {
          padding: 6px 12px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
      }

      .btn-primary {
          background-color: #007bff;
          color: white;
      }

      .btn-create {
          background: #dce7f8;
          color: #004085;
          margin-bottom: 15px;
      }
      /* Стили для таблицы аукционов */
      .auctions-table {
          width: 100%;
          border-collapse: collapse;
          margin-bottom: 2rem;
          background: white;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
          border-radius: 8px;
          overflow: hidden;
      }

      .auctions-table th,
      .auctions-table td {
          padding: 1rem;
          text-align: left;
          border-bottom: 1px solid #eee;
      }

      .auctions-table th {
          background-color: #f2f2f2;
          font-weight: 600;
          color: #333;
          padding: 1.2rem;
          text-align: left;
      }

      .auctions-table tr:hover {
          background: #f5f7fa;
      }

      /* Стили для треугольничка */
      .expand-toggle {
          cursor: pointer;
          text-align: center;
          width: 40px;
      }

      .triangle {
          display: inline-block;
          transition: transform 0.3s ease;
      }

      /* Поворот треугольничка при раскрытой таблице */
      .expanded .triangle {
          transform: rotate(90deg);
      }

      /* Контейнер для таблицы лотов */
      /* Таблица лотов внутри */
      .lots-table {
          width: 100%;
          border-collapse: collapse;
      }

      .lots-table th,
      .lots-table td {
          padding: 0.75rem;
          text-align: left;
          border-bottom: 1px dashed #ddd;
      }

      .lots-table th {
          background-color: #e9ecef;
          font-size: 0.9rem;
      }

      .lots-container {
          width: 100%;
          box-sizing: border-box;
          background-color: #f8f9fa;
      }

      .lots-table-wrapper {
          padding: 1rem;
          background-color: #f8f9fa;
          border-radius: 0 0 8px 8px;
      }

      /* Убираем нижнюю границу у последней видимой строки аукциона, когда лоты открыты */
      .auction-row.expanded + tr > td {
          border-top: none;
      }

      /* Кнопка действий в таблице лотов */
      .actions-column {
          text-align: center;
          padding: 0.5rem 1rem;
      }

      .btn-view {
          background-color: #28a745;
          color: white;
          padding: 0.4rem 0.8rem;
          text-decoration: none;
          border-radius: 4px;
          display: inline-block;
          margin-right: 0.5rem;
      }

      .btn-view:hover {
          background-color: #218837;
      }

      .btn-danger {
          background: #dc3545;
          color: white;
          padding: 0.4rem 0.8rem;
          text-decoration: none;
          border-radius: 4px;
          display: inline-block;
      }

      .btn-danger:hover {
          background: #c82333;
      }
      .btn-disabled,
      button[disabled] {
          opacity: 0.6;
          pointer-events: none;
          cursor: not-allowed;
          color: #999;
          border-color: #ccc;
      }
      .pagination {
          display: flex;
          align-items: center;
          gap: 1rem;
          margin-top: 1.5rem;
          padding: 1rem 0;
          border-top: 1px solid #eee;
      }

      .pagination button {
          background: #f8f9fa;
          border: 1px solid #ddd;
          color: #333;
          padding: 0.5rem 1rem;
          cursor: pointer;
          border-radius: 4px;
      }

      .pagination button:disabled {
          opacity: 0.5;
          cursor: not-allowed;
      }

      .pagination select {
          padding: 0.5rem;
          border: 1px solid #ddd;
          border-radius: 4px;
      }

      .pagination span {
          font-weight: 500;
          color: #555;
      }
      .pagination {
          display: flex;
          align-items: center;
          gap: 1rem;
          margin-top: 1.5rem;
          padding: 1rem 0;
          border-top: 1px solid #eee;
      }

      .pagination button {
          background: #f8f9fa;
          border: 1px solid #ddd;
          color: #333;
          padding: 0.5rem 1rem;
          cursor: pointer;
          border-radius: 4px;
      }

      .pagination button:disabled {
          opacity: 0.5;
          cursor: not-allowed;
      }

      .pagination select {
          padding: 0.5rem;
          border: 1px solid #ddd;
          border-radius: 4px;
      }

      .pagination span {
          font-weight: 500;
          color: #555;
      }
      .bids-toggle {
          cursor: pointer;
          text-align: center;
          width: 40px;
      }

      .bids-container {
          width: 100%;
          box-sizing: border-box;
          background-color: #f1f3f4;
          display: none;
      }

      .bids-table-wrapper {
          padding: 1rem;
          background-color: #f1f3f4;
          border-radius: 0 0 8px 8px;
      }

      .bids-table {
          width: 100%;
          border-collapse: collapse;
      }

      .bids-table th,
      .bids-table td {
          padding: 0.75rem;
          text-align: left;
          border-bottom: 1px dashed #ccc;
      }

      .bids-table th {
          background-color: #e9ecef;
          font-size: 0.9rem;
      }
    </style>

<div class="admin-container">
    <h2>Панель управления — Администратор</h2>
    <a href="${pageContext.request.contextPath}/logout">
        <i class="fas fa-sign-out-alt dropdown-icon"></i>
        Выход
    </a>

    <!-- Вкладки навигации -->
    <div class="tab-navigation">
        <button class="tab-button" onclick="openTab(event, 'auctions')">Управление аукционами</button>
        <button class="tab-button" onclick="openTab(event, 'payments')">Платежи</button>
        <button class="tab-button" onclick="openTab(event, 'users')">Управление пользователями</button>
    </div>

    <div id="auctions" class="tab-content">
        <h2>Аукционы и лоты</h2>

        <a href="${pageContext.request.contextPath}/admin/createAuction"
           class="btn btn-create">
           + Создать новый аукцион
        </a>

        <table class="auctions-table">
            <thead>
                <tr>
                    <th></th> <!-- Для треугольничка -->
                    <th>Название аукциона</th>
                    <th>Дата начала</th>
                    <th>Дата окончания</th>
                    <th>Количество лотов</th>
                    <th>Действия</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="auction" items="${auctions}">
                    <!-- Строка аукциона -->
                    <tr class="auction-row" data-auction-id="${auction.id}">
                        <td class="expand-toggle">
                            <span class="triangle">▶</span>
                        </td>
                        <td>${fn:escapeXml(auction.title)}</td>
                        <td>${auction.startTime}</td>
                        <td>${auction.endTime}</td>
                        <td>${fn:length(auction.lots)}</td>
                        <!-- КОЛОНКА С КНОПКАМИ -->
                        <td class="actions-column">
                            <!-- Кнопка редактирования -->
                            <a href="${pageContext.request.contextPath}/admin/updateAuction/${auction.id}"
                               class="btn btn-view">Редактировать</a>
                            <!-- Кнопка удаления (только для завершённых) -->
                            <c:if test="${auction.status == 'завершен'}">
                                <a href="${pageContext.request.contextPath}/admin/deleteAuction/${auction.id}"
                           class="btn btn-danger">Удалить</a>
                            </c:if>
                        </td>
                    </tr>

                    <!-- Скрытая строка с таблицей лотов (изначально скрыта) -->
                    <tr>
                        <td colspan="6" style="padding: 0; border: none;">
                            <div class="lots-container" style="display: none;">
                                <div class="lots-table-wrapper">
                                    <table class="lots-table">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>ID</th>
                                                <th>Картина</th>
                                                <th>Автор</th>
                                                <th>Начальная цена</th>
                                                <th>Статус</th>
                                                <th>Действия</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           <c:choose>
                                               <c:when test="${not empty auction.lots}">
                                                   <c:forEach var="lot" items="${auction.lots}">
                                                       <tr class="lot-row">
                                                           <td class="bids-toggle">
                                                               <span class="triangle">▶</span>
                                                           </td>
                                                           <td>${lot.id}</td>
                                                           <td>${fn:escapeXml(lot.title)}</td>
                                                           <td>${fn:escapeXml(lot.author)}</td>
                                                           <td>${lot.startPrice} руб.</td>
                                                           <td>
                                                               <span class="status-badge ${lot.status == 'на выставке' ? 'status-active' : lot.status == 'ожидает удаления' ? 'status-delete' : lot.status == 'ожидает проверку' ? 'status-check' : 'status-completed'}">
                                                                    ${lot.status}
                                                               </span>
                                                           </td>
                                                           <td>
                                                               <a href="${pageContext.request.contextPath}/admin/updateStatus/${lot.id}"
                                                                  class="btn btn-view">Редактировать</a>
                                                               <c:if test="${lot.status == 'завершен'}">
                                                                  <a href="${pageContext.request.contextPath}/admin/determineWinner/${lot.id}"
                                                                     class="btn btn-primary" style="background-color: #28a745;">
                                                                     Определить победителя
                                                                  </a>
                                                               </c:if>
                                                           </td>
                                                       </tr>
                                                       <!-- Скрытая строка с таблицей ставок (изначально скрыта) -->
                                                       <tr>
                                                           <td colspan="7" style="padding: 0; border: none;">
                                                               <div class="bids-container" style="display: none;">
                                                                   <div class="bids-table-wrapper">
                                                               <table class="bids-table">
                                                                   <thead>
                                                                       <tr>
                                                                           <th>ID ставки</th>
                                                                           <th>Пользователь</th>
                                                                           <th>Сумма</th>
                                                                           <th>Дата ставки</th>
                                                                           <th>Действия</th>
                                                                       </tr>
                                                                   </thead>
                                                           <tbody>
                                                               <c:choose>
                                                                   <c:when test="${not empty lot.bids}">
                                                               <c:forEach var="bid" items="${lot.bids}">
                                                                   <tr>
                                                               <td>${bid.id}</td>
                                                               <td>${bid.user.email}</td>
                                                               <td>${bid.bidAmount} руб.</td>
                                                               <td>
                                                                   <fmt:formatDate value="${bid.bidDateTimeFormatted}" pattern="dd.MM.yyyy HH:mm:ss"/>
                                                               </td>
                                                               <td>
                                                                   <a href="${pageContext.request.contextPath}/admin/deleteBid/${bid.id}"
                                                                      class="btn btn-danger">Удалить ставку</a>
                                                               </td>
                                                           </tr>
                                                               </c:forEach>
                                                           </c:when>
                                                           <c:otherwise>
                                                               <tr>
                                                                   <td colspan="4" class="no-bids">На этот лот пока нет ставок</td>
                                                               </tr>
                                                           </c:otherwise>
                                                               </c:choose>
                                                           </tbody>
                                                               </table>
                                                           </div>
                                                               </div>
                                                           </td>
                                                       </tr>
                                                   </c:forEach>
                                               </c:when>
                                               <c:otherwise>
                                                   <tr>
                                                       <td colspan="6" class="no-lots">В этом аукционе нет лотов</td>
                                                   </tr>
                                               </c:otherwise>
                                           </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="pagination">
            <button class="btn" onclick="changePage('auctions', ${currentPage > 1 ? currentPage - 1 : 1})" ${currentPage == 1 ? 'disabled' : ''}>
                ‹ Назад
            </button>
            <span>Страница ${currentPage} из ${totalPages}</span>
            <button class="btn" onclick="changePage('auctions', ${currentPage < totalPages ? currentPage + 1 : totalPages})" ${currentPage == totalPages ? 'disabled' : ''}>
                Вперёд ›
            </button>
            <select onchange="changePageSize('auctions', this.value)">
                <option value="5" ${pageSize == 5 ? 'selected' : ''}>5 на страницу</option>
                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10 на страницу</option>
                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20 на страницу</option>
            </select>
        </div>
    </div>

<div id="payments" class="tab-content">
    <h2>Платежи</h2>
    <!-- Блок фильтра -->
    <div class="filter-form">
        <label for="paymentStatusFilter">Фильтр по статусу:</label>
        <select id="paymentStatusFilter" onchange="applyPaymentStatusFilter()">
            <option value="">Все статусы</option>
            <option value="не оплачен">Не оплачен</option>
            <option value="платеж принят">Платеж принят</option>
            <option value="закрыт">Закрыт</option>
        </select>
    </div>
    <table class="admin-table">
        <thead>
            <tr>
                <th>ID платежа</th>
                <th>Лот</th>
                <th>Победитель</th>
                <th>Дата</th>
                <th>Статус</th>
                <th>Сумма</th>
                <th>Действия</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="payment" items="${payments}">
                <tr>
                    <td>${payment.id}</td>
                    <td>${payment.lot.title}</td>
                    <td>${payment.user.email}</td>
                    <td>${payment.paymentDateTimeFormatted}</td>
                    <td>
                        <span class="status-badge ${payment.paymentStatus == 'закрыт' ? 'status-active' : payment.paymentStatus == 'платеж принят' ? 'status-delete' : 'status-completed'}">
                            ${payment.paymentStatus}
                        </span>
                    </td>
                    <td>${payment.amount}</td>
                    <td>
                        <!-- Кнопка уведомления -->
                        <form action="${pageContext.request.contextPath}/admin/closePayment/${payment.id}" style="display:inline;">
                            <input type="hidden" name="id" value="${payment.id}">
                            <button type="submit" class="btn btn-danger ${payment.paymentStatus == 'закрыт' ? 'btn-disabled' : ''}" ${payment.paymentStatus == 'закрыт' ? 'disabled' : ''}>Закрыть платеж</button>
                        </form>
                    </td>
                    <td>${auction.lotsCount}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination">
        <button class="btn" onclick="changePage('payments', ${currentPaymentPage > 1 ? currentPaymentPage - 1 : 1})" ${currentPaymentPage == 1 ? 'disabled' : ''}>
            ‹ Назад
        </button>
        <span>Страница ${currentPaymentPage} из ${totalPaymentPages}</span>
        <button class="btn" onclick="changePage('payments', ${currentPaymentPage < totalPaymentPages ? currentPaymentPage + 1 : totalPaymentPages})" ${currentPaymentPage == totalPaymentPages ? 'disabled' : ''}>
            Вперёд ›
        </button>
        <select onchange="changePageSize('payments', this.value)">
            <option value="5" ${paymentPageSize == 5 ? 'selected' : ''}>5 на страницу</option>
            <option value="10" ${paymentPageSize == 10 ? 'selected' : ''}>10 на страницу</option>
            <option value="20" ${paymentPageSize == 20 ? 'selected' : ''}>20 на страницу</option>
        </select>
    </div>
</div>

<div id="users" class="tab-content">
    <h2>Управление пользователями</h2>

    <a href="${pageContext.request.contextPath}/admin/createUser"
       class="btn btn-create">
       + Создать нового пользователя
    </a>

    <!-- Блок фильтра -->
    <div class="filter-form">
        <label for="userRoleFilter">Фильтр по статусу:</label>
        <select id="userRoleFilter" onchange="applyUserRoleFilter()">
            <option value="">Все статусы</option>
            <option value="USER">User</option>
            <option value="ADMIN">Admin</option>
            <option value="SELLER">Seller</option>
        </select>
    </div>
    <table class="admin-table">
        <thead>
            <tr>
                <th>ID пользователя</th>
                <th>Фамилия</th>
                <th>Имя</th>
                <th>Email</th>
                <th>Номер телефона</th>
                <th>Роль</th>
                <th>Действия</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.firstName}</td>
                    <td>${user.lastName}</td>
                    <td>${user.email}</td>
                    <td>${user.numberPhone}</td>
                    <td>
                        <span class="status-badge ${user.role.role == 'ADMIN' ? 'status-active' : user.role.role == 'SELLER' ? 'status-delete' : 'status-completed'}">
                              ${user.role.role}
                        </span>
                    </td>
                    <td>
                        <!-- Кнопка редактирования -->
                        <form action="${pageContext.request.contextPath}/admin/detailUser/${user.id}" style="display:inline;">
                              <input type="hidden" name="id" value="${user.id}">
                              <button type="submit" class="btn btn-danger">Просмотр</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination">
        <button class="btn" onclick="changePage('users', ${currentUserPage > 1 ? currentUserPage - 1 : 1})" ${currentUserPage == 1 ? 'disabled' : ''}>
            ‹ Назад
        </button>
        <span>Страница ${currentUserPage} из ${totalUserPages}</span>
        <button class="btn" onclick="changePage('users', ${currentUserPage < totalUserPages ? currentUserPage + 1 : totalUserPages})" ${currentUserPage == totalUserPages ? 'disabled' : ''}>
            Вперёд ›
        </button>
        <select onchange="changePageSize('users', this.value)">
            <option value="5" ${userPageSize == 5 ? 'selected' : ''}>5 на страницу</option>
            <option value="10" ${userPageSize == 10 ? 'selected' : ''}>10 на страницу</option>
            <option value="20" ${userPageSize == 20 ? 'selected' : ''}>20 на страницу</option>
        </select>
    </div>
</div>
</div>
<script>
function openTab(evt, tabName) {
    const tabContents = document.querySelectorAll('.tab-content');
    tabContents.forEach(tab => tab.classList.remove('active'));

    const tabButtons = document.querySelectorAll('.tab-button');
    tabButtons.forEach(button => button.classList.remove('active'));

    document.getElementById(tabName).classList.add('active');
    evt.currentTarget.classList.add('active');

    if (tabName === 'auctions') {
        initializeBidToggles();
    }
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.tab-button').click();
});
function applyStatusFilter() {
    const filterValue = document.getElementById('statusFilter').value.toLowerCase();
    const rows = document.querySelectorAll('#lots tbody tr');

    rows.forEach(row => {
        const statusCell = row.querySelector('td:nth-child(5)'); // 5-я колонка — статус
        if (!statusCell) return;

        const statusText = statusCell.textContent.trim().toLowerCase();

        if (filterValue === '' || statusText.includes(filterValue)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}
function applyAuctionStatusFilter() {
    const filterValue = document.getElementById('auctionStatusFilter').value.toLowerCase();
    const rows = document.querySelectorAll('#auctions tbody tr');

    rows.forEach(row => {
        const statusCell = row.querySelector('td:nth-child(5)'); // 5-я колонка — статус аукциона
        if (!statusCell) return;

        const statusText = statusCell.textContent.trim().toLowerCase();

        if (filterValue === '' || statusText.includes(filterValue)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}
function applyUserRoleFilter() {
    const filterValue = document.getElementById('userRoleFilter').value.toLowerCase();
    const rows = document.querySelectorAll('#users tbody tr');

    rows.forEach(row => {
        const roleCell = row.querySelector('td:nth-child(6)'); // 6-я колонка — роль
        if (!roleCell) return;

        const roleText = roleCell.textContent.trim().toLowerCase();

        if (filterValue === '' || roleText.includes(filterValue)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}
function applyPaymentStatusFilter() {
    const filterValue = document.getElementById('paymentStatusFilter').value.toLowerCase();
    const rows = document.querySelectorAll('#payments tbody tr');

    rows.forEach(row => {
        const statusCell = row.querySelector('td:nth-child(5)'); // 5-я колонка — статус
        if (!statusCell) return;

        const statusText = statusCell.textContent.trim().toLowerCase();

        if (filterValue === '' || statusText.includes(filterValue)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}
function initializeAuctionToggles() {
    const auctionToggleButtons = document.querySelectorAll('.expand-toggle');

    auctionToggleButtons.forEach(button => {
        button.addEventListener('click', function() {
            const auctionRow = this.closest('.auction-row');
            const lotsContainerRow = auctionRow.nextElementSibling;

            if (!lotsContainerRow) return;

            const lotsContainer = lotsContainerRow.querySelector('.lots-container');

            if (!lotsContainer) return;

            auctionRow.classList.toggle('expanded');
            lotsContainer.style.display = lotsContainer.style.display === 'block' ? 'none' : 'block';

            const triangle = this.querySelector('.triangle');
            if (triangle) {
                triangle.style.transform = lotsContainer.style.display === 'block' ? 'rotate(90deg)' : 'rotate(0deg)';
            }
        });
    });
}

function initializeBidToggles() {
    const bidToggleButtons = document.querySelectorAll('.bids-toggle');

    bidToggleButtons.forEach(button => {
        button.addEventListener('click', function() {
            const lotRow = this.closest('.lot-row');
            const bidsContainerRow = lotRow.nextElementSibling;

            if (!bidsContainerRow) return;

            const bidsContainer = bidsContainerRow.querySelector('.bids-container');

            if (!bidsContainer) return;

            lotRow.classList.toggle('expanded');
            bidsContainer.style.display = bidsContainer.style.display === 'block' ? 'none' : 'block';

            const triangle = this.querySelector('.triangle');
            if (triangle) {
                triangle.style.transform = bidsContainer.style.display === 'block' ? 'rotate(90deg)' : 'rotate(0deg)';
            }
        });
    });
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.tab-button').click();
    initializeAuctionToggles();
    initializeBidToggles();
});

function changePage(tabName, pageNumber) {
    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('page', pageNumber);
    window.location.href = currentUrl.toString();
}

function changePageSize(tabName, size) {
    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('size', size);
    currentUrl.searchParams.set('page', '1'); // сбрасываем на первую страницу
    window.location.href = currentUrl.toString();
}

// Обновляем фильтры с учётом текущей пагинации
function applyStatusFilter() {
    changePage('auctions', 1); // при фильтрации сбрасываем на первую страницу
}

function applyAuctionStatusFilter() {
    changePage('auctions', 1);
}

function applyUserRoleFilter() {
    changePage('users', 1);
}

function applyPaymentStatusFilter() {
    changePage('payments', 1);
}
</script>
</body>
</html>