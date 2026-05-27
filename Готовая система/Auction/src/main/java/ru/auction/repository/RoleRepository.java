package ru.auction.repository;

import org.springframework.stereotype.Repository;
import ru.auction.model.Lot;
import ru.auction.model.Role;
import ru.auction.model.User;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.Optional;
@Repository
public class RoleRepository {
    @PersistenceContext
    private EntityManager entityManager;


    public Optional<Role> findById(int id) {
        return Optional.ofNullable(entityManager.find(Role.class, id));
    }

    @Transactional
    public void save(Role role) {
        entityManager.persist(role);
    }

    // Новый метод: поиск роли по ID пользователя

    public Optional<Role> findByUserId(int userId) {
        String jpql = "SELECT r FROM Role r WHERE r.user.id = :userId";

        TypedQuery<Role> query = entityManager.createQuery(jpql, Role.class);
        query.setParameter("userId", userId);

        try {
            Role role = query.getSingleResult();
            return Optional.of(role);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Transactional
    public void deleteByUserId(Integer userId) {
        String jpql = "DELETE FROM Role r WHERE r.user.id = :userId";

        javax.persistence.Query query = entityManager.createQuery(jpql);
        query.setParameter("userId", userId);

        int deletedCount = query.executeUpdate();
        // Можно добавить логирование: "Удалено ролей: " + deletedCount
    }
}
