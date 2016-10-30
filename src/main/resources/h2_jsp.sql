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




