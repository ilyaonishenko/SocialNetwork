package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

/**
 * Created by wopqw on 08.11.16.
 */
@Data
@Builder
@ToString
@AllArgsConstructor
public class Like {

    private long fromUserId;
    private long toPostId;

}
