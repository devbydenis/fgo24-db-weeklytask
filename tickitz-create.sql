CREATE DATABASE tickitz;

CREATE TABLE users(
  id          SERIAL PRIMARY KEY,
  username    VARCHAR(255) UNIQUE NOT NULL,
  email       VARCHAR(255) UNIQUE NOT NULL,
  password    VARCHAR(255) UNIQUE NOT NULL,
  role        VARCHAR(255) DEFAULT 'user',
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
  
)

CREATE TABLE transactions(
  id  SERIAL PRIMARY key,
  status  BOOLEAN,
  created_at  TIMESTAMP DEFAULT now()
)

CREATE TABLE payments(
  id  SERIAL PRIMARY KEY,
  name VARCHAR(255)
)
CREATE TABLE transactions_detail(
  id  SERIAL PRIMARY KEY,
  transactions_id   INT NOT NULL REFERENCES transactions(id),

)




DROP TABLE users;
DROP TABLE sessions;