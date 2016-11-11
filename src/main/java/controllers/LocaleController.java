package controllers;

import common.OptionalConsumer;
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

    private static final String RU = "ru_RU";
    private static final String EN = "en_US";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("changeLocale");

        String url = req.getHeader("Referer").split(req.getServerName()+":"+req.getServerPort()+"/")[1];

        Optional<String> optional= Optional.ofNullable((String) req.getSession().getAttribute("locale"));

        OptionalConsumer.of(optional)
                .ifPresent(l->{
                    log.info("present");
                    if(l.equals(EN))
                        req.getSession().setAttribute("locale", RU);
                    else req.getSession().setAttribute("locale", EN);
                }).ifNotPresent(() -> {
                    log.info("not present");
                    req.getSession().setAttribute("locale", EN);
        });
        resp.sendRedirect(url);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
