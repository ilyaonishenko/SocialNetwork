package dao;

import model.User;

import java.util.Collection;
import java.util.Optional;

/**
 * Created by wopqw on 30.10.16.
 */
public interface UserDAO {

    Collection<User> getAll();

    default Optional<User> getById(long id){

        return getAll().stream()
                .filter(u -> u.getId() == id)
                .findAny();
    }

    default Optional<User> getByUsername(String username){

        return getAll().stream()
                .filter(user -> user.getUsername().equals(username))
                .findAny();
    }
}
