package dao;

import model.Like;

import java.util.Collection;
import java.util.HashSet;
import java.util.stream.Collectors;

/**
 * Created by wopqw on 08.11.16.
 */
public interface LikeDAO {

    Collection<Like> getAll();

    boolean addLike(Like like);

    boolean removeLike(Like like);

    default Collection<Like> getByPostId(long postId){

        return getAll().stream()
                .filter(l -> l.getToPostId() == postId)
                .collect(Collectors.toCollection(HashSet::new));
    }

    default Collection<Like> getAllUserPost(long userId){

        return getAll().stream()
                .filter(l -> l.getFromUserId() == userId)
                .collect(Collectors.toCollection(HashSet::new));
    }
}
