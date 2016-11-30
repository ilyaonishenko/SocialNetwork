package controllers;

import common.BaseServlet;
import common.OptionalConsumer;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

/**
 * Created by wopqw on 01.12.16.
 */
@Slf4j
@WebServlet(urlPatterns = "/errorHandler/")
public class ErrorController extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processError(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processError(req, resp);
    }

    private void processError(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("process Error");

        Throwable throwable = (Throwable) req.getAttribute("javax.servlet.error.exception");
        int statusCode = (int) req.getAttribute("javax.servlet.error.status_code");
        String servletName = (String) req.getAttribute("javax.servlet.error.servlet_name");
        String requestUri = (String) req.getAttribute("javax.servlet.error.request_uri");

        if(requestUri == null) {
            requestUri = "Unknown";
        }

        log.info("we have error:");

        OptionalConsumer.of(Optional.ofNullable(throwable)).ifPresent(t -> {
            log.info("throwable: " + t.toString());
            req.setAttribute(THROWABLE, t.getMessage());
        }).ifNotPresent(() -> {
            log.info("no throwable info");
            req.setAttribute(THROWABLE, "no message");
        });

        OptionalConsumer.of(Optional.ofNullable(statusCode)).ifPresent(code ->{
            log.info("status code: "+code);
            req.setAttribute(STATUS_CODE, code);
        }).ifNotPresent(() -> {
            log.info("no info about status code");
            req.setAttribute(STATUS_CODE, 0);
        });

        OptionalConsumer.of(Optional.ofNullable(servletName)).ifPresent(name ->{
            log.info(name);
            req.setAttribute(SERVLETNAME, name);
        }).ifNotPresent(() -> {
            log.info("no servlet name");
            req.setAttribute(SERVLETNAME, "no_name");
        });

        OptionalConsumer.of(Optional.of(requestUri)).ifPresent(uri ->{
            log.info(uri);
            req.setAttribute(REQUSET_URI, uri);
        }).ifNotPresent(() -> {
            log.info("no requestUri");
            req.setAttribute(REQUSET_URI, "no request uri");
        });

        log.info("process to error jsp");
        req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req,resp);

    }
}
