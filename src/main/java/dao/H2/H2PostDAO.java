package dao.H2;

import common.ConnectionPool;
import dao.interfaces.PostDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.Post;

import java.sql.Connection;
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

        Collection<Post> posts = new HashSet<>();

        try(Connection connection = connectionPool.getConnection()){

            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM Post");

            Post.PostBuilder postBuilder = Post.builder();

            while (rs.next())
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
        }

        return posts;
    }
}
