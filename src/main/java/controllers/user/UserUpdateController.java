package controllers.user;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;

/**
 * Created by wopqw on 26.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/s/updateprofile"})
public class UserUpdateController extends BaseServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("updateprofile dopost");

        HttpSession httpSession = req.getSession();

        User user = (User) httpSession.getAttribute(SUSER);

        User.UserBuilder userBuilder = User.builder();

        Map<String, String[]> map = req.getParameterMap();



        User updatedUser = userBuilder.email(Optional.ofNullable(map.get("email")[0]).orElse(user.getEmail()))
                .firstName(Optional.ofNullable(map.get("firstName")[0]).orElse(user.getFirstName()))
                .lastName(Optional.ofNullable(map.get("lastName")[0]).orElse(user.getLastName()))
                .username(user.getUsername())
                .id(user.getId())
                .build();

        log.info(updatedUser.toString());

        user = userDAO.updateUser(updatedUser);

        httpSession.setAttribute(SUSER, user);

        req.setAttribute("updated", true);

        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("updateprofile doget");

        req.getRequestDispatcher("/WEB-INF/user/updateUser.jsp").forward(req,resp);
    }
}
