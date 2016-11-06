package dao;

import model.Role;
import model.UserRole;

import java.util.Collection;
import java.util.stream.Collectors;

/**
 * Created by wopqw on 01.11.16.
 */
public interface UserRoleDAO {

    Collection<UserRole> getAll();

    void addUserRole(UserRole userRole);

    default Collection<UserRole> getAllByRole(Role role){

        return getAll().stream()
                .filter(r -> r.getRole().equals(role.toString()))
                .collect(Collectors.toList());
    }

    default Collection<UserRole> getAllAdmins(){

        return getAllByRole(Role.ADMIN);
    }

    default Collection<UserRole> getAllModerators(){

        return getAllByRole(Role.MODERATOR);
    }

    default Collection<UserRole> getAllUsers(){

        return getAllByRole(Role.USER);
    }

    default Collection<UserRole> getByUsername(String username){

        return getAll().stream()
                .filter(r -> r.getUsername().equals(username))
                .collect(Collectors.toSet());
    }


}
