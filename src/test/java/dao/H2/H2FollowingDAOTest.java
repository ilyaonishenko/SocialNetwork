package dao.H2;

import common.ConnectionPool;
import dao.interfaces.FollowingDAO;
import model.Following;
import org.junit.Before;
import org.junit.Test;

import java.util.HashSet;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

/**
 * Created by wopqw on 03.11.16.
 */
public class H2FollowingDAOTest {

    private static final String PATH_TO_CONFIG = "src/main/resources/db.properties";
    private static final String PATH_TO_INIT = "src/main/resources/h2_jsp.sql";

    private ConnectionPool connectionPool;

    private FollowingDAO followingDAO;

    @Before
    public void init(){

        connectionPool = ConnectionPool.create(PATH_TO_CONFIG);
        connectionPool.initDb(PATH_TO_INIT);
        followingDAO = new H2FollowingDAO(connectionPool);
    }

    @Test
    public void getFollowersByIdTest(){

        HashSet<Following> followers = (HashSet<Following>) followingDAO.getFollowersById(1L);

        assertThat(followers.size(),is(3));
        assertThat(followers.contains(new Following(2,1)),is(true));
        assertThat(followers.contains(new Following(3,1)),is(true));
        assertThat(followers.contains(new Following(4,1)),is(true));
        assertThat(followers.contains(new Following(5,1)),is(true));
    }

    @Test
    public void getFollowsByIdTest(){

        HashSet<Following> followings = (HashSet<Following>) followingDAO.getFollowsById(2L);

        assertThat(followings.size(),is(1));
        assertThat(followings.contains(new Following(2,1)),is(true));
    }

}