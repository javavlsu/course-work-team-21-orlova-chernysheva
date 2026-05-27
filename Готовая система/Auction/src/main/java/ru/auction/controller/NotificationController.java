package ru.auction.controller;

import com.thoughtworks.qdox.model.expression.Not;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.auction.DAO.NotificationDAO;
import ru.auction.model.Bid;
import ru.auction.model.Lot;
import ru.auction.model.Notification;
import ru.auction.model.User;
import ru.auction.repository.BidRepository;
import ru.auction.repository.LotRepository;
import ru.auction.repository.NotificationRepository;
import ru.auction.service.LotService;
import ru.auction.service.NotificationService;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Controller
public class NotificationController {

    @Autowired
    private LotRepository lotRepository;

    @Autowired
    private BidRepository bidRepository;

    @Autowired
    private NotificationService notificationService;

    private final NotificationRepository notificationRepository; // Объявляем репозиторий

    // Внедряем LotRepository через конструктор (предпочтительный способ)
    public NotificationController(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }


    private User getCurrentUser(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            System.out.println("ОШИБКА: Пользователь не найден в сессии. Доступные атрибуты:");
            Enumeration<String> attributeNames = request.getSession().getAttributeNames();
            while (attributeNames.hasMoreElements()) {
                String attrName = attributeNames.nextElement();
                Object attrValue = request.getSession().getAttribute(attrName);
                System.out.println("  - " + attrName + " = " + attrValue);
            }
        } else {
            System.out.println("Успешно получен пользователь из сессии: ID=" + user.getId() + ", Email=" + user.getEmail());
        }
        return user;
    }



    @GetMapping("/notifications")
    public String notifications(@RequestParam(required = false) String error, Model model, HttpServletRequest request) {
        User currentUser = getCurrentUser(request);

        if (currentUser == null) {
            model.addAttribute("error", "Пользователь не авторизован. Пожалуйста, войдите в систему.");
            model.addAttribute("notifications", new ArrayList<>());
            return "notifications";
        }

        List<Notification> notifications = notificationRepository.findByUserOrderByAdmissionDateDesc(currentUser);
        System.out.println("Найдено уведомлений для пользователя " + currentUser.getId() + ": " + notifications.size());

        // Преобразуем LocalDateTime в Date для каждого уведомления
        List<Map<String, Object>> notificationsForView = new ArrayList<>();
        for (Notification notification : notifications) {
            Map<String, Object> notificationMap = new HashMap<>();
            notificationMap.put("id", notification.getId());
            notificationMap.put("content", notification.getContent());
            notificationMap.put("admissionDate", convertToDate(notification.getAdmission()));
            notificationMap.put("user", notification.getUser());
            notificationMap.put("bid", notification.getBid());
            notificationsForView.add(notificationMap);
        }

        model.addAttribute("notifications", notificationsForView);
        if (error != null) {
            model.addAttribute("error", error);
        }
        return "notifications";
    }

    private Date convertToDate(LocalDateTime localDateTime) {
        if (localDateTime == null) {
            return null;
        }
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }

    @PostMapping("/admin/notifyWinner")
    public String notifyWinner(@RequestParam("lotId") int lotId, RedirectAttributes redirectAttributes) {
        Lot lot = lotRepository.findById(lotId)
                .orElseThrow(() -> new RuntimeException("Лот не найден"));

        Bid winningBid = bidRepository.findTopBidByLotId(lotId)
                .orElseThrow(() -> new RuntimeException("Ставок не найдено"));

        User winner = winningBid.getUser();

        try {
            notificationService.notifyWinnerAndCreatePayment(lot, winner, winningBid);
            redirectAttributes.addFlashAttribute("successMessage", "Уведомление создано и отправлено победителю!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при создании уведомления: " + e.getMessage());
        }

        return "redirect:/dashboard";
    }
}
