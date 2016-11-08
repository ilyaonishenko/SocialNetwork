package dao.H2;

import common.ConnectionPool;
import dao.LikeDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.Like;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import java.util.HashSet;

/**
 * Created by wopqw on 08.11.16.
 */
@AllArgsConstructor
public class H2LikeDAO implements LikeDAO {

    private ConnectionPool connectionPool;

    @Override
    @SneakyThrows
    public Collection<Like> getAll() {

        try(Connection connection = connectionPool.getConnection()){

            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM Like");

            return createCollection(rs);
        }
    }

    @Override
    @SneakyThrows
    public boolean addLike(Like like){

        try(Connection connection = connectionPool.getConnection()){

            String sql = "INSERT INTO \"Like\" (from_userId, to_postId) VALUES (?, ?) ";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1,like.getFromUserId());
            preparedStatement.setLong(2,like.getToPostId());

            return preparedStatement.executeUpdate()>0;
        }
    }

    @Override
    @SneakyThrows
    public boolean removeLike(Like like){

        try(Connection connection = connectionPool.getConnection()){

            String sql = "DELETE FROM \"Like\" WHERE from_userId = ? AND to_postId = ?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, like.getFromUserId());
            preparedStatement.setLong(2, like.getToPostId());

            return preparedStatement.executeUpdate()>0;

        }
    }

    @SneakyThrows
    private Collection<Like> createCollection(ResultSet rs){

        Collection<Like> likes = new HashSet<>();

        Like.LikeBuilder likeBuilder = Like.builder();

        while (rs.next())
            likes.add(
                    likeBuilder
                        .fromUserId(rs.getLong("from_userId"))
                        .toPostId(rs.getLong("to_postId"))
                        .build());
        return likes;
    }
}
