package ru.auction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // Импортируем Model
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.auction.DTO.AuctionDTO;
import ru.auction.model.*;
import ru.auction.repository.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class IndexController {

    private final LotRepository lotRepository;
    private final AuctionRepository auctionRepository;
    private final UserRepository userRepository;

    private final PaymentRepository paymentRepository;
    private final BidRepository bidRepository;
    private final HttpSession session;

    // Внедряем LotRepository через конструктор (предпочтительный способ)
    public IndexController(LotRepository lotRepository, AuctionRepository auctionRepository, UserRepository userRepository, PaymentRepository paymentRepository, BidRepository bidRepository, HttpSession session) {
        this.lotRepository = lotRepository;
        this.auctionRepository = auctionRepository;
        this.userRepository = userRepository;
        this.paymentRepository = paymentRepository;
        this.bidRepository = bidRepository;
        this.session = session;
    }

    @GetMapping("/index")
    public String index(
            @RequestParam(required = false) String error,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "6") int size,
            Model model) {

        String userRole = (String) session.getAttribute("role");

        page = Math.max(1, page);
        size = Math.max(1, size);

        int offset = (page - 1) * size;

        List<Lot> lots = new ArrayList<>();
        List<AuctionDTO> auctionDisplays = new ArrayList<>();
        List<User> users = new ArrayList<>();
        List<Payment> payments = new ArrayList<>();

        long totalLots = 0;
        long totalAuctions = 0;
        long totalUsers = 0;
        long totalPayments = 0;
        int totalPages = 1;

        if ("ADMIN".equals(userRole)) {
            totalAuctions = auctionRepository.count();
            totalPages = (int) Math.ceil((double) totalAuctions/size);
            page = Math.min(page, totalPages == 0 ? 1 : totalPages);
            offset = (page - 1) * size;
            // Для админа: загружаем все аукционы и их лоты
            List<Auction> auctions = auctionRepository.findWithPagination(offset, size);

            auctionDisplays = auctions.stream()
                    .map(auction -> {
                        // Получаем все лоты для текущего аукциона
                        List<Lot> auctionLots = lotRepository.findByAuctionId(auction.getId());
                        int lotsCount = auctionLots.size();

                        for (Lot lot : auctionLots) {
                            List<Bid> lotBids = bidRepository.findBidsByLotIdWithUser(lot.getId());
                            lot.setBids(lotBids);
                        }

                        return new AuctionDTO(
                                auction.getId(),
                                auction.getTitle(),
                                auction.getStartTime(),
                                auction.getEndTime(),
                                auction.getStatus(),
                                lotsCount,
                                auctionLots // Передаём коллекцию лотов в DTO
                        );
                    })
                    .collect(Collectors.toList());

            totalUsers = userRepository.count();
            users = userRepository.findWithPagination(offset, size);

            totalPayments = paymentRepository.count();
            payments = paymentRepository.findWithPagination(offset, size);

        } else {
            // Для обычных пользователей: пагинация лотов + все аукционы (без лотов)
            totalLots = lotRepository.countByStatus("на выставке");
            totalPages = (int) Math.ceil((double) totalLots / size);
            page = Math.min(page, totalPages == 0 ? 1 : totalPages);
            offset = (page - 1) * size;
            lots = lotRepository.findByStatusWithPagination("на выставке", offset, size);

            // Загружаем все аукционы (только метаданные, без лотов)
            List<Auction> allAuctions = auctionRepository.findAll();
            auctionDisplays = allAuctions.stream()
                    .map(auction -> {
                        int lotsCount = lotRepository.countByAuctionId(auction.getId());
                        return new AuctionDTO(
                                auction.getId(),
                                auction.getTitle(),
                                auction.getStartTime(),
                                auction.getEndTime(),
                                auction.getStatus(),
                                lotsCount
                        );
                    })
                    .collect(Collectors.toList());
        }

        model.addAttribute("auctions", auctionDisplays);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", size);

        if("ADMIN".equals(userRole)) {
            model.addAttribute("users", users);
            model.addAttribute("payments", payments);
            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("totalPaymeents", totalPayments);
            model.addAttribute("totalAuctions", totalAuctions);
        } else {
            model.addAttribute("lots", lots);
            model.addAttribute("totalLots", totalLots);
        }

        if (error != null) {
            model.addAttribute("error", error);
        }
        return "index";
    }
    private Date toDate(LocalDateTime localDateTime) {
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }
}

