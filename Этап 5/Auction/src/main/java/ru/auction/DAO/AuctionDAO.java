package ru.auction.DAO;

import ru.auction.model.*;

import java.util.List;

public class AuctionDAO {
    private DBImpl db;

    public AuctionDAO(DBImpl db) {
        this.db = db;
    }

    public void create(Auction auction) {
        db.createAuction(auction);
    }
    public void update(Auction auction) {
        db.updateAuction(auction);
    }
    public void delete (long id) {
        db.deleteAuction(id);
    }
    public Auction getById(long id) {
        return db.getAuctionById(id);
    }
    public List<Auction> getAll() {
        return db.getAllAuction();
    }
}
