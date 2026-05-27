package ru.auction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.auction.model.Bid;
import ru.auction.model.Lot;
import ru.auction.model.Notification;
import ru.auction.model.User;
import ru.auction.repository.BidRepository;
import ru.auction.repository.LotRepository;
import ru.auction.repository.NotificationRepository;
import ru.auction.repository.UserRepository;
import ru.auction.service.BidService;
import ru.auction.service.LotService;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.util.Optional;

@Controller
public class BidController {
    @Autowired
    private BidService bidService;

    @PostMapping("/placeBid")
    public String placeBid(
            @RequestParam("lotId") int lotId,
            @RequestParam("amount") double amount,
            HttpSession session,
            Model model) {

        // Получаем текущего пользователя из сессии
        User user = (User) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("error", "Необходимо войти в систему");
            return "redirect:/login";
        }

        try {
            // Пытаемся разместить ставку
            boolean success = bidService.placeBid(lotId, amount, user);
            if (success) {
                return "redirect:/lot/" + lotId;
            } else {
                model.addAttribute("error", "Не удалось разместить ставку");
                return "lot-details";
            }
        } catch (IllegalArgumentException | IllegalStateException e) {
            // Передаём ошибку в JSP
            model.addAttribute("error", e.getMessage());
            return "redirect:/index";
        }
    }
}
