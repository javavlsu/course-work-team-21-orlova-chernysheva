package ru.auction.controller;

import ru.auction.DAO.BidDAO;
import ru.auction.model.Bid;

import java.util.List;

public class BidController {
    private BidDAO bidDAO;

    public BidController(BidDAO bidDAO){
        this.bidDAO = bidDAO;
    }

    public void createBid(Bid bid) {
        System.out.println("Create bid: " + bid);
        bidDAO.create(bid);
    }

    public void updateBid(Bid bid) {
        System.out.println("Update bid: " + bid);
        bidDAO.update(bid);
    }

    public void deleteBid(long id) {
        System.out.println("Delete bid with id: " + id);
        bidDAO.delete(id);
    }

    public Bid getBidById(long id) {
        System.out.println("Get bid by id: " + id);
        return bidDAO.getById(id);
    }

    public List<Bid> getAllBid() {
        System.out.println("Get all bids");
        return bidDAO.getAll();
    }
}
