package dao.H2;

import common.ConnectionPool;
import dao.UserDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import java.util.HashSet;

/**
 * Created by wopqw on 30.10.16.
 */
@AllArgsConstructor
public class H2UserDAO implements UserDAO {

    private ConnectionPool connectionPool;

    @Override
    @SneakyThrows
    public Collection<User> getAll() {

        Collection<User> users = new HashSet<>();

        try(Connection connection = connectionPool.getConnection()){

            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM User");

            User.UserBuilder userBuilder = User.builder();

            while(rs.next()){

                users.add( userBuilder
                        .id(rs.getLong("id"))
                        .username(rs.getString("username"))
                        .email(rs.getString("email"))
                        .password(rs.getString("password"))
                        .firstName(rs.getString("first_name"))
                        .lastName(rs.getString("last_name"))
                        .build());
            }
            return users;
        }
    }
}
