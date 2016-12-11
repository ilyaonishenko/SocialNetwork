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
import java.util.Optional;

/**
 * Created by wopqw on 03.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = "/s/follow")
public class FollowController extends BaseServlet {
    private HttpSession httpSession;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        httpSession = req.getSession();

        User user = (User)httpSession.getAttribute(SUSER);

        log.info("user from session: "+user.getUsername() );

        Optional<User> optFollowUser = userDAO.getByUsername(req.getParameter("username"));

        // noinspection OptionalGetWithoutIsPresent
        long followId = optFollowUser.get().getId();

        log.info("user to follow: "+followId);

        Following following = new Following(user.getId(),followId);

        boolean answr = followingDAO.revertFollowing(following);

        writeToResponse(resp, String.valueOf(answr));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        httpSession = req.getSession();
        User user = (User) httpSession.getAttribute(SUSER);
        log.info("session user: "+user);

        String username = req.getParameter("username");

        Optional<User> optFollowedUser = userDAO.getByUsername(username);

        //noinspection OptionalGetWithoutIsPresent
        boolean answer = followingDAO.isFirstFollowSecond(user.getId(),optFollowedUser.get().getId());

        log.info("answer: "+String.valueOf(answer));

        writeToResponse(resp, String.valueOf(answer));
    }
}
