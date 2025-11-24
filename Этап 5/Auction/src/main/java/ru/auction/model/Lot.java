package ru.auction.model;

import java.time.LocalDateTime;

public class Lot {
    private Long id;
    private String title;
    private String Author;
    private String description;
    private String image;
    private Double startPrice;
    private Double currentBid;
    private String status;
    private LocalDateTime dateAdded;

    public void setId(Long id) {
        this.id = id;
    }
    public Long getId() {
        return id;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public String getTitle() {
        return title;
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

    public void setImage(String image) {
        this.image = image;
    }
    public String getImage() {
        return image;
    }

    public void setStartPrice(Double startPrice) {
        this.startPrice = startPrice;
    }
    public Double getStartPrice() {
        return startPrice;
    }

    public void setCurrentBid(Double currentBid) {
        this.currentBid = currentBid;
    }
    public Double getCurrentBid() {
        return currentBid;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getStatus() {
        return status;
    }

    public void setDateAdded(LocalDateTime dateAdded) {
        this.dateAdded = dateAdded;
    }
    public LocalDateTime getDateAdded() {
        return dateAdded;
    }
}
