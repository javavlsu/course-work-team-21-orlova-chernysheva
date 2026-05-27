package ru.auction.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.auction.model.Bid;
import ru.auction.model.Lot;
import ru.auction.model.Notification;
import ru.auction.model.User;
import ru.auction.repository.BidRepository;
import ru.auction.repository.LotRepository;
import ru.auction.repository.NotificationRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class BidService {

    private final BidRepository bidRepository;
    private final LotRepository lotRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    public BidService(BidRepository bidRepository, LotRepository lotRepository) {
        this.bidRepository = bidRepository;
        this.lotRepository = lotRepository;
    }

    @Transactional
    public boolean placeBid(int lotId, double amount, User user) {
        // 1. Получаем лот из БД
        Lot lot = lotRepository.findById(lotId)
                .orElseThrow(() -> new IllegalArgumentException("Лот не найден"));

        // 2. Проверяем статус лота
        if (!"на выставке".equals(lot.getStatus())) {
            throw new IllegalStateException("Лот недоступен для ставок");
        }

        // 3. Получаем текущую максимальную ставку
        double currentPrice = getCurrentPrice(lotId);

        // 4. Проверяем, что ставка выше текущей
        double minAllowedBid = currentPrice + 1;
        if (amount < minAllowedBid) {
            throw new IllegalArgumentException(
                    String.format("Ставка должна быть не менее %.2f руб.", minAllowedBid));
        }

        // 5. Создаём новую ставку
        Bid bid = new Bid();
        bid.setBidAmount(amount);
        bid.setBidDateTime(LocalDateTime.now());
        bid.setLot(lot);
        bid.setUser(user);

        // 6. Сохраняем ставку в БД
        bidRepository.save(bid);

        // 7. Обновляем текущую цену лота
        lot.setCurrentPrice(amount);
        lotRepository.save(lot); // Предполагаем, что у LotRepository есть метод save

        // 8. Отправляем уведомления (опционально)
        sendNotifications(lot, user, amount, bid);

        return true;
    }

    /**
     * Получает текущую максимальную ставку для лота
     */
    public double getCurrentPrice(int lotId) {
        List<Bid> bids = bidRepository.findBidsByLotIdWithUser(lotId);
        if (bids.isEmpty()) {
            return lotRepository.findById(lotId)
                    .map(Lot::getStartPrice)
                    .orElse(0.0);
        }
        return bids.stream()
                .mapToDouble(Bid::getBidAmount)
                .max()
                .orElse(0.0);
    }

    /**
     * Отправка уведомлений участникам
     */
    private void sendNotifications(Lot lot, User newBidder, double newAmount, Bid bid) {
        LocalDateTime now = LocalDateTime.now();
        String lotLink = "/auction/lot/" + lot.getId();

        // Уведомление для нового участника
        String bidderContent = String.format(
                "Вы сделали ставку %.2f руб. на лот '%s'. <a href='%s'>Перейти к лоту</a>",
                newAmount, lot.getTitle(), lotLink);
        Notification bidderNotification = new Notification();
        bidderNotification.setUser(newBidder);
        bidderNotification.setContent(bidderContent);
        bidderNotification.setAdmission(now);
        bidderNotification.setBid(bid);
        notificationRepository.save(bidderNotification);

        // Уведомление для продавца
        User seller = lot.getAuction().getUser();
        if (seller != null && !seller.equals(newBidder)) {
            String sellerContent = String.format(
                    "На ваш лот '%s' сделали ставку %.2f руб. <a href='%s'>Перейти к лоту</a>",
                    lot.getTitle(),
                    newAmount,
                    lotLink
            );
            Notification sellerNotification = new Notification();
            sellerNotification.setUser(seller);
            sellerNotification.setContent(sellerContent);
            sellerNotification.setAdmission(now);
            sellerNotification.setBid(bid);
            notificationRepository.save(sellerNotification);
        }
    }

    private void createNotification(User user, String message, String link, Bid bid) {
        Notification notification = new Notification();
        notification.setUser(user);
        notification.setContent(message + " <a href='" + link + "'>Перейти к лоту</a>");
        notification.setBid(bid);
        notification.setAdmission(LocalDateTime.now());

        notificationRepository.save(notification);
    }
}
