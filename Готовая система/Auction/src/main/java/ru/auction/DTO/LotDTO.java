package ru.auction.DTO;

import ru.auction.model.Payment;

import java.time.LocalDateTime;
import java.util.Date;

public class LotDTO {
    private int id;
    private String title;

    private String Author;

    private String description;

    private Double startPrice;

    private Double currentPrice;

    private String status;
    private LocalDateTime endTimeFormatted;

    private String winnerEmail;
    private double winnerBidAmount;

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public int getId() {
        return id;
    }

    public LocalDateTime getEndTimeFormatted() {
        return endTimeFormatted;
    }

    public void setEndTimeFormatted(LocalDateTime endTimeFormatted) {
        this.endTimeFormatted = endTimeFormatted;
    }

    public void setStartPrice(Double startPrice) {
        this.startPrice = startPrice;
    }
    public Double getStartPrice() {
        return startPrice;
    }

    public void setCurrentPrice(Double currentPrice) {
        this.currentPrice = currentPrice;
    }
    public Double getCurrentPrice() {
        return currentPrice;
    }

    public void setAuthor(String Author) {
        this.Author = Author;
    }
    public String getAuthor() {
        return Author;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public String getDescription() {
        return description;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getStatus() {
        return status;
    }

    public String getWinnerEmail() {
        return winnerEmail;
    }
    public void setWinnerEmail(String winnerEmail) {
        this.winnerEmail = winnerEmail;
    }

    public double getWinnerBidAmount() {
        return winnerBidAmount;
    }
    public void setWinnerBidAmount(double winnerBidAmount) {
        this.winnerBidAmount = winnerBidAmount;
    }
}
