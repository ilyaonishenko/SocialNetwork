package controllers.user;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.Post;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Optional;

/**
 * Created by wopqw on 07.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/s/createpost"})
public class PostController extends BaseServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        log.info("doPost createPost");

        HttpSession httpSession = req.getSession();

        User user = (User) httpSession.getAttribute(USER);

        Post.PostBuilder postBuilder = Post.builder();

        String text = req.getParameter("post");
        String expandable = req.getParameter("expandable");
        String privacy = req.getParameter("privacy");
        log.info("there is post: from: {}, text: {}, privacy: {}, expand: {}",
                user.getUsername(),text, privacy, expandable);
        Post post = postBuilder.authorId(user.getId())
                .text(text)
                .date(LocalDate.now())
                .time(LocalTime.now())
                .expandable(Optional.ofNullable(expandable).isPresent())
                .privacy(Optional.ofNullable(privacy).isPresent())
                .build();

        postDAO.addPost(post);

        req.getRequestDispatcher("/home/").forward(req, resp);
    }
}
