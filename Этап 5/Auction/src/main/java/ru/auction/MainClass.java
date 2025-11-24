package ru.auction;

import ru.auction.DAO.BidDAO;
import ru.auction.DAO.DBImpl;
import ru.auction.DAO.LotDAO;
import ru.auction.DAO.UserDAO;
import ru.auction.controller.BidController;
import ru.auction.controller.LotController;
import ru.auction.controller.UserController;
import ru.auction.model.Bid;
import ru.auction.model.Lot;
import ru.auction.model.User;

import java.time.LocalDateTime;
import java.util.List;

public class MainClass {
    public static void main(String[] args) {
        DBImpl dbImpl = new DBImpl();
        UserDAO userDAO = new UserDAO(dbImpl);
        UserController userController = new UserController(userDAO);
        LotDAO lotDAO = new LotDAO(dbImpl);
        LotController lotController = new LotController(lotDAO);
        BidDAO bidDAO = new BidDAO(dbImpl);
        BidController bidController = new BidController(bidDAO);

        // Создаем пользователей
        User user1 = new User();
        user1.setLogin("ivanov");
        user1.setPassword("pass123");
        user1.setEmail("ivanov@example.com");
        user1.setFirstName("Иван");
        user1.setLastName("Иванов");
        user1.setRole("user");
        //userDAO.create(user1);

        User user2 = new User();
        user2.setLogin("petrov");
        user2.setPassword("pass456");
        user2.setEmail("petrov@example.com");
        user2.setFirstName("Пётр");
        user2.setLastName("Петров");
        user2.setRole("admin");
        //userDAO.create(user2);

        //Создание пользователей
        userController.createUser(user1);
        userController.createUser(user2);

        //Добавляем лоты
        Lot lot1 = new Lot();
        lot1.setTitle("Mona Liza");
        lot1.setAuthor("Леонардо да Винчи");
        lot1.setDescription("«Мона Лиза» (полное название — «Портрет госпожи Лизы дель Джокондо»)");
        lot1.setImage("https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/960px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg?20110818173323");
        lot1.setStartPrice(30000000000.0);
        lot1.setCurrentBid(30000000001.0);
        lot1.setStatus("На аукционе");
        lot1.setDateAdded(null);
        //lotDAO.create(lot1);

        //Создание лота
        lotController.createLot(lot1);

        // Создаем ставки (bids)
        Bid bid1 = new Bid();
        bid1.setLotId(lot1);
        bid1.setUserId(user1);
        bid1.setBidAmount(30000000002.0);
        bid1.setBidDateTime(LocalDateTime.now());
        //bidDAO.create(bid1);

        Bid bid2 = new Bid();
        bid2.setLotId(lot1);
        bid2.setUserId(user2);
        bid2.setBidAmount(30000000005.0);
        bid2.setBidDateTime(LocalDateTime.now());
        //bidDAO.create(bid2);

        //Создание ставок
        bidController.createBid(bid1);
        bidController.createBid(bid2);

        // Получение и вывод всех пользователей
        List<User> users = userController.getAllUsers();
        //System.out.println("User:");
        for (User user : users) {
            System.out.println("ID: " + user.getId() +
                    ", Login: " + user.getLogin() +
                    ", Email: " + user.getEmail() +
                    ", Name: " + user.getFirstName() + " " + user.getLastName() +
                    ", Role: " + user.getRole());
        }

        // Получение и вывод всех лотов
        List<Lot> lots = lotController.getAllLots();
        //System.out.println("Lot:");
        for (Lot lot: lots) {
            System.out.println("ID: " + lot.getId() +
                    ", Title: " + lot.getTitle() +
                    ", Author: " + lot.getAuthor() +
                    ", Description: " + lot.getDescription() +
                    ", Current Bid: " + lot.getCurrentBid());
        }

        // Получение и вывод всех ставок
        List<Bid> bids1 = bidController.getAllBid();
        //System.out.println("Bids:");
        for (Bid bid : bids1) {
            System.out.println("ID: " + bid.getId() +
                    ", Lot: " + bid.getLotId().getTitle() +
                    ", User: " + bid.getUserId().getLogin() +
                    ", Amount: " + bid.getBidAmount() +
                    ", Date: " + bid.getBidDateTime());
        }

        //Удаление ставки
        bidController.deleteBid(bid1.getId());

        // Вывод ставок после изменений в БД
        List<Bid> bids2 = bidController.getAllBid();
        //System.out.println("Bids:");
        for (Bid bid : bids2) {
            System.out.println("ID: " + bid.getId() +
                    ", Lot: " + bid.getLotId().getTitle() +
                    ", User: " + bid.getUserId().getLogin() +
                    ", Amount: " + bid.getBidAmount() +
                    ", Date: " + bid.getBidDateTime());
        }
    }
}
