package controllers.user;

import common.BaseServlet;
import lombok.extern.slf4j.Slf4j;
import model.Post;
import model.PostView;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

/**
 * Created by wopqw on 20.11.16.
 */
@Slf4j
@WebServlet(urlPatterns = {"/post/*"})
public class PostViewController extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Long postId = Long.parseLong(req.getPathInfo().substring(1));

        Post p;
        Optional<Post> optPost = postDAO.getPostById(postId);

        if (optPost.isPresent()){

            p = optPost.get();
            PostView.PostViewBuilder postViewBuilder = PostView.builder();

            PostView postView =postViewBuilder.user(userDAO.getById(p.getAuthorId()).get())
                                                .post(p)
                                                .likesCount(likeDAO.countByPostId(p.getId()))
                                                .commentsCount(commentDAO.countByPostId(p.getId()))
                                                .build();

            req.setAttribute("postView",postView);

            req.getRequestDispatcher("/WEB-INF/user/postView.jsp").forward(req,resp);

        } else {
            log.info("some error here");
        }
    }
}
