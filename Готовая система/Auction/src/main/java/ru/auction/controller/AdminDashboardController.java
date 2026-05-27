package ru.auction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.auction.DTO.AuctionDTO;
import ru.auction.DTO.LotDTO;
import ru.auction.model.*;
import ru.auction.repository.*;
import ru.auction.service.AuctionService;
import ru.auction.service.LotService;
import ru.auction.service.UserService;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class AdminDashboardController {
    @Autowired
    private LotRepository lotRepository;

    @Autowired
    private AuctionRepository auctionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private BidRepository bidRepository;

    @Autowired
    private PaymentRepository paymentRepository;


    @Autowired
    private LotService lotService;

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String showAdminDashboard(Model model, HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equals("admin")) {
            return "redirect:/index";
        }

        // Получаем все лоты
        List<Lot> lots = lotRepository.findAll();
        model.addAttribute("lots", lots);

        // Остальной код без изменений...
        List<Auction> auctions = auctionRepository.findAll();
        List<AuctionDTO> auctionDTO = auctions.stream()
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

        model.addAttribute("auctions", auctionDTO);
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("payments", paymentRepository.findAllWithDetails());

        return "dashboard";
    }

    // Просмотр лота
    @GetMapping("/admin/updateStatus/{lotId}")
    public String showEditForm(@PathVariable int lotId, Model model) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);
        List<Auction> activeAuction = auctionRepository.findAll();

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            model.addAttribute("lot", lot);

            activeAuction = auctionRepository.findByStatus("активен");
            model.addAttribute("activeAuction", activeAuction);

            return "dashboardLot";
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }


    // Просмотр аукциона
    @GetMapping("/admin/updateAuction/{auctionId}")
    public String showEditAuction(@PathVariable int auctionId, Model model) {
        Optional<Auction> auctionOptional = auctionRepository.findById(auctionId);

        if (auctionOptional.isPresent()) {
            Auction auction = auctionOptional.get();
            model.addAttribute("auction", auction);
            return "dashboardAuction";
        } else {
            model.addAttribute("error", "Аукцион не найден");
            return "error";
        }
    }

    @PostMapping("/admin/updateStatus")
    @Transactional
    public String updateStatus(
            @RequestParam("lotId") int lotId,
            @RequestParam("status") String status,
            @RequestParam("auctionId") int auctionId,
            Model model) {

        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();

            // Получаем объект Auction по ID
            Optional<Auction> auctionOptional = auctionRepository.findById(auctionId);
            if (auctionOptional.isPresent()) {
                Auction auction = auctionOptional.get();
                lot.setStatus(status);
                lot.setAuction(auction); // Передаём объект Auction

                try {
                    lotRepository.save(lot);
                    return "redirect:/dashboard#auctions";
                } catch (Exception e) {
                    model.addAttribute("error", "Ошибка при сохранении: " + e.getMessage());
                    return "error";
                }
            } else {
                model.addAttribute("error", "Аукцион не найден");
                return "error";
            }
        } else {
            model.addAttribute("error", "Лот не найден для обновления");
            return "error";
        }
    }

    @PostMapping("/admin/updateAuction")
    @Transactional
    public String updateAuction(
            @RequestParam("auctionId") int auctionId,
            @RequestParam("title") String title,
            @RequestParam("startTime") String startTime,
            @RequestParam("endTime") String endTime,
            @RequestParam("status") String status,
            Model model) {

        Optional<Auction> auctionOptional = auctionRepository.findById(auctionId);

        if (auctionOptional.isPresent()) {
            Auction auction = auctionOptional.get();

            // Обновляем только статус
            auction.setTitle(title);
            auction.setStartTime(LocalDateTime.parse(startTime));
            auction.setEndTime(LocalDateTime.parse(endTime));
            auction.setStatus(status);

            try {
                auctionRepository.save(auction);
                return "redirect:/dashboard#auctions";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при сохранении: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Лот не найден для обновления");
            return "error";
        }
    }

    @GetMapping("/admin/deleteLot/{lotId}")
    public String deleteLot(@PathVariable int lotId, Model model) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            model.addAttribute("lot", lot);
            return "dashboardDeleteLot";
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @PostMapping("/admin/deleteLot")
    @Transactional
    public String deleteLot(
            @RequestParam("lotId") int lotId,
            HttpSession session,
            Model model) {

        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            Auction auction = lot.getAuction();

            try {
                lotRepository.deleteById(lotId);

                return "redirect:/dashboard#auctions";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при удалении лота: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @GetMapping("/admin/deleteAuction/{auctionId}")
    public String deleteAuction(@PathVariable int auctionId, Model model) {
        Optional<Auction> auctionOptional = auctionRepository.findById(auctionId);

        if (auctionOptional.isPresent()) {
            Auction auction = auctionOptional.get();
            model.addAttribute("auction", auction);
            return "dashboardDeleteAuction";
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @PostMapping("/admin/deleteAuction")
    @Transactional
    public String deleteAuction(
            @RequestParam("auctionId") int auctionId,
            HttpSession session,
            Model model) {

        Optional<Auction> auctionOptional = auctionRepository.findById(auctionId);

        if (auctionOptional.isPresent()) {
            Auction auction = auctionOptional.get();

            try {
                auctionRepository.deleteById(auctionId);
                return "redirect:/dashboard#auctions";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при удалении аукциона: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Аукцион не найден");
            return "error";
        }
    }

    @GetMapping("/admin/createAuction")
    public String createAuctionForma(HttpSession session, Model model) {
        return "dashboardAuctionCreate";
    }

    @PostMapping("/admin/createAuction")
    @Transactional
    public String createAuction(
            @RequestParam("title") String title,
            @RequestParam("startTime") String startTime,
            @RequestParam("endTime") String endTime,
            @RequestParam("status") String status,
            HttpSession session,
            Model model) {

        try {

            // Создаём новый
            Auction newAuction = new Auction();
            newAuction.setTitle(title);

            // Устанавливаем дату
            newAuction.setStartTime(LocalDateTime.parse(startTime));
            newAuction.setEndTime(LocalDateTime.parse(endTime));

            // Устанавливаем статус аукциона
            newAuction.setStatus(status);

            User defaultUser = new User();
            defaultUser.setId(1);
            newAuction.setUser(defaultUser);

            // Сохраняем лот в БД
            auctionRepository.save(newAuction);

            // Перенаправляем на страницу созданного лота
            return "redirect:/dashboard#auctions";

        } catch (Exception e) {
            model.addAttribute("error", "Ошибка при сохранении аукциона: " + e.getMessage());
            return "error";
        }
    }

    // Просмотр
    @GetMapping("/admin/detailUser/{userId}")
    public String showDetailUser(@PathVariable int userId, Model model) {
        Optional<User> userOptional = userRepository.findById(userId);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            model.addAttribute("user", user);
            return "dashboardDetailUser";
        } else {
            model.addAttribute("error", "Аукцион не найден");
            return "error";
        }
    }
    @GetMapping("/admin/createUser")
    public String createUserForma(HttpSession session, Model model) {
        return "dashboardUserCreate";
    }

    @PostMapping("/admin/createUser")
    @Transactional
    public String createUser(
            @RequestParam("lastName") String lastName,
            @RequestParam("firstName") String firstName,
            @RequestParam("numberPhone") String numberPhone,
            @RequestParam("role") String role,
            @RequestParam("login") String login,
            @RequestParam("password") String password,
            @RequestParam("email") String email,
            HttpSession session,
            Model model) {

        try {
            User registeredUser = userService.registerNewUser(login, password, role, email, numberPhone, lastName, firstName);
            model.addAttribute("success", "Регистрация прошла успешно! Теперь вы можете войти в систему.");
            // Перенаправляем
            return "redirect:/dashboard";

        } catch (Exception e) {
            model.addAttribute("error", "Ошибка при сохранении: " + e.getMessage());
            return "error";
        }
    }


    @GetMapping("/admin/deleteUser/{userId}")
    public String deleteUser(@PathVariable int userId, Model model) {
        Optional<User> userOptional = userRepository.findById(userId);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            model.addAttribute("user", user);
            return "dashboardDeleteUser";
        } else {
            model.addAttribute("error", "Пользователь не найден");
            return "error";
        }
    }

    @GetMapping("/admin/determineWinner/{lotId}")
    public String determineWinner(@PathVariable int lotId, Model model) {
        Optional<LotDTO> lotDtoOptional = lotService.getLotWithWinnerInfo(lotId);

        if (lotDtoOptional.isPresent()) {
            LotDTO lotDto = lotDtoOptional.get();
            model.addAttribute("lot", lotDto);
            // winnerBid больше не нужен отдельно — все данные в lotDto
            return "determineWinner";
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @GetMapping("/admin/closePayment/{paymentId}")
    public String closePaymentForm(@PathVariable int paymentId, Model model) {
        Optional<Payment> paymentOptional = paymentRepository.findById(paymentId);

        if (paymentOptional.isPresent()) {
            Payment payment = paymentOptional.get();
            model.addAttribute("payment", payment);
            return "closePayment";
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @PostMapping("/admin/closePayment")
    @Transactional
    public String closePayment(
            @RequestParam("paymentId") int paymentId,
            Model model) {

        Optional<Payment> paymentOptional = paymentRepository.findById(paymentId);

        if (paymentOptional.isPresent()) {
            Payment payment = paymentOptional.get();

            //Меняем статус платежа(имитация)
            payment.setPaymentStatus("закрыт");

            try {
                paymentRepository.save(payment);
                return "redirect:/dashboard";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при сохранении: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Платеж не найден для обновления");
            return "error";
        }
    }
    @GetMapping("/admin/deleteBid/{bidId}")
    public String deleteBid(@PathVariable int bidId, Model model) {
        Optional<Bid> bidOptional = bidRepository.findById(bidId);

        if (bidOptional.isPresent()) {
            Bid bid = bidOptional.get();
            model.addAttribute("bid", bid);
            return "dashboardDeleteBid";
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @PostMapping("/admin/deleteBid")
    @Transactional
    public String deleteBid(
            @RequestParam("bidId") int bidId,
            HttpSession session,
            Model model) {

        Optional<Bid> bidOptional = bidRepository.findById(bidId);

        if (bidOptional.isPresent()) {
            Bid bid = bidOptional.get();

            try {
                bidRepository.deleteById(bidId);

                return "redirect:/dashboard";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при удалении лота: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }
}
