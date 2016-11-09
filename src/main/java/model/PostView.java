package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

/**
 * Created by wopqw on 10.11.16.
 */
@Data
@Builder
@ToString
@AllArgsConstructor
public class PostView {

    private Post post;
    private long likesCount;
    private long commentsCount;

}
