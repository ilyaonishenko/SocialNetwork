package security;

import dao.UserDAO;
import filters.HttpFilter;
import lombok.extern.slf4j.Slf4j;
import model.User;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

/**
 * Created by wopqw on 24.10.16.
 */

@Slf4j
@WebFilter(urlPatterns = {"/home/*","/s/*"})
public class SecurityFilter implements HttpFilter {

    private static final String USER = "user";

    private UserDAO userDAO;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

        userDAO = (UserDAO)filterConfig.getServletContext().getAttribute("userDAO");
    }

    @Override
    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        log.info("dofilter come in");

        HttpSession httpSession = request.getSession();
        String fromUri = request.getRequestURI();

        Optional<User> userOpt =
                Optional.ofNullable((User) httpSession.getAttribute(USER))
                        .map(User::getId)
                        .flatMap(userDAO::getById);
        if (userOpt.isPresent()){
            log.info("true");
            httpSession.setAttribute(USER,userOpt.get());
            chain.doFilter(request,response);
        } else {
            log.info("false");
            httpSession.removeAttribute(USER);
            httpSession.setAttribute("next", fromUri);
            request.getRequestDispatcher("/login").forward(request, response);
        }
    }
}
