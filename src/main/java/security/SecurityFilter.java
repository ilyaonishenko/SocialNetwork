package security;

import dao.UserDAO;
import filters.HttpFilter;
import model.User;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.Optional;

/**
 * Created by wopqw on 24.10.16.
 */

@WebFilter(urlPatterns = {"/home/*"})
public class SecurityFilter implements HttpFilter {

    @SuppressWarnings("FieldCanBeLocal")
    private static String KEY = "KEY";
    private static String ROLE = "ROLE";

    private UserDAO userDAO;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

        userDAO = (UserDAO)filterConfig.getServletContext().getAttribute("userDAO");
    }

    @Override
    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpSession session = request.getSession(true);

        if(session.getAttribute(KEY)!=null)
            chain.doFilter(request,response);

        Map<String, String[]> parameterMap = request.getParameterMap();

        if(parameterMap.containsKey("j_password") && parameterMap.containsKey("j_username")){

            try {

                Optional<User> authorize = authorize(parameterMap);
                if(authorize.isPresent()) {

                    User user = authorize.get();
                    session.setAttribute(KEY, user);
                    session.setAttribute(ROLE,userDAO.getUserRole(user));
                    chain.doFilter(request, response);
                }
                else {
                    request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request,response);
                }


            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }

        } else {

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
            requestDispatcher.forward(request,response);
        }
    }

    private Optional<User> authorize(Map<String, String[]> parameterMap) throws NoSuchAlgorithmException {

        String login = parameterMap.get("j_username")[0];
        String password = parameterMap.get("j_password")[0];
        String hash = StringEncryptUtil.encrypt(password);

        return userDAO.isRegistered(login,hash);
    }
}
