package ru.auction.repository;

import org.springframework.stereotype.Repository;
import ru.auction.model.Bid;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public class BidRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public List<Bid> findAll() {
        return entityManager
                .createQuery("FROM Bid", Bid.class)
                .getResultList();
    }

    public Optional<Bid> findById(int id) {
        return Optional.ofNullable(entityManager.find(Bid.class, id));
    }

    @Transactional
    public void deleteById(int id) {
        Optional<Bid> bidOptional = findById(id);
        bidOptional.ifPresent(entityManager::remove);
    }

    /**
     * Поиск ставок по ID лота с жадной загрузкой пользователя
     */
    public List<Bid> findBidsByLotIdWithUser(int lotId) {
        String jpql = "SELECT b FROM Bid b " +
                "JOIN FETCH b.user " + // Жадная загрузка пользователя
                "WHERE b.lot.id = :lotId " +
                "ORDER BY b.bidDateTime DESC";
        return entityManager.createQuery(jpql, Bid.class)
                .setParameter("lotId", lotId)
                .getResultList();
    }

    /**
     * Старый метод (без жадной загрузки) — можно оставить для других сценариев
     */
    @Deprecated
    public List<Bid> findBidsByLotId(int lotId) {
        String jpql = "SELECT b FROM Bid b " +
                "WHERE b.lot.id = :lotId " +
                "ORDER BY b.bidDateTime DESC"; // Исправлено: ORDER BY
        return entityManager.createQuery(jpql, Bid.class)
                .setParameter("lotId", lotId)
                .getResultList();
    }

    @Transactional
    public void save(Bid bid) {
        entityManager.persist(bid);
    }


    /**
     * Поиск ставки с максимальной суммой для указанного лота
     * @param lotId ID лота
     * @return Optional<Bid> — ставка с максимальной суммой или пустой Optional, если ставок нет
     */
    public Optional<Bid> findTopBidByLotId(int lotId) {
        String jpql = "SELECT b FROM Bid b " +
                "JOIN FETCH b.user " + // Жадная загрузка пользователя
                "WHERE b.lot.id = :lotId " +
                "ORDER BY b.bidAmount DESC"; // Сортировка по сумме ставки (убывание)

        List<Bid> bids = entityManager.createQuery(jpql, Bid.class)
                .setParameter("lotId", lotId)
                .setMaxResults(1) // Берём только первую запись (с максимальной суммой)
                .getResultList();

        return bids.isEmpty() ? Optional.empty() : Optional.of(bids.get(0));
    }

    /**
     * Поиск ставки пользователя по лоту
     * @param lotId ID лота
     * @param userId ID пользователя
     * @return Optional<Bid> — ставка пользователя по лоту или пустой Optional
     */
    public Optional<Bid> findByLotIdAndUserId(int lotId, int userId) {
        String jpql = "SELECT b FROM Bid b " +
                "WHERE b.lot.id = :lotId AND b.user.id = :userId";

        List<Bid> bids = entityManager.createQuery(jpql, Bid.class)
                .setParameter("lotId", lotId)
                .setParameter("userId", userId)
                .getResultList();

        return bids.isEmpty() ? Optional.empty() : Optional.of(bids.get(0));
    }
}
