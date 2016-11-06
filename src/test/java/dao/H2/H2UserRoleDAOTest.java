package dao.H2;

import common.ConnectionPool;
import dao.UserDAO;
import dao.UserRoleDAO;
import model.Role;
import model.User;
import model.UserRole;
import org.junit.Before;
import org.junit.Test;

import java.util.HashSet;
import java.util.Optional;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

/**
 * Created by wopqw on 01.11.16.
 */
public class H2UserRoleDAOTest {

    private static final String PATH_TO_CONFIG = "src/main/resources/db.properties";
    private static final String PATH_TO_INIT = "src/main/resources/h2_jsp.sql";

    private ConnectionPool connectionPool;

    UserRoleDAO userRoleDAO;

    @Before
    public void init(){

        connectionPool = ConnectionPool.create(PATH_TO_CONFIG);
        connectionPool.initDb(PATH_TO_INIT);
        userRoleDAO = new H2UserRoleDAO(connectionPool);
    }


    @Test
    public void getAllTest() throws Exception {

        HashSet<UserRole> userRoles = (HashSet<UserRole>) userRoleDAO.getAll();
        UserRole adminIvan = new UserRole("ivan", Role.ADMIN.toString());
        Optional<UserRole> optUserRole =
                userRoles.stream()
                        .filter(r -> r.getUsername().equals(adminIvan.getUsername()))
                        .filter(r -> r.getRole().equals(adminIvan.getRole()))
                        .findAny();
        assertThat(adminIvan,is(optUserRole.get()));
    }



    @Test
    public void addUserRoleTest() throws Exception {

        User userTom = new User(0L,"tom","tom@mail.ru","qwerty","tom","tomsky");
        UserDAO userDAO = new H2UserDAO(connectionPool);
        userDAO.addUser(userTom);

        UserRole moderatorTom = new UserRole("tom",Role.MODERATOR.toString());
        userRoleDAO.addUserRole(moderatorTom);

        HashSet<UserRole> userRoles = (HashSet<UserRole>) userRoleDAO.getAll();
        assertThat(userRoles.size(),is(7));
    }

    @Test
    public void getAllUsersTest(){

        assertThat(userRoleDAO.getAllByRole(Role.USER).size(),is(3));
    }

}