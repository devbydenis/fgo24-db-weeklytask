-- Active: 1750571513520@@127.0.0.1@5432@tickitz
CREATE DATABASE tickitz;

CREATE TYPE role_user AS ENUM ('user', 'admin');
CREATE TABLE users(
  id          SERIAL PRIMARY KEY,
  username    VARCHAR(255) UNIQUE NOT NULL,
  email       VARCHAR(255) UNIQUE NOT NULL,
  password    VARCHAR(255) UNIQUE NOT NULL,
  role        role_user DEFAULT 'user',
  created_at  TIMESTAMP DEFAULT now()
);

CREATE TABLE sessions(
  id          SERIAL PRIMARY KEY,
  token       VARCHAR(255) UNIQUE NOT NULL,
  device_info VARCHAR(255),
  is_active   BOOLEAN DEFAULT FALSE,
  id_user     INT NOT NULL REFERENCES users(id),
  created_at  TIMESTAMP DEFAULT now()
  expired_at  TIMESTAMP DEFAULT now(),
);

CREATE TABLE movies(
  id  SERIAL PRIMARY KEY,
  title  VARCHAR(255) NOT NULL,
  synopsis  TEXT,
  release_date  DATE,
  rating  DECIMAL(2,1),
  duration  INT,
  backdrop_img VARCHAR(255),
  poster_img VARCHAR(255),
  created_at  TIMESTAMP DEFAULT now()
);

CREATE TABLE casts(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  role VARCHAR(255)
);
CREATE TABLE movie_casts(
  id  SERIAL PRIMARY KEY,
  movie_id  INT NOT NULL REFERENCES movies(id),
  actor_id  INT NOT NULL REFERENCES users(id),
  created_at  TIMESTAMP DEFAULT now()
);

CREATE TABLE genres(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);
CREATE TABLE movie_genres(
  id  SERIAL PRIMARY KEY,
  movie_id  INT NOT NULL REFERENCES movies(id),
  genre_id  INT NOT NULL REFERENCES genres(id),
);

CREATE TABLE directors(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);
CREATE TABLE movie_directors(
  id  SERIAL PRIMARY KEY,
  movie_id  INT NOT NULL REFERENCES movies(id),
  director_id  INT NOT NULL REFERENCES directors(id),
);


CREATE TABLE transactions(
  id  SERIAL PRIMARY key,
  status  BOOLEAN,
  created_at  TIMESTAMP DEFAULT now()
);

CREATE TABLE payments(
  id  SERIAL PRIMARY KEY,
  name VARCHAR(255)
);
CREATE TABLE transactions_detail(
  id  SERIAL PRIMARY KEY,
  transactions_id    INT NOT NULL REFERENCES transactions(id),
  user_id   INT NOT NULL REFERENCES users(id),
  movie_id   INT NOT NULL REFERENCES movies(id)
  payment_id   INT NOT NULL REFERENCES payments(id),
  seats   VARCHAR(255)
);




DROP TABLE users;
DROP TABLE sessions;