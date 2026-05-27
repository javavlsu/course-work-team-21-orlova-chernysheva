package ru.auction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import ru.auction.model.Auction;
import ru.auction.model.Bid;
import ru.auction.model.Lot;
import ru.auction.repository.AuctionRepository;
import ru.auction.repository.LotRepository;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class AuctionController {
    private final AuctionRepository auctionRepository;
    private final LotRepository lotRepository;

    public AuctionController(AuctionRepository auctionRepository, LotRepository lotRepository) {
        this.auctionRepository = auctionRepository;
        this.lotRepository = lotRepository;
    }

    @GetMapping("/allAuction")
    public String allAuction(@RequestParam(required = false) String error,
                             @RequestParam(defaultValue = "1") int page,
                             @RequestParam(defaultValue = "6") int size,
                             Model model) {
        List<Auction> auctions = new ArrayList<>();

        long totalLots = auctionRepository.countByStatus("активен");
        int totalPages = (int) Math.ceil((double) totalLots / size);

        int offset = (page - 1) * size;

        auctions = auctionRepository.findByStatusWithPagination(
                "активен",
                offset,
                size
        );
        model.addAttribute("auctions", auctions);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalLots", totalLots);
        model.addAttribute("pageSize", size);
        if (error != null) {
            model.addAttribute("error", error);
        }
        return "allAuction";
    }

    @GetMapping("/allAuction/{auctionId}/lotsByAuction")
    public String showLotsByAuction(@PathVariable int auctionId, Model model) {
        Optional<Auction> auctionOptional = auctionRepository.findById(auctionId);

        if (auctionOptional.isPresent()) {
            Auction auction = auctionOptional.get();
            List<Lot> lots = lotRepository.findByAuctionId(auctionId);

            model.addAttribute("auction", auction);
            model.addAttribute("lots", lots);
            return "lotsByAuction";
        } else {
            model.addAttribute("error", "Аукцион с ID " + auctionId + " не найден");
            return "allAuction";
        }
    }
}
