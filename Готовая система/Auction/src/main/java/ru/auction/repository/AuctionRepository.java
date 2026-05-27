package ru.auction.repository;

import org.springframework.stereotype.Repository;
import ru.auction.model.Auction;
import ru.auction.model.Lot;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public class AuctionRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public List<Auction> findAll() {
        return entityManager
                .createQuery("FROM Auction", Auction.class)
                .getResultList();
    }

    public Optional<Auction> findById(int id) {
        return Optional.ofNullable(entityManager.find(Auction.class, id));
    }

    @Transactional
    public void save(Auction auction) {
        entityManager.merge(auction);
    }

    @Transactional
    public void deleteById(int id) {
        Optional<Auction> auctionOptional = findById(id);
        auctionOptional.ifPresent(entityManager::remove);
    }

    public List<Auction> findByStatus(String status) {
        return entityManager
                .createQuery("SELECT a FROM Auction a WHERE a.status = :status", Auction.class)
                .setParameter("status", status)
                .getResultList();
    }

    // Подсчёт с теми же условиями, что и выборка
    public long countByStatus(String status) {
        return (Long) entityManager
                .createQuery("SELECT COUNT(a) FROM Auction a WHERE a.status = :status")
                .setParameter("status", status)
                .getSingleResult();
    }

    public long count() {
        return entityManager
                .createQuery("SELECT COUNT(a) FROM Auction a", Long.class)
                .getSingleResult();
    }

    //запрос с сортировкой
    public List<Auction> findByStatusWithPagination(String status, int offset, int limit) {
        return entityManager
                .createQuery("SELECT a FROM Auction a WHERE a.status = :status ORDER BY a.id ASC", Auction.class)
                .setParameter("status", status)
                .setFirstResult(offset)
                .setMaxResults(limit)
                .getResultList();
    }

    public List<Auction> findWithPagination(int offset, int size) {
        // Загрузка данных с пагинацией
        List<Auction> auctions = entityManager
                .createQuery("SELECT a FROM Auction a ORDER BY a.id ASC", Auction.class)
                .setFirstResult(offset)
                .setMaxResults(size)
                .getResultList();

        // Подсчёт общего количества — тип Long.class!
        Long totalCount = entityManager
                .createQuery("SELECT COUNT(a) FROM Auction a", Long.class)
                .getSingleResult();

        return auctions;
    }
}
