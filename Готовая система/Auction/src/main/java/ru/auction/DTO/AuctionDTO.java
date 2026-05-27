package ru.auction.DTO;

import ru.auction.model.Bid;
import ru.auction.model.Lot;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class AuctionDTO {
    private Integer id;
    private String title;
    private String startTime;
    private String endTime;
    private String status;
    private int lotsCount;
    private List<Lot> lots;
    private List<Bid> bids;

    public AuctionDTO(Integer id, String title, LocalDateTime startTime, LocalDateTime endTime, String status, int lotsCount, List<Lot> lots) {
        this.id = id;
        this.title = title;
        this.status = status;
        this.lotsCount = lotsCount;
        // Конвертируем LocalDateTime в строку с нужным форматом
        if (startTime != null) {
            this.startTime = startTime.format(
                    DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm")
            );
        } else {
            this.startTime = "";
        }
        if (endTime != null) {
            this.endTime = endTime.format(
                    DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm")
            );
        } else {
            this.endTime = "";
        }
        this.lots = lots != null ? lots : new ArrayList<>();
    }

    // Конструктор для пользователей: без лотов
    public AuctionDTO(Integer id, String title, LocalDateTime startTime,
                      LocalDateTime endTime, String status, int lotsCount) {
        this(id, title, startTime, endTime, status, lotsCount, null);
    }

    // Геттеры
    public Integer getId() { return id; }
    public String getTitle() { return title; }
    public String getStartTime() { return startTime; }
    public String getEndTime() { return endTime; }
    public String getStatus() { return status; }
    public int getLotsCount() {
        return lotsCount;
    }
    public List<Lot> getLots() {
        return lots;
    }
    public List<Bid> getBids() {
        return bids;
    }
}
