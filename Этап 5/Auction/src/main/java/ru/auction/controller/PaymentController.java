package ru.auction.controller;

import ru.auction.DAO.PaymentDAO;
import ru.auction.model.Auction;
import ru.auction.model.Payment;

import java.util.List;

public class PaymentController {

    private PaymentDAO paymentDAO;

    public PaymentController(PaymentDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
    }

    public void createPayment(Payment payment) {
        System.out.println("Create payment: " + payment);
        paymentDAO.create(payment);
    }

    public void updatePayment(Payment payment) {
        System.out.println("Update payment: " + payment);
        paymentDAO.update(payment);
    }

    public void deletePayment(long id) {
        System.out.println("Delete payment with id: " + id);
        paymentDAO.delete(id);
    }

    public Payment getPaymentById(long id) {
        System.out.println("Get payment by id: " + id);
        return paymentDAO.getById(id);
    }

    public List<Payment> getAllPayments() {
        System.out.println("Get all payments");
        return paymentDAO.getAll();
    }
}
