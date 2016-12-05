package dao;

import model.Comment;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.stream.Collectors;

/**
 * Created by wopqw on 09.11.16.
 */
public interface CommentDAO {

    Collection<Comment> getAll();

    boolean addComment(Comment comment);

    boolean deleteComment(long commentId);

    boolean isReadyToUpdate(long postId, long offsetId);

    default Collection<Comment> getCommentsFromPost(long postId, long offsetId, long limit){

        return getAll().stream()
                .filter(c -> c.getPostId() == postId)
                .filter(c -> c.getId() > offsetId)
                .limit(limit)
                .collect(Collectors.toCollection(ArrayList::new));
    }

    default Collection<Comment> getCommentsFromUser(long userId){

        return getAll().stream()
                .filter(c -> c.getUserId() == userId)
                .collect(Collectors.toCollection(HashSet::new));
    }

    default long countByPostId(long postId){

        return getAll().stream()
                .filter(c -> c.getPostId() == postId)
                .count();
    }

    Collection<Comment> searchComment(String text);

}
