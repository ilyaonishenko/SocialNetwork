package controllers.user;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.User;
import model.UserView;
import security.StringEncryptUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

/**
 * Created by wopqw on 30.10.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/user/*"})
public class UserController extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession httpSession = req.getSession();

        String username = req.getPathInfo().substring(1);

        Optional<User> optUser = userDAO.getByUsername(username);
        Optional<User> optSUser = StringEncryptUtil.getSUserOpt(httpSession);
        log.info(String.valueOf(optSUser));

        if(optUser.isPresent()){
            User user = optUser.get();
            UserView.UserViewBuilder userViewBuilder = UserView.builder();
            UserView userView = userViewBuilder.user(user)
                    .posts(postDAO.countUserPosts(user.getId()))
                    .followers(followingDAO.countFollowersById(user.getId()))
                    .followings(followingDAO.countFollowingsById(user.getId()))
                    .build();
            req.setAttribute(USER, userView);
            if (!optSUser.isPresent()){
                log.info("not isPresent");
                httpSession.setAttribute(SUSER, null);
//                httpSession.getAttribute(SUSER);
            }
            req.getRequestDispatcher("/WEB-INF/user/user.jsp").forward(req,resp);
        } else {
            // TODO: 30.10.16 make error page
        }
    }
}
