package ru.auction.DAO;
import ru.auction.model.*;

import java.sql.SQLException;
import java.util.List;

public interface UserDAO {

    void create(User user) throws SQLException;
    boolean update(User user) throws SQLException;
    boolean delete (int id) throws SQLException;
    User getById(int id) throws SQLException;
    List<User> getAll() throws SQLException;
}
