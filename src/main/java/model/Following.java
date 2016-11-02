package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

/**
 * Created by wopqw on 02.11.16.
 */
@Data
@Builder
@AllArgsConstructor
public class Following {

    private long followerId;
    private long followId;
}
