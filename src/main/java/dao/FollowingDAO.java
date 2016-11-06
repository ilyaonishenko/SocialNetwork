package dao;

import model.Following;

import java.util.Collection;

/**
 * Created by wopqw on 02.11.16.
 */
public interface FollowingDAO {

//    get followers of followId
    Collection<Following> getFollowersById(long followId);

//    get all follows of followerId
    Collection<Following> getFollowingsById(long followerId);

    boolean revertFollowing(Following following);

    boolean isFirstFollowSecond(long followerId, long followId);

    void addFollowing(Following following);

    void deleteFollowing(Following following);
}
