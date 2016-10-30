package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

/**
 * Created by wopqw on 29.10.16.
 */
@Data
@Builder
@ToString(exclude = "id")
@AllArgsConstructor
public class User {
    private long id;
    private String username;
    private String email;
    private String password;
    private String firstName;
    private String lastName;

}
