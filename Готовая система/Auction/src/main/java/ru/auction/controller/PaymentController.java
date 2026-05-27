package ru.auction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.auction.DAO.PaymentDAO;
import ru.auction.model.Auction;
import ru.auction.model.Payment;
import ru.auction.repository.PaymentRepository;
import ru.auction.service.NotificationService;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;

@Controller
public class PaymentController {

    @Autowired
    private PaymentRepository paymentRepository;
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/payment/{paymentId}")
    public String showPaymentPage(@PathVariable int paymentId, Model model) {
        Optional<Payment> paymentOptional = paymentRepository.findById(paymentId);

        if (paymentOptional.isPresent()) {
            Payment payment = paymentOptional.get();
            model.addAttribute("payment", payment);
            model.addAttribute("title", payment.getLot().getTitle());
            model.addAttribute("amount", payment.getAmount());
            return "payment";
        } else {
            model.addAttribute("error", "Платеж не найден");
            return "error";
        }
    }

    @PostMapping("/payment")
    public String payment(@RequestParam("paymentId") int paymentId, Model model) {
        Optional<Payment> paymentOptional = paymentRepository.findById(paymentId);

        if (paymentOptional.isPresent()) {
            Payment payment = paymentOptional.get();

            payment.setPaymentDate(LocalDateTime.now());
            payment.setPaymentStatus("платеж принят");

            try {
                paymentRepository.save(payment);
                // Отправляем уведомление пользователю сразу после успешной оплаты
                notificationService.notifyPaymentCompleted(payment);
                return "redirect:/index";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при сохранении платежа или создании уведомления");
                return "error";
            }
        } else {
            model.addAttribute("error", "Платеж не найден в БД");
            return "error";
        }
    }
}
