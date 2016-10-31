package controllers;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        String username = req.getPathInfo().substring(1);

        Optional<User> optUser = userDAO.getByUsername(username);

        if(optUser.isPresent()){
            
            User user = optUser.get();
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/user/user.jsp").forward(req,resp);
        } else {
            // TODO: 30.10.16 make error page
        }
    }
}
