package webapi;

import com.fasterxml.jackson.core.JsonProcessingException;
import common.JsonWrapper;
import dao.FollowingDAO;
import dao.PostDAO;
import dao.UserDAO;
import listeners.Initer;
import lombok.extern.slf4j.Slf4j;
import model.Post;

import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.util.HashSet;
import java.util.stream.Collectors;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;


/**
 * Created by wopqw on 05.11.16.
 */

@Slf4j
@Path("/posts/")
public class PostResource {

    private static PostDAO postDAO;
    private static UserDAO userDAO;
    private static FollowingDAO followingDAO;

    @Context
    public void init(ServletContext servletContext) {

        if (postDAO == null) {
            postDAO = (PostDAO) servletContext.getAttribute(Initer.POST_DAO);
        }
        if (userDAO == null) {
            userDAO = (UserDAO) servletContext.getAttribute(Initer.USER_DAO);
        }
        if (followingDAO == null) {
            followingDAO = (FollowingDAO) servletContext.getAttribute(Initer.FOLLOWING_DAO);
        }
    }

    @GET
    @Produces(APPLICATION_JSON)
    public Response getPostByUser(
            @QueryParam("userId") long userId,
            @QueryParam("visitorId") long visitorId,
            @QueryParam("offsetId") int offsetId,
            @QueryParam("limit") int limit)
            throws JsonProcessingException {

        log.info("getPostsByUser");

        // TODO: 06.11.16 make limitation by sql-query
        HashSet<Post> posts = postDAO.getAllByUser(userId).stream()
                .limit(limit).collect(Collectors.toCollection(HashSet::new));

        log.info(String.valueOf(posts.size()));

        String json = JsonWrapper.toJson(posts);

        return Response.ok(json).build();
    }

    @GET
    @Path("timeline/")
    @Produces(APPLICATION_JSON)
    public Response getTimeLine(
            @QueryParam("userId") long userId,
            @QueryParam("offsetId") int offsetId,
            @QueryParam("limit") int limit)
            throws JsonProcessingException {

        log.info("getUserTimeline");

        HashSet<Post> timeline = (HashSet<Post>) postDAO.getUserTimeline(userId, offsetId, limit);

        String json = JsonWrapper.toJson(timeline);

        log.info(json);

        return Response.ok(json).build();
    }

}
