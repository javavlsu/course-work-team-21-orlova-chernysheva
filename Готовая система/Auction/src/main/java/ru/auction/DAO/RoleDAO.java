package ru.auction.DAO;

import ru.auction.model.Role;

import java.sql.SQLException;
import java.util.List;

public interface RoleDAO {
    void create(Role role) throws SQLException;
    boolean update(Role role) throws SQLException;
    boolean delete (int id) throws SQLException;
    Role getById(int id) throws SQLException;
    List<Role> getAll() throws SQLException;
}
