package ru.auction.DAO;

import ru.auction.model.*;

import java.sql.SQLException;
import java.util.List;

public interface BidDAO {
    void create(Bid bid) throws SQLException;
    boolean update(Bid bid) throws SQLException;
    boolean delete (int id) throws SQLException;
    Bid getById(int id) throws SQLException;
    List<Bid> getAll() throws SQLException;
}
