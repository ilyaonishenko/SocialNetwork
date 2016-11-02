package common;

import dao.interfaces.FollowingDAO;
import dao.interfaces.UserDAO;
import dao.interfaces.UserRoleDAO;
import listeners.Initer;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * Created by wopqw on 30.10.16.
 */
public class BaseServlet extends HttpServlet {

    protected static final String USER = "user";
    protected static final String USER_ROLE = "userRoles";

    @SuppressWarnings("WeakerAccess")
    protected UserDAO userDAO;
    protected UserRoleDAO userRoleDAO;
    protected FollowingDAO followingDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {

        userDAO = (UserDAO) config.getServletContext().getAttribute(Initer.USER_DAO);
        userRoleDAO = (UserRoleDAO) config.getServletContext().getAttribute(Initer.USER_ROLE_DAO);
        followingDAO = (FollowingDAO) config.getServletContext().getAttribute(Initer.FOLLOWING_DAO);
    }
}
