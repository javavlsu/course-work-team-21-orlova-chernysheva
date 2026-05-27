package ru.auction.model;

import javax.persistence.*;
import java.time.LocalDateTime;
@Entity
@Table(name = "notification")
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "content")
    private String content;
    @Column(name = "admission")
    private LocalDateTime admission;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bidId", nullable = false) // ManyToOne + JoinColumn
    private Bid bid;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
    }

    public void setContent(String content) {
        this.content = content;
    }
    public String getContent() {
        return content;
    }

    public LocalDateTime getAdmission() {
        return admission;
    }

    public void setAdmission(LocalDateTime DateTime)  {this.admission = DateTime;}

    public Bid getBid() {
        return bid;
    }

    public void setBid(Bid bid) {
        this.bid = bid;
    }
}
