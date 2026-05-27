package ru.auction.DAO;

import ru.auction.model.*;

import java.sql.SQLException;
import java.util.List;

public interface AuctionDAO {
    void create(Auction auction) throws SQLException;
    boolean update(Auction auction) throws SQLException;
    boolean delete (int id) throws SQLException;
    Auction getById(int id) throws SQLException;
    List<Auction> getAll() throws SQLException;
}
