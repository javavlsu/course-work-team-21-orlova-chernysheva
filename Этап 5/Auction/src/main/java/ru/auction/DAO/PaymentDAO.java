package ru.auction.DAO;

import ru.auction.model.*;

import java.util.List;

public class PaymentDAO {
    private DBImpl db;

    public PaymentDAO(DBImpl db) {
        this.db = db;
    }
    public void create(Payment payment) {
        db.createPayment(payment);
    }
    public void update(Payment payment) {
        db.updatePayment(payment);
    }
    public void delete (long id) {
        db.deletePayment(id);
    }
    public Payment getById(long id) {
        return db.getPaymentById(id);
    }
    public List<Payment> getAll() {

        return db.getAllPayments();
    }
}
