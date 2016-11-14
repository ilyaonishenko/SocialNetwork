package controllers.auth;

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
 * Created by wopqw on 01.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/logout"})
public class LogoutController extends BaseServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession httpSession = req.getSession();

        User user = (User) httpSession.getAttribute(SUSER);

        if(user!=null){
            log.info("logout user: "+user);
        }
        httpSession.removeAttribute(SUSER);
        httpSession.invalidate();

        req.getRequestDispatcher("/").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
