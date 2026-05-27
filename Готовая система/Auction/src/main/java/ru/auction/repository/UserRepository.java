package ru.auction.repository;

import org.springframework.stereotype.Repository;
import ru.auction.model.Auction;
import ru.auction.model.Lot;
import ru.auction.model.Payment;
import ru.auction.model.User;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
@Repository
public class UserRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public Optional<User> findByUsername(String login) {
        try {
            CriteriaBuilder cb = entityManager.getCriteriaBuilder();
            CriteriaQuery<User> cq = cb.createQuery(User.class);
            Root<User> root = cq.from(User.class);

            cq.select(root).where(cb.equal(root.get("login"), login));

            User user = entityManager.createQuery(cq).getSingleResult();
            return Optional.of(user);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    public boolean existsByUsernameAndPassword(String login, String password) {
        Long count = entityManager
                .createQuery("SELECT count(u) FROM User u WHERE u.login = :login AND u.password = :password", Long.class)
                .setParameter("login", login)
                .setParameter("password", password)
                .getSingleResult();
        return count != null && count > 0;
    }

    public boolean existsByUsername(String login) {
        Long count = entityManager
                .createQuery("SELECT count(u) FROM User u WHERE u.login = :login", Long.class)
                .setParameter("login", login)
                .getSingleResult();
        return count != null && count > 0;
    }

    public User save(User user) {
        entityManager.merge(user);
        return user;
    }

    public void deleteByUsername(String login) {
        Optional<User> user = findByUsername(login);
        user.ifPresent(entityManager::remove);
    }

    public List<User> findAll() {
        return entityManager
                .createQuery("FROM User", User.class)
                .getResultList();
    }

    public Optional<User> findById(int id) {
        return Optional.ofNullable(entityManager.find(User.class, id));
    }

    public Optional<User> findByIdWithRole(int id) {
        try {
            User user = entityManager
                    .createQuery("SELECT u FROM User u LEFT JOIN FETCH u.role WHERE u.id = :id", User.class)
                    .setParameter("id", id)
                    .getSingleResult();
            return Optional.of(user);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Transactional
    public void deleteById(int id) {
        Optional<User> userOptional = findById(id);
        userOptional.ifPresent(entityManager::remove);
    }

    public long count() {
        return entityManager
                .createQuery("SELECT COUNT(u) FROM User u", Long.class)
                .getSingleResult();
    }

    public List<User> findWithPagination(int offset, int size) {
        // Загрузка данных с пагинацией
        List<User> users = entityManager
                .createQuery("SELECT u FROM User u ORDER BY u.id ASC", User.class)
                .setFirstResult(offset)
                .setMaxResults(size)
                .getResultList();

        // Подсчёт общего количества — тип Long.class!
        Long totalCount = entityManager
                .createQuery("SELECT COUNT(u) FROM User u", Long.class)
                .getSingleResult();

        return users;
    }
}
