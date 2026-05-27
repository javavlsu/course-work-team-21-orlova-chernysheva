package ru.auction.model;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "bid")
public class Bid {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "amount")
    private double bidAmount;
    @Column(name = "bidDate")
    private LocalDateTime bidDateTime;

    @ManyToOne(fetch = FetchType.LAZY) // Ленивая загрузка отношений
    @JoinColumn(name = "lotId") // Указываем столбец внешнего ключа
    private Lot lot;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;


    @OneToMany(mappedBy = "bid", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Notification> notifications = new ArrayList<>();

    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setLot(Lot lot) {
        this.lot = lot;
    }

    public Lot getLot() {
        return lot;
    }

    private Date bidDateTimeFormatted; // Для JSP

    public Date getBidDateTimeFormatted() {
        return bidDateTimeFormatted;
    }

    public void setBidDateTimeFormatted(Date bidDateTimeFormatted) {
        this.bidDateTimeFormatted = bidDateTimeFormatted;
    }

    public List<Notification> getNotification() {
        return notifications;
    }

    public void setNotification(Notification notification) {
        this.notifications = notifications;
    }
}
