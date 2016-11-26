package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

/**
 * Created by wopqw on 26.11.16.
 */
@Data
@Builder
@ToString
@AllArgsConstructor
public class UserView {

    private User user;
    private int posts;
    private int followers;
    private int followings;
}
