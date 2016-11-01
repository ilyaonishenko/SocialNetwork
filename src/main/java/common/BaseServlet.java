package common;

import dao.UserDAO;
import listeners.Initer;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * Created by wopqw on 30.10.16.
 */
public class BaseServlet extends HttpServlet {

    protected static final String USER = "user";

    @SuppressWarnings("WeakerAccess")
    protected UserDAO userDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {

        userDAO = (UserDAO) config.getServletContext().getAttribute(Initer.USER_DAO);
    }
}
