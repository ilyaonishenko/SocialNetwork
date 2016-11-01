package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

/**
 * Created by wopqw on 01.11.16.
 */
@Data
@Builder
@ToString
@AllArgsConstructor
public class UserRole {

    private String username;
    private String role;
}
