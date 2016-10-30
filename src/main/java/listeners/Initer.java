package listeners;

import common.ConnectionPool;
import dao.H2.H2UserDAO;
import dao.UserDAO;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import security.StringEncryptUtil;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@Slf4j
@WebListener
public class Initer implements ServletContextListener {

    private static final String PATH_CLASSES = "WEB-INF/classes/";
    private static final String DB_PROPERTIES = "db.properties";
    private static final String H2_JSP_SQL = "h2_jsp.sql";


    public static final String USER_DAO = "userDAO";

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        ServletContext servletContext = sce.getServletContext();

        //noinspection Split Declaration
        String path = servletContext.getRealPath("/") + PATH_CLASSES;

        ConnectionPool connectionPool = ConnectionPool.create(path + DB_PROPERTIES);

        connectionPool.initDb(path+ H2_JSP_SQL);

        reinitDbWithHash(connectionPool);

        UserDAO userDAO = new H2UserDAO(connectionPool);

        servletContext.setAttribute(USER_DAO,userDAO);
    }

    @SneakyThrows
    private void reinitDbWithHash(ConnectionPool connectionPool){


        try(Connection connection = connectionPool.getConnection();
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT id, password FROM User");
            Statement statement1 = connection.createStatement()){

            while (rs.next()){

                long id = rs.getLong("id");
                String password = rs.getString("password");

                statement1.addBatch("UPDATE User SET password = '"
                        + StringEncryptUtil.encrypt(password)
                        +"' WHERE id = "+id);
            }
            statement1.executeBatch();
        }
    }
}
