package dao.H2;

import common.ConnectionPool;
import dao.interfaces.FollowingDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.Following;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.HashSet;

/**
 * Created by wopqw on 02.11.16.
 */
@AllArgsConstructor
public class H2FollowingDAO implements FollowingDAO {

    private ConnectionPool connectionPool;

    @Override
    @SneakyThrows
    public Collection<Following> getFollowersById(long followId) {

        Collection<Following> followings = new HashSet<>();
        try(Connection connection = connectionPool.getConnection()){

            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM Following WHERE follow_id = ?");
            preparedStatement.setLong(1,followId);
            ResultSet rs = preparedStatement.executeQuery();
            Following.FollowingBuilder followingBuilder = Following.builder();
            while (rs.next()){
                followings.add(
                        followingBuilder
                                .followId(rs.getLong("follow_id"))
                                .followerId(rs.getLong("follower_id"))
                                .build()
                );
            }
        }

        return followings;
    }

    @Override
    @SneakyThrows
    public Collection<Following> getFollowsById(long followerId) {

        Collection<Following> follows = new HashSet<>();
        try(Connection connection = connectionPool.getConnection()){

            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM Following WHERE follower_id = ?");
            preparedStatement.setLong(1,followerId);
            ResultSet rs = preparedStatement.executeQuery();
            Following.FollowingBuilder followingBuilder = Following.builder();
            while (rs.next()){
                follows.add(
                        followingBuilder
                                .followId(rs.getLong("follow_id"))
                                .followerId(rs.getLong("follower_id"))
                                .build()
                );
            }
        }

        return follows;
    }
}
