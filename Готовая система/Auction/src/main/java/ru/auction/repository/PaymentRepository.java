package ru.auction.repository;

import org.springframework.stereotype.Repository;
import ru.auction.model.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public class PaymentRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public List<Payment> findAll() {
        return entityManager
                .createQuery("FROM Payment", Payment.class)
                .getResultList();
    }

    public List<Payment> findAllWithDetails() {
        return entityManager
                .createQuery(
                        "SELECT DISTINCT p FROM Payment p " +
                                "JOIN FETCH p.user " +
                                "JOIN FETCH p.lot",
                        Payment.class
                )
                .getResultList();
    }

    public Optional<Payment> findById(int id) {
        return Optional.ofNullable(entityManager.find(Payment.class, id));
    }

    @Transactional
    public Payment save(Payment payment) {
        payment = entityManager.merge(payment);
        return payment;
    }

    @Transactional
    public void deleteById(int id) {
        Optional<Payment> paymentOptional = findById(id);
        paymentOptional.ifPresent(entityManager::remove);
    }

    public Optional<Payment> findByLot(Lot lot) {
        List<Payment> payments = entityManager
                .createQuery("SELECT p FROM Payment p WHERE p.lot = :lot", Payment.class)
                .setParameter("lot", lot)
                .getResultList();

        return payments.isEmpty() ? Optional.empty() : Optional.of(payments.get(0));
    }

    public long count() {
        return entityManager
                .createQuery("SELECT COUNT(p) FROM Payment p", Long.class)
                .getSingleResult();
    }


    public List<Payment> findWithPagination(int offset, int size) {
        // Загрузка данных с пагинацией и жадной загрузкой связанных сущностей
        List<Payment> payments = entityManager
                .createQuery(
                        "SELECT p FROM Payment p " +
                                "JOIN FETCH p.user " +
                                "JOIN FETCH p.lot " +
                                "ORDER BY p.id ASC",
                        Payment.class
                )
                .setFirstResult(offset)
                .setMaxResults(size)
                .getResultList();

        return payments;
    }
}
