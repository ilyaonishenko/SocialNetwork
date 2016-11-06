package dao.H2;

import common.ConnectionPool;
import dao.PostDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.Post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import java.util.HashSet;

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
