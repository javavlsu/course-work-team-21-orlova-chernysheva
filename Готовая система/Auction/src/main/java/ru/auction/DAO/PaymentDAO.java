package ru.auction.DAO;

import ru.auction.model.*;

import java.sql.SQLException;
import java.util.List;

public interface PaymentDAO {

    void create(Payment payment) throws SQLException;
    boolean update(Payment payment) throws SQLException;
    boolean delete (int id) throws SQLException;
    Payment getById(int id) throws SQLException;
    List<Payment> getAll() throws SQLException;
}
