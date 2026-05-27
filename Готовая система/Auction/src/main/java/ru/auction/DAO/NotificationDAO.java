package ru.auction.DAO;

import ru.auction.model.Notification;

import java.sql.SQLException;
import java.util.List;

public interface NotificationDAO {
    void create(Notification notification) throws SQLException;
    boolean update(Notification notification) throws SQLException;
    boolean delete (int id) throws SQLException;
    Notification getById(int id) throws SQLException;
    List<Notification> getAll() throws SQLException;
}
