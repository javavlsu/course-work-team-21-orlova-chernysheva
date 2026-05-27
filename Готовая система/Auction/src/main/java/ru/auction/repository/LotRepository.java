package ru.auction.repository;

import org.springframework.stereotype.Repository;
import ru.auction.DTO.LotDTO;
import ru.auction.model.Auction;
import ru.auction.model.Lot;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public class LotRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public List<Lot> findAll() {
        return entityManager
                .createQuery("FROM Lot", Lot.class)
                .getResultList();
    }

    public Optional<Lot> findById(int id) {
        return Optional.ofNullable(entityManager.find(Lot.class, id));
    }

    @Transactional
    public void save(Lot lot) {
        if (lot.getId() == 0) {
            entityManager.persist(lot);
        } else {
            entityManager.merge(lot);
        }
    }

    @Transactional
    public void deleteById(int id) {
        Optional<Lot> lotOptional = findById(id);
        lotOptional.ifPresent(entityManager::remove);
    }

    @Transactional
    public void deleteBySellerId(int id) {
        List<Lot> lots = findBySellerId(id);
        for (Lot lot : lots) {
            entityManager.remove(lot);
        }
    }

    public List<Lot> findByStatus(String status) {
        return entityManager
                .createQuery("SELECT l FROM Lot l WHERE l.status = :status", Lot.class)
                .setParameter("status", status)
                .getResultList();
    }

    public List<Lot> findBySellerId(int sellerId) {
        return entityManager
                .createQuery("SELECT l FROM Lot l WHERE l.user.id = :sellerId", Lot.class)
                .setParameter("sellerId", sellerId)
                .getResultList();
    }

    public List<Lot> findByAuctionId(int auctionId) {
        return entityManager
                .createQuery("FROM Lot l WHERE l.auction.id = :auctionId", Lot.class)
                .setParameter("auctionId", auctionId)
                .getResultList();
    }


    @Transactional
    public int updateStatusById(int id, String status) {
        return entityManager.createQuery(
                        "UPDATE Lot l SET l.status = :status WHERE l.id = :id")
                .setParameter("id", id)
                .setParameter("status", status)
                .executeUpdate();
    }

    public int countByAuctionId(int auctionId) {
        return ((Long) entityManager
                .createQuery("SELECT COUNT(l) FROM Lot l WHERE l.auction.id = :auctionId")
                .setParameter("auctionId", auctionId)
                .getSingleResult())
                .intValue();
    }

    // НОВЫЙ МЕТОД: подсчёт общего количества лотов по статусу
    public long countByStatus(String status) {
        return (Long) entityManager
                .createQuery("SELECT COUNT(l) FROM Lot l WHERE l.status = :status")
                .setParameter("status", status)
                .getSingleResult();
    }

    // НОВЫЙ МЕТОД: выборка лотов с пагинацией
    public List<Lot> findByStatusWithPagination(String status, int offset, int limit) {
        return entityManager
                .createQuery("SELECT l FROM Lot l WHERE l.status = :status ORDER BY l.id", Lot.class)
                .setParameter("status", status)
                .setFirstResult(offset)  // эквивалент OFFSET
                .setMaxResults(limit)   // эквивалент LIMIT
                .getResultList();
    }

}
