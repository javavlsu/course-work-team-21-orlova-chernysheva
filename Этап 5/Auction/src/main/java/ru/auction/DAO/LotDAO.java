package ru.auction.DAO;

import ru.auction.model.*;

import java.util.List;

public class LotDAO {
    private DBImpl db;

    public LotDAO(DBImpl db) {
        this.db = db;
    }
    public void create(Lot lot) {
        db.createLot(lot);
    }
    public void update(Lot lot) {
        db.updateLot(lot);
    }
    public void delete (long id) {
        db.deleteLot(id);
    }
    public Lot getById(long id) {

        return db.getLotById(id);
    }
    public List<Lot> getAll() {

        return db.getAllLots();
    }
}
