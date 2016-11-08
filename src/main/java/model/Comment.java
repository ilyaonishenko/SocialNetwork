package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * Created by wopqw on 09.11.16.
 */
@Data
@Builder
@ToString(exclude = "id")
@AllArgsConstructor
public class Comment {

    private long id;
    private long userId;
    private long postId;
    private String text;
    private LocalDate date;
    private LocalTime time;

}
