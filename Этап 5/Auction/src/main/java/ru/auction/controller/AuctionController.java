package ru.auction.controller;

import ru.auction.DAO.AuctionDAO;
import ru.auction.model.Auction;

import java.util.List;

public class AuctionController {
    private AuctionDAO auctionDAO;

    public AuctionController(AuctionDAO auctionDAO) {
        this.auctionDAO = auctionDAO;
    }

    public void createAuction(Auction auction) {
        System.out.println("Create auction: {}" + auction);
        auctionDAO.create(auction);
}

    public void updateAuction(Auction auction) {
        System.out.println("Update auction: " + auction);
        auctionDAO.update(auction);
    }

    public void deleteAuction(long id) {
        System.out.println("Delete auction with id: " + id);
        auctionDAO.delete(id);
    }

    public Auction getAuctionById(long id) {
        System.out.println("Get auction by id: " + id);
        return auctionDAO.getById(id);
    }

    public List<Auction> getAllAuctions() {
        System.out.println("Get all auctions");
        return auctionDAO.getAll();
    }
}
