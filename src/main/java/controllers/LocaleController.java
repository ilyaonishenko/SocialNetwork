package controllers;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

/**
 * Created by wopqw on 11.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/changelocale"})
public class LocaleController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("changeLocale");

        String url = Optional.ofNullable(req.getParameter("next_url")).orElse("/home");

        Optional.ofNullable(req.getParameter("locale"))
                .ifPresent(l ->  req.getSession().setAttribute("locale", l));

        resp.sendRedirect(url);
    }
}
