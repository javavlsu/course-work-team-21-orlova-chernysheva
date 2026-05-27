package ru.auction.model;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "lot")
public class Lot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "title")
    private String title;
    @Column(name = "author")
    private String Author;
    @Column(name = "description")
    private String description;
    @Column(name = "image")
    private String image;
    @Column(name = "startPrice")
    private Double startPrice;

    @Column(name = "currentPrice")
    private Double currentPrice;
    @Column(name = "status")
    private String status;
    @Column(name = "dateAdded")
    private LocalDateTime dateAdded;
    @OneToOne(mappedBy = "lot")
    private Payment payment;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sellerId")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "auctionId")
    private Auction auction;

    @OneToMany(mappedBy = "lot", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Bid> bids = new ArrayList<>();

    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
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

    public void setCurrentPrice(Double currentPrice) {
        this.currentPrice = currentPrice;
    }
    public Double getCurrentPrice() {
        return currentPrice;
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

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    // Геттеры и сеттеры
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Auction getAuction() {
        return auction;
    }

    public void setAuction(Auction auction) {
        this.auction = auction;
    }

    public List<Bid> getBids() {
        return bids;
    }

    public void setBids(List<Bid> bids) {
        this.bids = bids;
    }

    @Transient
    private java.util.Date endTimeFormatted;

    // ИЗМЕНИТЬ: добавить public
    public java.util.Date getEndTimeFormatted() {
        return endTimeFormatted;
    }

    // ИЗМЕНИТЬ: добавить public
    public void setEndTimeFormatted(java.util.Date endTimeFormatted) {
        this.endTimeFormatted = endTimeFormatted;
    }
}
