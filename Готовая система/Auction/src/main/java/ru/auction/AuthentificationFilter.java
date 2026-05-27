package ru.auction;

import org.springframework.beans.factory.annotation.Autowired;
import ru.auction.model.User;
import ru.auction.service.UserService;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

public class AuthentificationFilter implements Filter {
    private static final Logger logger = Logger.getLogger(AuthentificationFilter.class.getName());

    @Autowired
    private UserService userService;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Spring автоматически внедрит @Autowired поля до вызова этого метода
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpResp = (HttpServletResponse) response;
        HttpSession session = httpReq.getSession(false);

        String contextPath = httpReq.getContextPath();
        String requestURI = httpReq.getRequestURI();

        if (isPublicResource(httpReq, contextPath)) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("user") == null) {
            try {
                httpResp.sendRedirect(contextPath + "/login");
            } catch (IOException e) {
                logger.severe("Ошибка редиректа на /login: " + e.getMessage());
                httpResp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            try {
                httpResp.sendRedirect(contextPath + "/login");
            } catch (IOException e) {
                logger.severe("Ошибка редиректа на /login: " + e.getMessage());
                httpResp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            return;
        }

        // Получаем роль из сессии
        String role = (String) session.getAttribute("role");
        if (role == null) {
            logger.warning("Роль пользователя не определена в сессии для пользователя: " + user.getLogin());
            try {
                httpResp.sendRedirect(contextPath + "/access-denied");
            } catch (IOException e) {
                logger.severe("Ошибка редиректа на /access-denied: " + e.getMessage());
                httpResp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicResource(HttpServletRequest req, String contextPath) {
        String requestURI = req.getRequestURI();
        return requestURI.equals(contextPath + "/login") ||
                requestURI.equals(contextPath + "/index") ||
                requestURI.equals(contextPath + "/register") ||
                requestURI.equals(contextPath + "/privacy-policy") ||
                requestURI.startsWith(contextPath + "/css/") ||
                requestURI.startsWith(contextPath + "/js/");
    }

    @Override
    public void destroy() {
        // Очистка не нужна, если Spring управляет жизненным циклом
    }
}
