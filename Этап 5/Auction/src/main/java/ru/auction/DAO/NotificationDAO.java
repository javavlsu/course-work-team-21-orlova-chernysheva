package ru.auction.DAO;

import ru.auction.model.*;

import java.util.List;

public class NotificationDAO {
    private DBImpl db;

    public NotificationDAO(DBImpl db) {
        this.db = db;
    }

    public void create(Notification notification) {
        db.createNotification(notification);
    }
    public void update(Notification notification) {
        db.updateNotification(notification);
    }
    public void delete (long id) {
        db.deleteNotification(id);
    }
    public Notification getById(long id) {
        return db.getNotificationById(id);
    }
    public List<Notification> getAll() {
        return db.getAllNotifications();
    }
}
