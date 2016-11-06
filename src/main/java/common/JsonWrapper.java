package common;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Created by wopqw on 05.11.16.
 */
public class JsonWrapper {

    public static String toJson(Object object) throws JsonProcessingException {

        return new ObjectMapper().writerWithDefaultPrettyPrinter().writeValueAsString(object);
    }
}
