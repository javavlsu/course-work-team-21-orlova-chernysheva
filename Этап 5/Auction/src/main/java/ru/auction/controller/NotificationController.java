package ru.auction.controller;

import ru.auction.DAO.NotificationDAO;
import ru.auction.model.Notification;

import java.util.List;

public class NotificationController {

    private NotificationDAO notificationDAO;

    public NotificationController(NotificationDAO notificationDAO) {
        this.notificationDAO = notificationDAO;
    }

    public void createNotification(Notification notification) {
        System.out.println("Create notification: " + notification);
        notificationDAO.create(notification);
    }

    public void updateNotification(Notification notification) {
        System.out.println("Update notification: " + notification);
        notificationDAO.update(notification);
    }

    public void deleteNotification(long id) {
        System.out.println("Delete notification with id: " + id);
        notificationDAO.delete(id);
    }

    public Notification getNotificationById(long id) {
        System.out.println("Get notification by id: " + id);
        return notificationDAO.getById(id);
    }

    public List<Notification> getAllNotifications() {
        System.out.println("Get all notifications");
        return notificationDAO.getAll();
    }
}
