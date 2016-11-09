package webapi;

import dao.CommentDAO;
import listeners.Initer;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletContext;
import javax.ws.rs.core.Context;

/**
 * Created by wopqw on 09.11.16.
 */
@Slf4j
public class CommentResource {

    private static CommentDAO commentDAO;

    @Context
    public void init(ServletContext servletContext){

        if(commentDAO == null)
            commentDAO = (CommentDAO) servletContext.getAttribute(Initer.COMMENT_DAO);
    }
}
