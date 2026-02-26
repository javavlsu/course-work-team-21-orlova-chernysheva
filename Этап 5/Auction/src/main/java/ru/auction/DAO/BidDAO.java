package ru.auction.DAO;

import ru.auction.model.*;

import java.util.List;

public class BidDAO {
    private DBImpl db;

    public BidDAO(DBImpl db) {
        this.db = db;
    }
    public void create(Bid bid) {
        db.createBid(bid);
    }
    public void update(Bid bid) {
        db.updateBid(bid);
    }
    public void delete (long id) {
        db.deleteBid(id);
    }
    public Bid getById(long id) {
        return db.getBidById(id);
    }
    public List<Bid> getAll() {
        return db.getAllBids();
    }
}
