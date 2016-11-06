package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * Created by wopqw on 05.11.16.
 */
@Data
@Builder
@ToString(exclude = "id")
@AllArgsConstructor
public class Post {

    private long id;
    private long authorId;
    private LocalDate date;
    private LocalTime time;
    private String text;
    private boolean privacy;
    private boolean expandable;
}
