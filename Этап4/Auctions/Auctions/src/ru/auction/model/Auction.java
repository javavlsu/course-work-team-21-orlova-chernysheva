package ru.auction.model;

import java.time.LocalDateTime;

public class Auction {
    private long id;
    private Lot lotId;
    private User sellerId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String status;

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

    public void setSellerId(User sellerId) {
        this.sellerId = sellerId;
    }
    public User getSellerId() {
        return sellerId;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }
    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }
    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getStatus() {
        return status;
    }
}
