package ru.auction.model;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@Entity
@Table(name = "payment")
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "amount")
    private Double amount;
    @Column(name = "paymentStatus")
    private String paymentStatus;
    @Column(name = "paymentDate")
    private LocalDateTime paymentDate;

    @OneToOne
    @JoinColumn(name = "lotId", unique = true, nullable = false)
    private Lot lot;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "winnerId", nullable = false)
    private User user;

    public void setId(int id) {
        this.id = id;
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

    public int getId() {
        return id;
    }

    public Double getAmount() {
        return amount;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public Lot getLot() {
        return lot;
    }

    public void setLot(Lot lot) {
        this.lot = lot;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    private String paymentDateTimeFormatted;

    public String getPaymentDateTimeFormatted() {
        return paymentDate != null
                ? paymentDate.format(DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm"))
                : "";
    }

}
