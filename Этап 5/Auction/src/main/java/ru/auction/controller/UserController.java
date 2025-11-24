package ru.auction.controller;

import ru.auction.DAO.UserDAO;
import ru.auction.model.User;

import java.util.List;

public class UserController {
    private UserDAO userDAO;

    public UserController(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public void createUser(User user) {
        System.out.println("Create user: " + user);
        userDAO.create(user);
    }

    public void updateUser(User user) {
        System.out.println("Update user: " + user);
        userDAO.update(user);
    }

    public void deleteUser(long id) {
        System.out.println("Delete user with id: " + id);
        userDAO.delete(id);
    }

    public User getUserById(long id) {
        System.out.println("Get user by id: " + id);
        return userDAO.getById(id);
    }

    public List<User> getAllUsers() {
        System.out.println("Get all users");
        return userDAO.getAll();
    }
}
