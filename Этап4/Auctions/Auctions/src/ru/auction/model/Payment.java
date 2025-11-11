package ru.auction.model;

import java.time.LocalDateTime;

public class Payment {
    private long id;
    private User winnerId;
    private Lot lotId;
    private Double amount;
    private String paymentStatus;
    private LocalDateTime paymentDate;

    public void setId(long id) {
        this.id = id;
    }

    public void setLotId(Lot lotId) {
        this.lotId = lotId;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public void setWinnerId(User winnerId) {
        this.winnerId = winnerId;
    }

    public long getId() {
        return id;
    }

    public Lot getLotId() {
        return lotId;
    }

    public Double getAmount() {
        return amount;
    }

    public User getWinnerId() {
        return winnerId;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }
}
