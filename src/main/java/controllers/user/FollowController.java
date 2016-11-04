package controllers.user;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.Following;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by wopqw on 03.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = "/s/follow/")
public class FollowController extends BaseServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession httpSession = req.getSession();

        User user = (User)httpSession.getAttribute(USER);

        log.info("user from session: "+user.getUsername() );

        String id = req.getParameter("followId");

        log.info("id from req: "+id);

        long followId = Long.parseLong(id);

        log.info("user to follow: "+followId);

        Following following = new Following(user.getId(),followId);

        followingDAO.addFollowing(following);
    }
}
