package ru.auction.model;

import java.time.LocalDateTime;

public class Bid {
    private long id;
    private Lot lotId;
    private User userId;
    private double bidAmount;
    private LocalDateTime bidDateTime;

    public void setId(long id) {
        this.id = id;
    }
    public long getId() {
        return id;
    }

    public void setLotId(Lot lotId) {
        this.lotId = lotId;
    }
    public Lot getLotId() {
        return lotId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }
    public User getUserId() {
        return userId;
    }

    public void setBidAmount(double bidAmount) {
        this.bidAmount = bidAmount;
    }
    public double getBidAmount() {
        return bidAmount;
    }

    public void setBidDateTime(LocalDateTime bidDateTime) {
        this.bidDateTime = bidDateTime;
    }
    public LocalDateTime getBidDateTime() {
        return bidDateTime;
    }
}
