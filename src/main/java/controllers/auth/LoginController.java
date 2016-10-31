package controllers.auth;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.User;
import security.StringEncryptUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.Optional;

/**
 * Created by wopqw on 31.10.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/login"})
public class LoginController extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession httpSession = req.getSession();

        Map<String, String[]> reqParameterMap = req.getParameterMap();

        String username = reqParameterMap.get("j_username")[0];
        String password = reqParameterMap.get("j_password")[0];

        String nextURL = Optional.ofNullable(
                (String) httpSession.getAttribute("next")).orElse("/home/");

        Optional<User> userOpt = userDAO.getByUsername(username);

        if (!userOpt.isPresent()){
            resp.sendError(406, "This username is not found");
            return;
        }

        User user = userOpt.get();
        if(secCheck(user.getUsername(),password)){

            log.info("secCheck is gone");
            httpSession.setAttribute("user",user);
            resp.sendRedirect(nextURL);
        } else {
            req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req,resp);
        }
    }

    private boolean secCheck(String username, String password){

        try {
            return userDAO.isRegistered(
                    username,
                    StringEncryptUtil.encrypt(password)
            );
        } catch (NoSuchAlgorithmException e){
            e.printStackTrace();
        }
        return false;
    }
}
