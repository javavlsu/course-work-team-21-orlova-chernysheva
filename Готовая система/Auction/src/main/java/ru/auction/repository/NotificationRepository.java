package ru.auction.repository;

import org.springframework.stereotype.Repository;
import ru.auction.model.Lot;
import ru.auction.model.Notification;
import ru.auction.model.User;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public class NotificationRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public List<Notification> findAll() {
        return entityManager
                .createQuery("FROM Notification n ORDER BY n.admission DESC", Notification.class)
                .getResultList();
    }

    public Optional<Notification> findById(int id) {
        return Optional.ofNullable(entityManager.find(Notification.class, id));
    }

    @Transactional
    public void save(Notification notification) {
        if (notification.getId() == 0) {
            entityManager.persist(notification);
        } else {
            entityManager.merge(notification);
        }
    }

    @Transactional
    public void deleteById(int id) {
        Optional<Notification> notificationOptional = findById(id);
        notificationOptional.ifPresent(entityManager::remove);
    }

    public List<Notification> findByUserOrderByAdmissionDateDesc(User user) {
        TypedQuery<Notification> query = entityManager.createQuery(
                "SELECT n FROM Notification n WHERE n.user = :user ORDER BY n.admission DESC",
                Notification.class
        );
        query.setParameter("user", user);
        return query.getResultList();
    }
}

