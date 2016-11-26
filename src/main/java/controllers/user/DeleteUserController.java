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

/**
 * Created by wopqw on 26.11.16.
 */
@Slf4j
@WebServlet("/s/deleteuser")
public class DeleteUserController extends BaseServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("delete User doPost");

        HttpSession httpSession = req.getSession();

        User user = (User) httpSession.getAttribute(SUSER);

        userDAO.deleteUser(user);

        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("deleteUser doGet");

        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}
