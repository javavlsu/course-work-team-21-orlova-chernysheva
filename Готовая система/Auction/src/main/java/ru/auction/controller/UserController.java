package ru.auction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.auction.model.Auction;
import ru.auction.model.Lot;
import ru.auction.model.Role;
import ru.auction.model.User;
import ru.auction.repository.LotRepository;
import ru.auction.repository.RoleRepository;
import ru.auction.repository.UserRepository;
import ru.auction.service.AvatarService;
import ru.auction.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class UserController  {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private LotRepository lotRepository;

    @Autowired
    private AvatarService avatarService;

    @GetMapping("/profile")
    public String showProfile(@RequestParam(required = false) String error, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login?error=not_authorized";
        }

        model.addAttribute("user", user);

        if (error != null) {
            model.addAttribute("error", error);
        }

        return "profile";
    }

    @PostMapping("/profile/uploadAvatar")
    @ResponseBody
    public Map<String, Object> uploadAvatar(
            @RequestParam("avatar") MultipartFile file,
            HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        try {
            if (file.isEmpty()) {
                response.put("success", false);
                response.put("message", "Файл не выбран");
                return response;
            }

            if (!avatarService.isValidImage(file.getOriginalFilename())) {
                response.put("success", false);
                response.put("message", "Недопустимый формат файла");
                return response;
            }

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.put("success", false);
                response.put("message", "Пользователь не авторизован");
                return response;
            }

            if (file.getSize() > 5 * 1024 * 1024) { // 5 MB
                response.put("success", false);
                response.put("message", "Файл слишком большой. Максимальный размер — 5 MB");
                return response;
            }

            // Сохраняем аватар и обновляем пользователя
            String avatarUrl = avatarService.saveAvatar(file, user.getId());
            user.setAvatarUrl(avatarUrl);
            userService.updateUser(user);

            response.put("success", true);
            response.put("avatarUrl", avatarUrl);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Ошибка сервера: " + e.getMessage());
        }

        return response;
    }

    @GetMapping("/profile/becomeSeller/{userId}")
    public String showBecomeSellerForm(@PathVariable int userId, Model model) {
        Optional<User> userOptional = userRepository.findById(userId);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            model.addAttribute("user", user);
            return "becomeSeller";
        } else {
            model.addAttribute("error", "Пользователь не найден");
            return "error";
        }
    }

    @PostMapping("/profile/becomeSeller")
    public String becomeSeller(@RequestParam("userId") int userId,
                               RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            userService.updateUserRoleToSeller(userId);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Статус успешно изменён на 'Продавец'");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Ошибка при изменении статуса: " + e.getMessage());
        }
        session.invalidate(); //удаляем текущую сессию
        return "redirect:/login"; //перенаправляем на страницу входа
    }

    @GetMapping("/profile/deleteUser/{userId}")
    public String deleteUserForma(@PathVariable int userId, Model model) {
        Optional<User> userOptional = userRepository.findById(userId);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            model.addAttribute("user", user);
            return "deleteUser";
        } else {
            model.addAttribute("error", "Пользователь не найден");
            return "error";
        }
    }

    @PostMapping("/profile/deleteUser")
    @Transactional
    public String deleteUser(
            @RequestParam("userId") int userId,
            HttpSession session,
            Model model) {

        Optional<User> userOptional = userRepository.findById(userId);
        Optional<Role> roleOptional = roleRepository.findByUserId(userId);
        List<Lot> lots = lotRepository.findBySellerId(userId);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            Role role = roleOptional.get();

            try {
                lotRepository.deleteBySellerId(userId);
                roleRepository.deleteByUserId(userId);
                userRepository.deleteById(userId);

                return "redirect:/login";
            } catch (Exception e) {
                model.addAttribute("error", "Ошибка при удалении пользователя: " + e.getMessage());
                return "error";
            }
        } else {
            model.addAttribute("error", "Пользователь не найден");
            return "error";
        }
    }
}
