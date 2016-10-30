CREATE TABLE User(
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

INSERT INTO User(username, email, password, first_name, last_name) VALUES ('ivan', 'ivan@mail.ru', 'qwerty', 'Ivan', 'Ivanov');
INSERT INTO User(username, email, password, first_name, last_name) VALUES ('petr', 'petr@mail.ru', 'qwerty', 'Petr', 'Petrov');
INSERT INTO User(username, email, password, first_name, last_name) VALUES ('Andrew', 'andrew@mail.ru', 'qwerty', 'Andrew', 'Andreev');
INSERT INTO User(username, email, password, first_name, last_name) VALUES ('alex', 'alex@mail.ru', 'qwerty', 'Alexander', 'Alexandrov');


