package dao;

import model.User;

import java.util.Collection;
import java.util.Optional;

/**
 * Created by wopqw on 30.10.16.
 */
public interface UserDAO {

    Collection<User> getAll();

    Collection<String> getUserRole(User user);

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

    default Optional<User> isRegistered(String username, String hash){

        return getAll().stream()
                .filter(u -> u.getUsername().equals(username)
                && u.getPassword().equals(hash))
                .findAny();
    }


}
