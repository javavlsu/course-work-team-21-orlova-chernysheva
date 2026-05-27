package ru.auction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.auction.DTO.LotDTO;
import ru.auction.model.*;
import ru.auction.repository.LotRepository;
import ru.auction.repository.BidRepository;
import ru.auction.repository.NotificationRepository;
import ru.auction.repository.UserRepository;
import ru.auction.service.LotService;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class LotController {

    private final LotRepository lotRepository;
    private final UserRepository userRepository;
    @Autowired
    private LotService lotService;
    private final BidRepository bidRepository;

    public LotController(LotRepository lotRepository, BidRepository bidRepository, UserRepository userRepository) {
        this.lotRepository = lotRepository;
        this.bidRepository = bidRepository;
        this.userRepository = userRepository;
    }

    /**
     * Отображение деталей конкретного лота и истории ставок
     * @param lotId ID лота
     * @param model Модель для передачи данных в представление
     * @return Имя шаблона представления
     */
    @GetMapping("/lot/{lotId}")
    public String showLotDetails(@PathVariable int lotId, Model model) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            // Используем новый метод с жадной загрузкой
            List<Bid> bids = bidRepository.findBidsByLotIdWithUser(lotId);

            // Конвертируем LocalDateTime в Date для всех ставок
            List<Bid> formattedBids = bids.stream()
                    .map(bid -> {
                        bid.setBidDateTimeFormatted(toDate(bid.getBidDateTime()));
                        return bid;
                    })
                    .collect(Collectors.toList());

            Date formattedDateAdded = toDate(lot.getDateAdded());

            model.addAttribute("lot", lot);
            model.addAttribute("bids", formattedBids);
            model.addAttribute("formattedDateAdded", formattedDateAdded);
            return "lot";
        } else {
            model.addAttribute("lot", null);
            return "lot";
        }
    }

    private Date toDate(LocalDateTime localDateTime) {
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }

    @GetMapping("/allLots")
    public String showMyLots(Model model, HttpSession session) {
        // Получаем ID текущего пользователя из сессии
        Integer currentUserId = (Integer) session.getAttribute("userId");

        if (currentUserId == null) {
            model.addAttribute("error", "Пользователь не авторизован");
            return "error";
        }

        List<LotDTO> lots = lotService.getLotsBySellerId(currentUserId);
        model.addAttribute("lots", lots);
        return "allLots";
    }

    @GetMapping("/createLot")
    public String createlotForma(HttpSession session, Model model) {
        return "createLot";
    }

    @PostMapping("/createLot")
    @Transactional
    public String createLot(
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("description") String description,
            @RequestParam(value = "image", required = false) String image,
            @RequestParam("startPrice") double startPrice,
            HttpSession session,
            Model model) {

        try {
            // Получаем пользователя из сессии
            int sellerId = (int) session.getAttribute("userId");
            // Создаём новый лот
            Lot newLot = new Lot();
            newLot.setTitle(title);
            newLot.setAuthor(author);
            newLot.setDescription(description);
            newLot.setStartPrice(startPrice);
            newLot.setCurrentPrice(startPrice);

            // Загружаем полного пользователя из БД по ID
            User currentUser = userRepository.findById(sellerId)
                    .orElseThrow(() -> new RuntimeException("Пользователь не найден в базе данных"));

            // Связываем лот с пользователем (это установит sellerId в БД)
            newLot.setUser(currentUser);

            // Устанавливаем URL изображения, если он предоставлен
            if (image != null && !image.trim().isEmpty()) {
                newLot.setImage(image);
            }

            // Устанавливаем дату добавления (текущее время)
            newLot.setDateAdded(LocalDateTime.now());

            // Устанавливаем статус лота
            newLot.setStatus("ожидает проверку");

            // Связываем лот с аукционом по умолчанию (ID = 1)
            Auction defaultAuction = new Auction();
            defaultAuction.setId(1);
            newLot.setAuction(defaultAuction);


            // Сохраняем лот в БД
            lotRepository.save(newLot);

            // Перенаправляем на страницу созданного лота
            return "redirect:/detailLotSeller/" + newLot.getId();

        } catch (Exception e) {
            model.addAttribute("error", "Ошибка при сохранении лота: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/updateLot/{lotId}")
    public String showEditForm(@PathVariable int lotId, Model model) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            model.addAttribute("lot", lot);
            return "updateLot"; // шаблон формы редактирования
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @PostMapping("/updateLot")
    @Transactional
    public String updateLot(
            @RequestParam("lotId") int lotId,
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("description") String description,
            @RequestParam(value = "image", required = false) String image,
            Model model) {

        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();

            // Обновляем только редактируемые поля
            lot.setTitle(title);
            lot.setAuthor(author);
            lot.setDescription(description);
            lot.setStatus("ожидает проверку");

            if (image != null && !image.trim().isEmpty()) {
                lot.setImage(image);
            }
            // startPrice не обновляем — он фиксирован

            try {
                lotRepository.save(lot);
                return "redirect:/detailLotSeller/" + lotId;
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при сохранении: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Лот не найден для обновления");
            return "error";
        }
    }

    @GetMapping("/deleteLot/{lotId}")
    public String deleteLot(@PathVariable int lotId, Model model) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            model.addAttribute("lot", lot);
            return "deleteLot";
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @PostMapping("/deleteLot")
    @Transactional
    public String deleteLot(
            @RequestParam("lotId") int lotId,
            HttpSession session,
            Model model) {

//        Long currentUserId = (Long) session.getAttribute("userId");
//        if (currentUserId == null) {
//            model.addAttribute("error", "Пользователь не авторизован");
//            return "error";
//        }

        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            Auction auction = lot.getAuction();

            try {
                // Меняем статус на "Ожидает удаления" вместо физического удаления
                lot.setStatus("ожидает удаления");
                lotRepository.save(lot);

                model.addAttribute("message", "Лот успешно помечен для удаления");
                return "redirect:/allLots";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при удалении лота: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Лот не найден");
            return "error";
        }
    }

    @GetMapping("/detailLotSeller/{lotId}")
    public String showLotDetailsSeller(@PathVariable int lotId, Model model) {
        Optional<Lot> lotOptional = lotRepository.findById(lotId);

        if (lotOptional.isPresent()) {
            Lot lot = lotOptional.get();
            // Используем новый метод с жадной загрузкой
            List<Bid> bids = bidRepository.findBidsByLotIdWithUser(lotId);

            // Конвертируем LocalDateTime в Date для всех ставок
            List<Bid> formattedBids = bids.stream()
                    .map(bid -> {
                        bid.setBidDateTimeFormatted(toDate(bid.getBidDateTime()));
                        return bid;
                    })
                    .collect(Collectors.toList());

            Date formattedDateAdded = toDate(lot.getDateAdded());

            model.addAttribute("lot", lot);
            model.addAttribute("bids", formattedBids);
            model.addAttribute("formattedDateAdded", formattedDateAdded);
            return "detailLotSeller";
        } else {
            model.addAttribute("lot", null);
            return "detailLotSeller";
        }
    }

}
