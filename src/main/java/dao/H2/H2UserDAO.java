package dao.H2;

import common.ConnectionPool;
import dao.interfaces.UserDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import java.util.HashSet;

/**
 * Created by wopqw on 30.10.16.
 */
@AllArgsConstructor
public class H2UserDAO implements UserDAO {

    // TODO: 01.11.16 create UnitTest
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

    @Override
    @SneakyThrows
    public Collection<String> getUserRole(User user) {

        HashSet<String> userRoles = new HashSet<>();

        try(Connection connection =  connectionPool.getConnection()){

            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT role FROM Roles WHERE username = '"+
                    user.getUsername()+"'");
            while(rs.next()) {
                userRoles.add(rs.getString(1));
            }
        }
        return userRoles;
    }

    @Override
    @SneakyThrows
    public void addUser(User user) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "INSERT INTO User (username, email, password, first_name, last_name) VALUES (?,?,?,?,?)";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1,user.getUsername());
            preparedStatement.setString(2,user.getEmail());
            preparedStatement.setString(3,user.getPassword());
            preparedStatement.setString(4,user.getFirstName());
            preparedStatement.setString(5,user.getLastName());

            preparedStatement.execute();
        }
    }
}
