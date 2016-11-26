package dao;

import model.Post;

import java.util.Collection;
import java.util.Optional;

/**
 * Created by wopqw on 05.11.16.
 */
public interface PostDAO {

    Collection<Post> getAll();

    Collection<Post> getUserTimeline(long userId, long offsetId, int limit);

    void addPost(Post post);

    Optional<Post> getPostById(long id);

    Collection<Post> getAllByUser(long userId, long offsetId, int limit);

    boolean isPostsReadyToUpdate(long userId, long offsetId);

    boolean isTimelineReadyToUpdate(long userId, long offsetId);

    int countUserPosts(long userId);

    void deletePost(long postId);
}
