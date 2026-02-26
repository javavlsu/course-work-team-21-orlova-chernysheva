package ru.auction.DAO;

import ru.auction.model.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBImpl {
    private Map<Long, User> users = new HashMap<>();
    private Map<Long, Lot> lots = new HashMap<>();
    private Map<Long, Bid> bids = new HashMap<>();
    private Map<Long, Notification> notifications = new HashMap<>();
    private Map<Long, Auction> auctions = new HashMap<>();
    private Map<Long, Payment> payments = new HashMap<>();

    private long userIdCounter = 1;
    private long lotIdCounter = 1;
    private long bidIdCounter = 1;
    private long notificationIdCounter = 1;
    private long auctionIdCounter = 1;
    private long paymentIdCounter = 1;

    // Пользователи
    public User createUser(User user) {
        user.setId(userIdCounter++);
        users.put(user.getId(), user);
        return user;
    }
    public void updateUser(User user) {
        users.put(user.getId(), user);
    }
    public void deleteUser(long id) {
        users.remove(id);
    }
    public List<User> getAllUsers() {
        return new ArrayList<>(users.values());
    }
    public User getUserById(long id) {
        return users.get(id);
    }

    // Лоты
    public Lot createLot(Lot lot) {
        lot.setId(lotIdCounter++);
        lots.put(lot.getId(), lot);
        return lot;
    }
    public void updateLot(Lot lot) {
        lots.put(lot.getId(), lot);
    }
    public void deleteLot(long id) {
        lots.remove(id);
    }
    public List<Lot> getAllLots() {
        return new ArrayList<>(lots.values());
    }
    public Lot getLotById(long id) {
        return lots.get(id);
    }

    // Ставки
    public Bid createBid(Bid bid) {
        bid.setId(bidIdCounter++);
        bids.put(bid.getId(), bid);
        return bid;
    }
    public void updateBid(Bid bid) {
        bids.put(bid.getId(), bid);
    }
    public void deleteBid(long id) {
        bids.remove(id);
    }
    public List<Bid> getAllBids() {
        return new ArrayList<>(bids.values());
    }
    public Bid getBidById(long id) {
        return bids.get(id);
    }

    // Уведомления
    public Notification createNotification(Notification notif) {
        notif.setId(notificationIdCounter++);
        notifications.put(notif.getId(), notif);
        return notif;
    }
    public void updateNotification(Notification notif) {
        notifications.put(notif.getId(), notif);
    }
    public void deleteNotification(long id) {
        notifications.remove(id);
    }
    public List<Notification> getAllNotifications() {
        return new ArrayList<>(notifications.values());
    }
    public Notification getNotificationById(long id) {
        return notifications.get(id);
    }

    // Платежи
    public Payment createPayment(Payment payment) {
        payment.setId(paymentIdCounter++);
        payments.put(payment.getId(), payment);
        return payment;
    }
    public void updatePayment(Payment payment) {
        payments.put(payment.getId(), payment);
    }

    public void deletePayment(long id) {
        payments.remove(id);
    }
    public List<Payment> getAllPayments() {
        return new ArrayList<>(payments.values());
    }
    public Payment getPaymentById(long id) {
        return payments.get(id);
    }

    // Аукционы
    public Auction createAuction(Auction auction) {
        auction.setId(auctionIdCounter++);
        auctions.put(auction.getId(), auction);
        return auction;
    }

    public void updateAuction(Auction auction) {
        auctions.put(auction.getId(), auction);
    }

    public void deleteAuction(long id) {
        auctions.remove(id);
    }

    public List<Auction> getAllAuction() {
        return new ArrayList<>(auctions.values());
    }

    public Auction getAuctionById(long id) {
        return auctions.get(id);
    }
}
