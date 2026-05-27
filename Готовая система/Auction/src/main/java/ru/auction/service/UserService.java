package ru.auction.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.auction.model.Role;
import ru.auction.model.User;
import ru.auction.repository.RoleRepository;
import ru.auction.repository.UserRepository;

import java.util.Optional;
@Service
public class UserService {
    // Инъекция репозиториев Spring Data JPA
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    // Рекомендуемый способ инъекции зависимостей - через конструктор
    @Autowired
    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    // Метод аутентификации
    // @Transactional - можно добавить, если аутентификация может включать запись (например, логирование попыток)
    public User authenticate(String username, String password) {
        // Используем репозиторий для проверки учетных данных
        // existsByUsernameAndPassword проверяет, существует ли запись с такими username и password
        if (!userRepository.existsByUsernameAndPassword(username, password)) {
            return null; // Учетные данные неверны, возвращаем null
        }

        // Если учетные данные верны, находим пользователя по имени пользователя
        // findByUsername возвращает Optional<Users>
        Optional<User> userOptional = userRepository.findByUsername(username);

        // Возвращаем объект Users, если он найден, иначе null (хотя по логике existsByUsernameAndPassword он должен быть)
        return userOptional.orElse(null);
    }

    // Метод получения роли для пользователя
    @Transactional(readOnly = true) // Читающая транзакция, если нет изменений
    public Role getRoleForUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("Пользователь не может быть null");
        }
        // Проверяем ID, хотя Spring Data JPA репозиторий вернет Optional, который может быть пустым
        if (user.getId() <= 0) {
            throw new IllegalArgumentException("ID пользователя некорректен");
        }

        // Используем RolesRepository для получения роли по ID пользователя
        // findByUser_Id возвращает Optional<Roles>
        Optional<Role> roleOptional = roleRepository.findById(user.getId());

        // Возвращаем роль, если найдена, иначе null
        return roleOptional.orElse(null);
    }

    // Метод получения имени роли по ID пользователя
    @Transactional(readOnly = true)
    public String getRoleNameByUserId(Integer userId) {
        if (userId == null || userId <= 0) {
            throw new IllegalArgumentException("ID пользователя некорректен");
        }

        Optional<Role> roleOptional = roleRepository.findById(userId);

        // Если роль найдена, возвращаем ее название, иначе null
        return roleOptional.map(Role::getRole).orElse(null);
    }

    // Дополнительные методы, если нужны (например, для регистрации новых пользователей)
    @Transactional
    public User registerNewUser(String username, String password, String roleName, String email,
                                String numberPhone, String lastName, String firstName) {
        if (userRepository.existsByUsername(username)) {
            throw new IllegalArgumentException("Пользователь с таким именем уже существует.");
        }

        User newUser = new User();
        newUser.setLogin(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setLastName(lastName);
        newUser.setFirstName(firstName);
        newUser.setNumberPhone(numberPhone);

        Role newRole = new Role();
        newRole.setRole(roleName);

        // Устанавливаем двустороннюю связь
        newUser.setRole(newRole);
        newRole.setUser(newUser);

        // Сохраняем только пользователя — роль сохранится автоматически благодаря каскаду
        return userRepository.save(newUser);
    }

    public User updateUser(User user) {
        return userRepository.save(user);
    }

    @Transactional
    public void updateUserRoleToSeller(int userId) {
        // Находим роль SELLER по userId
        Role role = roleRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Роль не найдена для пользователя"));

        // Обновляем роль
        role.setRole("SELLER");
        roleRepository.save(role);
    }
}
