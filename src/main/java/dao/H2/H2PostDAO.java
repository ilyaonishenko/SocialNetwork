package dao.H2;

import common.ConnectionPool;
import dao.PostDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.Post;

import java.sql.*;
import java.util.Collection;
import java.util.HashSet;
import java.util.Optional;

/**
 * Created by wopqw on 05.11.16.
 */
@AllArgsConstructor
public class H2PostDAO implements PostDAO {

    private ConnectionPool connectionPool;

    @Override
    @SneakyThrows
    public Collection<Post> getAll() {

        try(Connection connection = connectionPool.getConnection()){

            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM Post");

            return createCollection(rs);
        }
    }

    @Override
    @SneakyThrows
    public Collection<Post> getUserTimeline(long userId, int offsetId, int limit) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "SELECT id, authorId, date, time, text, privacy, expandable " +
                    "FROM Post WHERE authorId IN " +
                    "(SELECT follow_id FROM Following WHERE follower_id = ?) OR authorId=? AND " +
                    "id<? ORDER BY id DESC LIMIT ?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1,userId);
            preparedStatement.setLong(2,userId);
            preparedStatement.setInt(3,offsetId);
            preparedStatement.setInt(4,limit);

            ResultSet rs = preparedStatement.executeQuery();

            return createCollection(rs);
        }
    }

    @Override
    @SneakyThrows
    public void addPost(Post post) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1, post.getAuthorId());
            preparedStatement.setDate(2, Date.valueOf(post.getDate()));
            preparedStatement.setTime(3, Time.valueOf(post.getTime()));
            preparedStatement.setString(4, post.getText());
            preparedStatement.setBoolean(5, post.isPrivacy());
            preparedStatement.setBoolean(6, post.isExpandable());

            preparedStatement.executeUpdate();
        }
    }

    @Override
    @SneakyThrows
    public Optional<Post> getPostById(long id){

        try( Connection connection = connectionPool.getConnection()){

            String sql = "SELECT * FROM Post WHERE id = ?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setLong(1,id);

            ResultSet rs = preparedStatement.executeQuery();

            return createCollection(rs).stream().findAny();
        }
    }

    @SneakyThrows
    private Collection<Post> createCollection(ResultSet rs){

        Collection<Post> posts = new HashSet<>();
        Post.PostBuilder postBuilder = Post.builder();

        while(rs.next())
            posts.add(
                    postBuilder
                            .id(rs.getLong("id"))
                            .authorId(rs.getLong("authorId"))
                            .date(rs.getDate("date").toLocalDate())
                            .time(rs.getTime("time").toLocalTime())
                            .text(rs.getString("text"))
                            .privacy(rs.getBoolean("privacy"))
                            .expandable(rs.getBoolean("expandable"))
                            .build()
            );

        return posts;
    }
}
