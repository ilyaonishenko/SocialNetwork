package dao.H2;

import common.ConnectionPool;
import dao.UserRoleDAO;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import model.UserRole;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import java.util.HashSet;

/**
 * Created by wopqw on 01.11.16.
 */
@AllArgsConstructor
public class H2UserRoleDAO implements UserRoleDAO {

    private ConnectionPool connectionPool;

    @Override
    @SneakyThrows
    public Collection<UserRole> getAll() {

        Collection<UserRole> userRoles = new HashSet<>();

        try(Connection connection = connectionPool.getConnection()){

            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM Roles");

            UserRole.UserRoleBuilder roleBuilder = UserRole.builder();

            while (rs.next()){

                userRoles.add(
                        roleBuilder
                                .username(rs.getString("username"))
                                .role(rs.getString("role"))
                                .build()
                );
            }
            return userRoles;
        }
    }

    @Override
    @SneakyThrows
    public void addUserRole(UserRole userRole) {

        try(Connection connection = connectionPool.getConnection()){

            String sql = "INSERT INTO Roles(username, role) VALUES (?,?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1,userRole.getUsername());
            preparedStatement.setString(2,userRole.getRole().toString());

            preparedStatement.execute();
        }
    }
}
