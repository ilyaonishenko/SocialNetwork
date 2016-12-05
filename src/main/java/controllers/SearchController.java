package controllers;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by wopqw on 05.12.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/s/search/*"})
public class SearchController extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("doget in search");

        String text = req.getParameter("srch-term");

//        usersearch

        ArrayList<User> possibleUsers = (ArrayList<User>) userDAO.searchUser(text);

        req.setAttribute("possibleUsers", possibleUsers);

        req.getRequestDispatcher("/WEB-INF/searchResults.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
