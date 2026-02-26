package ru.auction.controller;

import ru.auction.DAO.LotDAO;
import ru.auction.model.Lot;

import java.util.List;

public class LotController {
    private LotDAO lotDAO;

    public LotController(LotDAO lotDAO) {
        this.lotDAO = lotDAO;
    }

    public void createLot(Lot lot) {
        System.out.println("Create lot: " + lot);
        lotDAO.create(lot);
    }

    public void updateLot(Lot lot) {
        System.out.println("Update lot: " + lot);
        lotDAO.update(lot);
    }

    public void deleteLot(long id) {
        System.out.println("Delete lot with id: " + id);
        lotDAO.delete(id);
    }

    public Lot getLotById(long id) {
        System.out.println("Get lot by id: " + id);
        return lotDAO.getById(id);
    }

    public List<Lot> getAllLots() {
        System.out.println("Get all lots");
        return lotDAO.getAll();
    }
}
