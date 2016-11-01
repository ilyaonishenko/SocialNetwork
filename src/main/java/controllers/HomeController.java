package controllers;

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
 * Created by wopqw on 31.10.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/home/*"})
public class HomeController extends BaseServlet {

    private static final String USER = "user";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        HttpSession httpSession = req.getSession();
        User user = (User)httpSession.getAttribute(USER);
        log.info("in homeController with user "+user.getUsername());
        req.setAttribute(USER,user);
        req.getRequestDispatcher("/WEB-INF/home/home.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
