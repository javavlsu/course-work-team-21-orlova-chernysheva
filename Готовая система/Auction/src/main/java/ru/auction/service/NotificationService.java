package ru.auction.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.auction.model.*;
import ru.auction.repository.BidRepository;
import ru.auction.repository.NotificationRepository;
import ru.auction.repository.PaymentRepository;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private BidRepository bidRepository;

    @Transactional
    public void notifyWinnerAndCreatePayment(Lot lot, User winner, Bid winningBid) {
        // Проверяем, существует ли уже платёж для этого лота
        Optional<Payment> existingPayment = paymentRepository.findByLot(lot);

        Payment savedPayment;
        if (existingPayment.isPresent()) {
            // Платёж уже существует — используем его для ссылки в уведомлении
            savedPayment = existingPayment.get();
        } else {
            // Платёжа нет — создаём новый
            Payment payment = new Payment();
            payment.setAmount(winningBid.getBidAmount());
            payment.setPaymentStatus("не оплачено");
            payment.setPaymentDate(LocalDateTime.now());
            payment.setLot(lot);
            payment.setUser(winner);
            savedPayment = paymentRepository.save(payment);
        }
        int paymentId = savedPayment.getId();

        // Создаём уведомление для отображения в ЛК
        Notification notification = new Notification();
        String link = "/auction/payment/" + paymentId;

        notification.setContent(String.format(
                "Аукцион по лоту \"%s\" был завершён. Вы стали победителем! <a href='%s'>Перейти к оплате</a>",
                lot.getTitle(), link
        ));
        notification.setAdmission(LocalDateTime.now());
        notification.setBid(winningBid);
        notification.setUser(winner);
        notificationRepository.save(notification);
    }

    @Transactional
    public void notifyPaymentCompleted(Payment payment) {
        User user = payment.getUser();
        Lot lot = payment.getLot();

        // Ищем ставку пользователя по этому лоту
        Optional<Bid> bidOptional = bidRepository.findByLotIdAndUserId(
                lot.getId(),
                user.getId()
        );

        if (bidOptional.isPresent()) {
            Bid bid = bidOptional.get();

            Notification notification = new Notification();
            notification.setContent(String.format(
                    "Платеж по лоту \"%s\" принят!",
                    lot.getTitle()
            ));
            notification.setAdmission(LocalDateTime.now());
            notification.setUser(user);
            notification.setBid(bid); // обязательное поле, заполняем найденной ставкой
            notificationRepository.save(notification);
        } else {
            // Если ставка не найдена, логируем ошибку (но не прерываем процесс оплаты)
            System.err.println("Не найдена ставка для платежа ID: " + payment.getId());
        }
    }
}
