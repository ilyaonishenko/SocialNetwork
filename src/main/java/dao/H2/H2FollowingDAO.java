package dao.H2;

import common.ConnectionPool;
import dao.FollowingDAO;
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
    public Collection<Following> getFollowingsById(long followerId) {

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


    @Override
    @SneakyThrows
    public boolean revertFollowing(Following following) {

        try( Connection connection = connectionPool.getConnection()){

//            String sql = "INSERT INTO Following (follower_id, follow_id) VALUES (?,?)";
            String sql = "SELECT * FROM Following WHERE follower_id = ? AND follow_id = ?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, following.getFollowerId());
            preparedStatement.setLong(2, following.getFollowId());

            ResultSet rs = preparedStatement.executeQuery();
            int count = 0;
            while (rs.next())
                count++;
            if(count==0){
                addFollowing(following);
                return true;
            } else {
                deleteFollowing(following);
                return false;
            }

        }
    }

    @Override
    @SneakyThrows
    public boolean isFirstFollowSecond(long followerId, long followId) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "SELECT * FROM Following WHERE follower_id = ? AND follow_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setLong(1,followerId);
            preparedStatement.setLong(2,followId);

            ResultSet rs = preparedStatement.executeQuery();

            int count = 0;

            while (rs.next())
                count++;

            return count!=0;
        }
    }

    @Override
    @SneakyThrows
    public void addFollowing(Following following){

        try( Connection connection = connectionPool.getConnection()){

            String sql = "INSERT INTO Following (follower_id, follow_id) VALUES (?,?)";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, following.getFollowerId());
            preparedStatement.setLong(2, following.getFollowId());

            preparedStatement.executeUpdate();
        }
    }

    @Override
    @SneakyThrows
    public void deleteFollowing(Following following) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "DELETE FROM Following WHERE follower_id = ? AND follow_id = ?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setLong(1,following.getFollowerId());
            preparedStatement.setLong(2,following.getFollowId());

            preparedStatement.executeUpdate();
        }
    }

    @Override
    @SneakyThrows
    public int countFollowersById(long followId){

        try(Connection connection = connectionPool.getConnection()){

            String sql = "SELECT COUNT(follower_id) FROM Following WHERE follow_id = ?";
            final PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, followId);

            final ResultSet rs = preparedStatement.executeQuery();

            if(rs.next())
                return rs.getInt(1);
            return 0;
        }
    }

    @Override
    @SneakyThrows
    public int countFollowingsById(long followerId){

        try(Connection connection = connectionPool.getConnection()){

            String sql = "SELECT COUNT(follow_id) FROM Following WHERE follower_id = ?";
            final PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, followerId);

            final ResultSet rs = preparedStatement.executeQuery();

            if(rs.next())
                return rs.getInt(1);
            return 0;
        }
    }
}
