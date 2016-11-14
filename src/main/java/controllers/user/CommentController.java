package controllers.user;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.Comment;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

/**
 * Created by wopqw on 12.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/s/createcomment"})
public class CommentController extends BaseServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("doPost createComment");

        HttpSession httpSession = req.getSession();

        User user = (User) httpSession.getAttribute(SUSER);

        Comment.CommentBuilder commentBuilder = Comment.builder();

        String text = req.getParameter("comment");

        long postId = Long.parseLong(req.getParameter("postId"));

        Comment comment = commentBuilder
                .postId(postId)
                .text(text)
                .userId(user.getId())
                .date(LocalDate.now())
                .time(LocalTime.now())
                .build();

        commentDAO.addComment(comment);

//        req.getRequestDispatcher("/home/").forward(req, resp);
    }
}
