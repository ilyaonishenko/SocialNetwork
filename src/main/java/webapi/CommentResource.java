package webapi;

import com.fasterxml.jackson.core.JsonProcessingException;
import common.JsonWrapper;
import dao.CommentDAO;
import listeners.Initer;
import lombok.extern.slf4j.Slf4j;
import model.Comment;

import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

/**
 * Created by wopqw on 09.11.16.
 */
@Slf4j
@Path("/comments/")
public class CommentResource {

    private static CommentDAO commentDAO;

    @Context
    public void init(ServletContext servletContext){

        if(commentDAO == null)
            commentDAO = (CommentDAO) servletContext.getAttribute(Initer.COMMENT_DAO);
    }

    @GET
    @Path("{postId}")
    @Produces(APPLICATION_JSON)
    public Response getCommentsByPost(@PathParam("postId") long postId) throws JsonProcessingException {

        ArrayList<Comment> comments = (ArrayList<Comment>) commentDAO.getCommentsFromPost(postId);

        String json = JsonWrapper.toJson(comments);

        return Response.ok(json).build();
    }

    @GET
    @Path("add")
    @Produces(APPLICATION_JSON)
    public Response addComment(
            @QueryParam("userId") long userId,
            @QueryParam("postId") long postId,
            @QueryParam("text") String text) throws JsonProcessingException {

        Comment.CommentBuilder commentBuilder = Comment.builder();

        Comment newComment = commentBuilder.userId(userId)
                                .postId(postId)
                                .text(text)
                                .date(LocalDate.now())
                                .time(LocalTime.now())
                                .build();

        commentDAO.addComment(newComment);

        return Response.ok(JsonWrapper.toJson(newComment)).build();
    }
}
