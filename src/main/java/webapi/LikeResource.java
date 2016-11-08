package webapi;

import com.fasterxml.jackson.core.JsonProcessingException;
import common.JsonWrapper;
import dao.LikeDAO;
import listeners.Initer;
import lombok.extern.slf4j.Slf4j;
import model.Like;

import javax.servlet.ServletContext;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

/**
 * Created by wopqw on 08.11.16.
 */
@Slf4j
@Path("/likes/")
public class LikeResource {

    private static LikeDAO likeDAO;


    @Context
    public void init(ServletContext servletContext){

        if(likeDAO == null)
            likeDAO = (LikeDAO) servletContext.getAttribute(Initer.LIKE_DAO);
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
}
