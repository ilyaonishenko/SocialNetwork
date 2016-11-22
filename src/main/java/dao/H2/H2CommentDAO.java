package dao.H2;

import common.ConnectionPool;
import dao.CommentDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.Comment;

import java.sql.*;
import java.util.Collection;
import java.util.HashSet;

/**
 * Created by wopqw on 09.11.16.
 */
@AllArgsConstructor
public class H2CommentDAO implements CommentDAO {

    private ConnectionPool connectionPool;

    @Override
    @SneakyThrows
    public Collection<Comment> getAll() {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "SELECT * FROM Comment";
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery(sql);

            return createCollection(rs);
        }
    }

    @Override
    @SneakyThrows
    public boolean addComment(Comment comment) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (?,?, ?, ?, ?, ?)";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, comment.getUserId());
            preparedStatement.setString(2, comment.getUsername());
            preparedStatement.setLong(3, comment.getPostId());
            preparedStatement.setString(4, comment.getText());
            preparedStatement.setDate(5, Date.valueOf(comment.getDate()));
            preparedStatement.setTime(6, Time.valueOf(comment.getTime()));

            return preparedStatement.executeUpdate()>0;

        }
    }

    @Override
    @SneakyThrows
    public boolean deleteComment(long commentId) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "DELETE FROM Comment WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, commentId);

            return preparedStatement.executeUpdate()>0;
        }
    }

    @Override
    @SneakyThrows
    public boolean isReadyToUpdate(long postId, long offsetId){

        try(Connection connection = connectionPool.getConnection()){

            String sql = "SELECT * FROM Comment WHERE to_postId = ? AND id > ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, postId);
            preparedStatement.setLong(2, offsetId);

            return preparedStatement.executeQuery().isBeforeFirst();
        }
    }

    @SneakyThrows
    private Collection<Comment> createCollection(ResultSet rs){

        Collection<Comment> comments = new HashSet<>();

        Comment.CommentBuilder commentBuilder = Comment.builder();

        while (rs.next())
            comments.add(
                    commentBuilder
                            .id(rs.getLong("id"))
                            .userId(rs.getLong("from_userId"))
                            .username(rs.getString("from_username"))
                            .postId(rs.getLong("to_postId"))
                            .text(rs.getString("text"))
                            .date(rs.getDate("date").toLocalDate())
                            .time(rs.getTime("time").toLocalTime())
                            .build());
        return comments;
    }
}
