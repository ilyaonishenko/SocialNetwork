CREATE TABLE User(
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

INSERT INTO User(username, email, password, first_name, last_name) VALUES ('ivan', 'ivan@mail.ru', 'qwerty', 'Ivan', 'Ivanov');
INSERT INTO User(username, email, password, first_name, last_name) VALUES ('peter', 'peter@mail.ru', 'qwerty', 'Peter', 'Petrov');
INSERT INTO User(username, email, password, first_name, last_name) VALUES ('Andrew', 'andrew@mail.ru', 'qwerty', 'Andrew', 'Andreev');
INSERT INTO User(username, email, password, first_name, last_name) VALUES ('alex', 'alex@mail.ru', 'qwerty', 'Alexander', 'Alexandrov');

CREATE TABLE Roles (
  username VARCHAR(255) NOT NULL,
  role  VARCHAR(15)  NOT NULL,
  PRIMARY KEY (username, role),
  FOREIGN KEY (username) REFERENCES User (username) ON DELETE CASCADE
);

INSERT INTO Roles (username, role) VALUES ('ivan', 'admin');
INSERT INTO Roles (username, role) VALUES ('ivan', 'moderator');
INSERT INTO Roles (username, role) VALUES ('ivan', 'user');
INSERT INTO Roles (username, role) VALUES ('peter', 'moderator');
INSERT INTO Roles (username, role) VALUES ('peter', 'user');
INSERT INTO Roles (username, role) VALUES ('alex', 'user');

CREATE TABLE Following (
  follower_id INT NOT NULL,
  follow_id INT NOT NULL,
  PRIMARY KEY (follow_id, follower_id),
  FOREIGN KEY (follower_id) REFERENCES User(id) ON DELETE CASCADE
);

INSERT INTO Following (follower_id, follow_id) VALUES (4,1);
INSERT INTO Following (follower_id, follow_id) VALUES (3,1);
INSERT INTO Following (follower_id, follow_id) VALUES (2,1);
INSERT INTO Following (follower_id, follow_id) VALUES (1,2);

CREATE TABLE Post(
  id INT PRIMARY KEY AUTO_INCREMENT,
  authorId INT NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  text VARCHAR(200) NOT NULL,
  privacy BOOL NOT NULL,
  expandable BOOL NOT NULL,
  FOREIGN KEY (authorId) REFERENCES User(id) ON DELETE CASCADE
);

INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (3,'2016-01-01','00:05:00','LOOOOOOOLOOOOL',FALSE ,FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-01','01:00:01','Happy new Year, by the way!',FALSE ,FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-01','00:00:31','Hello! I am admin here', FALSE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-02','00:00:31','1', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-03','00:00:31','2', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-04','00:00:31','3', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-05','00:00:31','4', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-06','00:00:31','5', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-07','00:00:31','6', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-08','00:00:31','7', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-09','00:00:31','8', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-10','00:00:31','9', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-11','00:00:31','10', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-12','00:00:31','11', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-13','00:00:31','12', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-14','00:00:31','13', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-15','00:00:31','14', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-16','00:00:31','15', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-17','00:00:31','16', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-18','00:00:31','17', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-19','00:00:31','18', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-20','00:00:31','19', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-21','00:00:31','20', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-22','00:00:31','21', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-23','00:00:31','22', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-24','00:00:31','23', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-25','00:00:31','24', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-26','00:00:31','25', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-27','00:00:31','26', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-28','00:00:31','27', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-29','00:00:31','28', TRUE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-30','00:00:31','29', TRUE, FALSE );

INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (2,'2016-02-01','00:01:00','Hey there! I am smth like moderator here',FALSE ,FALSE );

CREATE TABLE Likes (
  from_userId INT NOT NULL,
  to_postId INT NOT NULL,
  PRIMARY KEY (from_userId, to_postId),
  FOREIGN KEY (from_userId) REFERENCES User(id) ON DELETE CASCADE,
  FOREIGN KEY (to_postId) REFERENCES Post(id) ON DELETE CASCADE

);

INSERT into Likes (from_userId, to_postId) VALUES (1,3);
INSERT into Likes (from_userId, to_postId) VALUES (2,3);
INSERT into Likes (from_userId, to_postId) VALUES (3,3);
INSERT into Likes (from_userId, to_postId) VALUES (4,3);
INSERT into Likes (from_userId, to_postId) VALUES (1,1);
-- INSERT into Likes (from_userId, to_postId) VALUES (1,4);
INSERT into Likes (from_userId, to_postId) VALUES (2,2);
INSERT into Likes (from_userId, to_postId) VALUES (4,2);


CREATE TABLE Comment (
  id INT PRIMARY KEY AUTO_INCREMENT,
  from_userId INT NOT NULL,
  from_username VARCHAR(255) NOT NULL,
  to_postId INT NOT NULL,
  text VARCHAR(200) NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  FOREIGN KEY (from_userId) REFERENCES User(id) ON DELETE CASCADE,
  FOREIGN KEY (from_username) REFERENCES User(username) ON DELETE CASCADE,
  FOREIGN KEY (to_postId) REFERENCES Post(id) ON DELETE CASCADE
);

INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (2, 'peter', 3, 'AYO! I am the moderator', '2016-01-01', '00:01:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (3, 'Andrew', 3, 'Hello! I am a user', '2016-01-01', '00:10:00');

INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, 'WELCOME TO THE CLUB', '2016-01-01', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '1', '2016-01-01', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '2', '2016-01-02', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '3', '2016-01-03', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '4', '2016-01-04', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '5', '2016-01-05', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '6', '2016-01-06', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '7', '2016-01-07', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '8', '2016-01-08', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '9', '2016-01-09', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '10', '2016-01-10', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '11', '2016-01-11', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '12', '2016-01-12', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '13', '2016-01-13', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '14', '2016-01-14', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '15', '2016-01-15', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '16', '2016-01-16', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '17', '2016-01-17', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '18', '2016-01-18', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '19', '2016-01-19', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '20', '2016-01-20', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '21', '2016-01-21', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '22', '2016-01-22', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '23', '2016-01-23', '01:00:00');
INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (1, 'ivan', 4, '24', '2016-01-24', '01:00:00');

INSERT INTO Comment (from_userId, from_username, to_postId, text, date, time) VALUES (4, 'alex', 1, 'GTFO', '2016-01-01', '05:00:00');

