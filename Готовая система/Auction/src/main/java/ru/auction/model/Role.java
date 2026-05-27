package ru.auction.model;

import javax.persistence.*;

@Entity
@Table(name = "role")
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "role", nullable = false)
    private String role;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false, unique = true)
    private User user;

    // Геттеры и сеттеры
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // Геттер и сеттер для пользователя
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    /*@Override
    public String toString() {
        return "Roles{" +
                "id=" + id +
                ", role='" + role + '\'' +
                // Не выводим user, чтобы избежать бесконечной рекурсии, если user.toString() тоже выводит roles
                '}';
    }*/
}
