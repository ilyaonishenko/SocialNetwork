package controllers.user;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.Following;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Created by wopqw on 03.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = "/followers/*")
public class FollowersController extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getPathInfo().substring(1);

        log.info("looking for "+username+" followers");

        Optional<User> optUser = userDAO.getByUsername(username);

        if (optUser.isPresent()){

            User user = optUser.get();

            HashSet<Following> followers =
                    (HashSet<Following>) followingDAO.getFollowersById(user.getId());

//          noinspection OptionalGetWithoutIsPresent
            HashSet<User> followerUsers =
                    followers.stream()
                    .map(f -> userDAO.getById(f.getFollowerId()).get())
                    .collect(Collectors.toCollection(HashSet::new));

            req.setAttribute(USER, user);
            req.setAttribute(FOLLOWERS, followerUsers);

            req.getRequestDispatcher("/WEB-INF/user/followers.jsp").forward(req, resp);
        }

        // TODO: 03.11.16 error no usch user or profile is private
    }
}
