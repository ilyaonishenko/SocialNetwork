package webapi;

import com.fasterxml.jackson.core.JsonProcessingException;
import common.JsonWrapper;
import dao.*;
import listeners.Initer;
import lombok.extern.slf4j.Slf4j;
import model.Post;
import model.PostView;

import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.util.Collection;
import java.util.HashSet;
import java.util.Optional;
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
    private static LikeDAO likeDAO;
    private static CommentDAO commentDAO;

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
        if (likeDAO == null)
            likeDAO = (LikeDAO) servletContext.getAttribute(Initer.LIKE_DAO);
        if (commentDAO == null)
            commentDAO = (CommentDAO) servletContext.getAttribute(Initer.COMMENT_DAO);
    }

    // TODO: 08.11.16 Add likes

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

        Collection<PostView> postViews = createPostViews(posts);

        log.info(String.valueOf(postViews.size()));

        String json = JsonWrapper.toJson(postViews);

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

        HashSet<PostView> pvTimeline = (HashSet<PostView>) createPostViews(timeline);

        String json = JsonWrapper.toJson(pvTimeline);

        return Response.ok(json).build();
    }

    @GET
    @Path("{id}")
    @Produces(APPLICATION_JSON)
    public Response getPostById(@PathParam("id") long id) throws JsonProcessingException {

        Optional<Post> optPost = postDAO.getPostById(id);

        if(optPost.isPresent()){

            Post post = optPost.get();
            PostView postView =
                    new PostView(post,likeDAO.countByPostId(post.getId()),commentDAO.countByPostId(post.getId()));

            String json = JsonWrapper.toJson(postView);
            return Response.ok(json).build();
        } else {
            return Response.serverError().build();
        }
    }

    private Collection<PostView> createPostViews(Collection<Post> posts){

        HashSet<PostView> postViews = new HashSet<>();

        PostView.PostViewBuilder postViewBuilder = PostView.builder();

        posts.forEach(p -> postViews.add(
                postViewBuilder
                        .post(p)
                        .likesCount(likeDAO.countByPostId(p.getId()))
                        .commentsCount(commentDAO.countByPostId(p.getId()))
                        .build()));

        return postViews;
    }

//    @POST
//    @Path("create")
//    public Response createPost(
//            @QueryParam("userId") long userId,
//            @QueryParam("text") String text,
//            @QueryParam("expandable") boolean expandable,
//            @QueryParam("privacy") boolean privacy){
//
//        Post.PostBuilder postBuilder = Post.builder();
//
//        postDAO.addPost(
//                postBuilder
//                        .authorId(userId)
//                        .date(LocalDate.now())
//                        .time(LocalTime.now())
//                        .text(text)
//                        .expandable(expandable)
//                        .privacy(privacy)
//                        .build());
//    }
}
