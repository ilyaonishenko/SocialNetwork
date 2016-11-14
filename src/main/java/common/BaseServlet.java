package common;

import dao.*;
import listeners.Initer;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by wopqw on 30.10.16.
 */
public class BaseServlet extends HttpServlet {

    protected static final String USER = "user";
    protected static final String SUSER = "sUser";
    protected static final String USER_ROLE = "userRoles";
    protected static final String FOLLOWINGS = "followings";
    protected static final String FOLLOWERS = "followers";
    protected static final String POST = "post";
    protected static final String LIKE = "like";
    protected static final String COMMENT = "comment";

    @SuppressWarnings("WeakerAccess")
    protected UserDAO userDAO;
    protected UserRoleDAO userRoleDAO;
    protected FollowingDAO followingDAO;
    protected PostDAO postDAO;
    protected LikeDAO likeDAO;
    protected CommentDAO commentDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {

        userDAO = (UserDAO) config.getServletContext().getAttribute(Initer.USER_DAO);
        userRoleDAO = (UserRoleDAO) config.getServletContext().getAttribute(Initer.USER_ROLE_DAO);
        followingDAO = (FollowingDAO) config.getServletContext().getAttribute(Initer.FOLLOWING_DAO);
        postDAO = (PostDAO) config.getServletContext().getAttribute(Initer.POST_DAO);
        likeDAO = (LikeDAO) config.getServletContext().getAttribute(Initer.LIKE_DAO);
        commentDAO = (CommentDAO) config.getServletContext().getAttribute(Initer.COMMENT_DAO);
    }

    protected void writeToResponse(HttpServletResponse resp, String answer)
            throws IOException {

        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(String.valueOf(answer));

    }
}
