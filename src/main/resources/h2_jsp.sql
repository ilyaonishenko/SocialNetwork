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
  FOREIGN KEY (username) REFERENCES User (username)
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
  FOREIGN KEY (follower_id) REFERENCES User(id)
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
);

INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (3,'2016-01-01','00:05:00','LOOOOOOOLOOOOL',FALSE ,FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-01','01:00:01','Happy new Year, by the way!',FALSE ,FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (1,'2016-01-01','00:00:31','Hello! I am admin here', FALSE, FALSE );
INSERT INTO Post (authorId, date, time, text, privacy, expandable) VALUES (2,'2016-01-01','00:01:00','Hey there! I am smth like moderator here',FALSE ,FALSE );







