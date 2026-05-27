package ru.auction.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import ru.auction.model.User;
import ru.auction.repository.UserRepository;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;

@Service
public class AvatarService {

    private static final String UPLOAD_DIR = "avatars/";
    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "gif");

    @Autowired
    private Properties uploadProperties;

    private String uploadBaseDir;

    @Autowired
    private UserRepository userRepository;

    private static final Logger logger = LoggerFactory.getLogger(AvatarService.class);

    @PostConstruct
    public void init() {
        this.uploadBaseDir = uploadProperties.getProperty("app.upload.dir", "uploads/");
    }

    public boolean isValidImage(String fileName) {
        if (fileName == null || fileName.isEmpty()) return false;
        String extension = getFileExtension(fileName);
        return ALLOWED_EXTENSIONS.contains(extension.toLowerCase());
    }

    @Transactional
    public String saveAvatar(MultipartFile file, int userId) throws IOException {
        logger.info("Попытка сохранения аватара для пользователя ID: {}", userId);

        String originalFileName = file.getOriginalFilename();
        String extension = getFileExtension(originalFileName);
        String uniqueFileName = System.currentTimeMillis() + "_" +
                UUID.randomUUID().toString().substring(0, 8) + "." + extension;
        String relativePath = UPLOAD_DIR + uniqueFileName;
        String fullPath = uploadBaseDir + relativePath;

        File uploadDir = new File(fullPath).getParentFile();
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            if (!created) {
                logger.error("Не удалось создать директорию: {}", uploadDir.getAbsolutePath());
                throw new IOException("Не удалось создать директорию для загрузки: " + uploadDir.getAbsolutePath());
            }
            logger.info("Создана директория: {}", uploadDir.getAbsolutePath());
        }

        try {
            file.transferTo(new File(fullPath));
            logger.info("Файл сохранён: {}", fullPath);
        } catch (IOException e) {
            logger.error("Ошибка сохранения файла: {}", fullPath, e);
            throw e;
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));
        user.setAvatarUrl(relativePath);
        userRepository.save(user);
        logger.info("Пользователь обновлён в БД, аватар: {}", relativePath);

        return relativePath;
    }

    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex == -1 || lastDotIndex == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(lastDotIndex + 1);
    }
}

