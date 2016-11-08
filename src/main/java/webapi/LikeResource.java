package webapi;

import com.fasterxml.jackson.core.JsonProcessingException;
import common.JsonWrapper;
import dao.LikeDAO;
import dao.PostDAO;
import dao.UserDAO;
import listeners.Initer;
import lombok.extern.slf4j.Slf4j;
import model.Like;
import model.Post;
import model.User;

import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.util.Collection;
import java.util.HashSet;
import java.util.stream.Collectors;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

/**
 * Created by wopqw on 08.11.16.
 */
@Slf4j
@Path("/likes/")
public class LikeResource {

    private static LikeDAO likeDAO;
    private static UserDAO userDAO;
    private static PostDAO postDAO;


    @Context
    public void init(ServletContext servletContext){

        if(likeDAO == null)
            likeDAO = (LikeDAO) servletContext.getAttribute(Initer.LIKE_DAO);
        if(userDAO == null)
            userDAO = (UserDAO) servletContext.getAttribute(Initer.USER_DAO);
        if(postDAO == null)
            postDAO = (PostDAO) servletContext.getAttribute(Initer.POST_DAO);
    }


    @POST
    @Path("add")
    @Produces(APPLICATION_JSON)
    public Response addLike(
            @QueryParam("userId") long userId,
            @QueryParam("postId") long postId)
            throws JsonProcessingException {

        log.info("in addLike method with userId:{} and postId:{}",userId,postId);

        Like.LikeBuilder likeBuilder = Like.builder();

        boolean answer = likeDAO.addLike(likeBuilder
                .fromUserId(userId)
                .toPostId(postId)
                .build());

        String json = JsonWrapper.toJson(answer);

        return Response.ok(json).build();
    }

    @POST
    @Path("remove")
    @Produces(APPLICATION_JSON)
    public Response removeLike(
            @QueryParam("userId") long userId,
            @QueryParam("postId") long postId)
        throws JsonProcessingException{

        log.info("in removeLike method with userId:{} and postId:{}",userId,postId);

        Like.LikeBuilder likeBuilder = Like.builder();

        boolean answer = likeDAO.removeLike(likeBuilder
                .fromUserId(userId)
                .toPostId(postId)
                .build());

        String json = JsonWrapper.toJson(answer);

        return Response.ok(json).build();
    }

//    return users
    @GET
    @Path("post/{postId}")
    @Produces(APPLICATION_JSON)
    public Response liked(@PathParam("postId") long postId) throws JsonProcessingException{

        log.info("who likes this post {}",postId);

        Collection<Like> likes = likeDAO.getByPostId(postId);

        //noinspection OptionalGetWithoutIsPresent
        Collection<User> users = likes.stream()
                        .map(l -> userDAO.getById(l.getFromUserId()).get())
                        .collect(Collectors.toCollection(HashSet::new));


        return Response.ok(JsonWrapper.toJson(users)).build();
    }

//    return posts
    @GET
    @Path("user/{userId}")
    @Produces(APPLICATION_JSON)
    public Response userLikes(@PathParam("userId") long userId) throws JsonProcessingException{

        log.info("likes by this user: {}", userId);

        Collection<Like> likes = likeDAO.getAllUserPost(userId);

        //noinspection OptionalGetWithoutIsPresent
        Collection<Post> posts = likes.stream()
                .map(l -> postDAO.getPostById(l.getToPostId()).get())
                .collect(Collectors.toCollection(HashSet::new));

        return Response.ok(JsonWrapper.toJson(posts)).build();
    }
}
