package webapi;

import com.fasterxml.jackson.core.JsonProcessingException;
import common.JsonWrapper;
import dao.CommentDAO;
import dao.UserDAO;
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
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

/**
 * Created by wopqw on 09.11.16.
 */
@Slf4j
@Path("/comments/")
public class CommentResource {

    private static CommentDAO commentDAO;
    private static UserDAO userDAO;

    @Context
    public void init(ServletContext servletContext){

        if(commentDAO == null)
            commentDAO = (CommentDAO) servletContext.getAttribute(Initer.COMMENT_DAO);
        if(userDAO == null)
            userDAO = (UserDAO) servletContext.getAttribute(Initer.USER_DAO);
    }

    @GET
    @Path("{postId}")
    @Produces(APPLICATION_JSON)
    public Response getCommentsByPost(@PathParam("postId") long postId,
                                      @QueryParam("offsetId") long offsetId,
                                      @QueryParam("limit") long limit)
            throws JsonProcessingException {

        ArrayList<Comment> comments = (ArrayList<Comment>) commentDAO.getCommentsFromPost(postId, offsetId, limit);


        String json = JsonWrapper.toJson(comments);

        return Response.ok(json).build();
    }

    @POST
    @Path("add")
    @Consumes(APPLICATION_JSON)
    public void addComment(final String params){

        log.info("adding comment with text {}",params);

        HashMap<String, String> map = (HashMap<String, String>) parse(params);

        Comment.CommentBuilder commentBuilder = Comment.builder();

        Comment newComment = commentBuilder.userId((Long.parseLong(map.get("userId"))))
                                .username(map.get("username"))
                                .postId(Long.parseLong(map.get("postId")))
                                .text(map.get("text"))
                                .date(LocalDate.now())
                                .time(LocalTime.now())
                                .build();
        log.info("we have comment: {}", newComment);
        commentDAO.addComment(newComment);
    }

    @GET
    @Path("update")
    @Produces(APPLICATION_JSON)
    public Response update(@QueryParam("postId") long postId,
                           @QueryParam("offsetId") long offsetId,
                           @QueryParam("limit") long limit)
            throws InterruptedException, JsonProcessingException {

        log.info("update comments");
        log.info("offsetId: {}", offsetId);

        while(!commentDAO.isReadyToUpdate(postId, offsetId)){
            Thread.sleep(10000);
        }

        log.info("going to update");
        ArrayList<Comment> comments = (ArrayList<Comment>) commentDAO.getCommentsFromPost(postId, offsetId, limit);

        return Response.ok(JsonWrapper.toJson(comments)).build();
    }

    @DELETE
    @Path("delete/{commentId}")
    @Consumes(APPLICATION_JSON)
    public void delete(@PathParam("commentId") long commentId){

        log.info("delete comment with id: "+commentId);
        commentDAO.deleteComment(commentId);
    }

    private Map<String,String> parse(String params){

        String[] param = params.split("&");

        return Stream.of(param).collect(Collectors.toMap(
                p -> p.split("=")[0],
                p -> p.split("=")[1]
        ));
    }

    @GET
    @Path("getusername/{userId}")
    @Produces(APPLICATION_JSON)
    public Response getUsernameByUserId(@PathParam("userId") long userId) throws JsonProcessingException {

        log.info("get username by userId");
        return Response.ok(JsonWrapper.toJson(userDAO.getUsernameByUserId(userId))).build();
    }
}
