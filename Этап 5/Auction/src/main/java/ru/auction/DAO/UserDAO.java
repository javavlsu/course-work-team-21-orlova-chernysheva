package ru.auction.DAO;
import ru.auction.model.*;

import java.util.List;

public class UserDAO {
    private DBImpl db;

    public UserDAO(DBImpl db) {
        this.db = db;
    }

    public void create(User user) {
        db.createUser(user);
    }
    public void update(User user) {
        db.updateUser(user);
    }
    public void delete (long id) {
        db.deleteUser(id);
    }
    public User getById(long id) {

        return db.getUserById(id);
    }

    public List<User> getAll() {
        return db.getAllUsers();
    }
}
