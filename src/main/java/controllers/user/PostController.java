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

/**
 * Created by wopqw on 07.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/s/createPost"})
public class PostController extends BaseServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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
                .expandable(Boolean.parseBoolean(expandable))
                .privacy(Boolean.parseBoolean(privacy))
                .build();

        postDAO.addPost(post);
        // TODO: 07.11.16 make post sending by javascript
    }
}
