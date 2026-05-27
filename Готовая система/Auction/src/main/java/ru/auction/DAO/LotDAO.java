package ru.auction.DAO;

import ru.auction.model.*;

import java.sql.SQLException;
import java.util.List;

public interface LotDAO {
    void create(Lot lot) throws SQLException;
    boolean update(Lot lot) throws SQLException;
    boolean delete (int id) throws SQLException;
    Lot getById(int id) throws SQLException;
    List<Lot> getAll() throws SQLException;
}
