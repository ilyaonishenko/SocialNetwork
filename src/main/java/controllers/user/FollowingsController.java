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
@WebServlet(urlPatterns = {"/followings/*"})
public class FollowingsController extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getPathInfo().substring(1);

        Optional<User> optUser = userDAO.getByUsername(username);
        
        if(optUser.isPresent()){

            User user = optUser.get();
            HashSet<Following> followings =
                    (HashSet<Following>) followingDAO.getFollowingsById(user.getId());

//          noinspection OptionalGetWithoutIsPresent
            HashSet<User> followingUsers =
                    followings.stream()
                        .map(f -> userDAO.getById(f.getFollowId()).get())
                        .collect(Collectors.toCollection(HashSet::new));
            req.setAttribute(USER, user);
            req.setAttribute(FOLLOWINGS,followingUsers);
            req.getRequestDispatcher("/WEB-INF/user/following.jsp").forward(req, resp);
        }
        // TODO: 03.11.16 error no such user
    }
}
