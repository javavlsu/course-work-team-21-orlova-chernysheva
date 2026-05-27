package ru.auction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.auction.model.Role;
import ru.auction.model.User;
import ru.auction.repository.RoleRepository;
import ru.auction.repository.UserRepository;
import ru.auction.service.UserService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@Controller
public class LoginController {
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginForm(@RequestParam(required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", "Неверные учётные данные");
        }
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(
            @RequestParam String login,
            @RequestParam String password,
            HttpSession session) {

        Optional<User> userOptional = userRepository.findByUsername(login);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (password.equals(user.getPassword())) {
                // Сохраняем полный объект пользователя в сессии
                session.setAttribute("userId", user.getId());
                session.setAttribute("user", user);
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("login", login);

                // Получаем роль пользователя: ищем в таблице roles по user.id
                Optional<Role> roleOptional = roleRepository.findByUserId(user.getId());
                List<Role> userRoles;

                if (roleOptional.isPresent()) {
                    userRoles = new ArrayList<>();
                    userRoles.add(roleOptional.get());
                } else {
                    userRoles = new ArrayList<>();
                }
                String roleName = "USER"; // роль по умолчанию

                if (!userRoles.isEmpty()) {
                    // Берём первую роль (если несколько — можно доработать логику)
                    roleName = userRoles.get(0).getRole();
                }

                session.setAttribute("role", roleName);
                logger.info("Пользователь " + login + " успешно вошёл в систему. Роль: " + roleName);

                return "redirect:/index";
            } else {
                logger.warning("Неудачная попытка входа для пользователя: " + login);
            }
        } else {
            logger.warning("Попытка входа с несуществующим логином: " + login);
        }

        return "redirect:/login?error=Invalid credentials";
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        return "register"; // Предполагаем, что шаблон называется register.jsp
    }

    @PostMapping("/register")
    public String processRegistration(
            @RequestParam String login,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String lastName,
            @RequestParam String firstName,
            @RequestParam String numberPhone,
            Model model) {

        try {
            User registeredUser = userService.registerNewUser(login, password, "USER", email, numberPhone, lastName, firstName);
            model.addAttribute("success", "Регистрация прошла успешно! Теперь вы можете войти в систему.");
            return "login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        String username = (String) session.getAttribute("login");
        session.invalidate();
        logger.info("Пользователь " + username + " вышел из системы");
        return "redirect:/index";
    }
}
