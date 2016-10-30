package listeners;

import common.ConnectionPool;
import dao.H2.H2UserDAO;
import dao.UserDAO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@Slf4j
@WebListener
public class Initer implements ServletContextListener {

    public static final String USER_DAO = "userDAO";

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        ServletContext servletContext = sce.getServletContext();

        //noinspection Split Declaration
        String path = servletContext.getRealPath("/") + "WEB-INF/classes/";

        ConnectionPool connectionPool = ConnectionPool.create(path + "db.properties");

        connectionPool.initDb(path+ "h2_jsp.sql");

        UserDAO userDAO = new H2UserDAO(connectionPool);

        servletContext.setAttribute(USER_DAO,userDAO);
    }
}
