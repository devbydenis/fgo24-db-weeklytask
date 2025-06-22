-- Active: 1750571513520@@127.0.0.1@5432@tickitz
CREATE DATABASE tickitz;

CREATE TYPE user_role AS ENUM ('user', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'success', 'failed');
CREATE TYPE movie_status AS ENUM ('coming_soon', 'now_playing', 'ended');
CREATE TYPE payment_transaction_status AS ENUM ('pending', 'success', 'failed', 'refunded');

CREATE TABLE users(
  id            SERIAL PRIMARY KEY,
  username      VARCHAR(255) UNIQUE NOT NULL,
  email         VARCHAR(255) UNIQUE NOT NULL,
  password      VARCHAR(255) NOT NULL,
  phone_number  VARCHAR(20) NOT NULL,
  is_verified   BOOLEAN DEFAULT FALSE,
  role          user_role DEFAULT 'user',
  updated_at    TIMESTAMP DEFAULT now(),
  created_at    TIMESTAMP DEFAULT now()
);

CREATE TABLE sessions(
  id          SERIAL PRIMARY KEY,
  user_id     INT NOT NULL REFERENCES users(id),
  token       VARCHAR(255) UNIQUE NOT NULL,
  device_info VARCHAR(255),
  is_active   BOOLEAN DEFAULT FALSE,
  created_at  TIMESTAMP DEFAULT now(),
  expired_at  TIMESTAMP DEFAULT now()
);

CREATE TABLE profiles(
  id          SERIAL PRIMARY KEY,
  user_id     INT NOT NULL UNIQUE REFERENCES users(id),
  firstname   VARCHAR(100),
  lastname    VARCHAR(100),
  birthday    DATE,
  gender      VARCHAR(10),
  profile_picture VARCHAR(255),
  created_at  TIMESTAMP DEFAULT now(),
  updated_at  TIMESTAMP DEFAULT now()
);

CREATE TABLE movies(
  id            SERIAL PRIMARY KEY,
  title         VARCHAR(255) NOT NULL,
  synopsis      TEXT,
  duration      TIME,
  release_date  DATE,
  rating        DECIMAL(2,1),
  backdrop_img  VARCHAR(255),
  poster_img    VARCHAR(255),
  price         DECIMAL(10,2),
  status        movie_status DEFAULT 'now_playing',
  language      VARCHAR(100),
  created_at    TIMESTAMP DEFAULT now()
);

CREATE TABLE casts (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255),
  role        VARCHAR(255),
  created_at  TIMESTAMP DEFAULT now(),
  updated_at  TIMESTAMP DEFAULT now()
);
CREATE TABLE movies_casts(
  id              SERIAL PRIMARY KEY,
  movie_id        INT NOT NULL REFERENCES movies(id),
  cast_id         INT NOT NULL REFERENCES casts(id),
  character_name  VARCHAR(255)
);

CREATE TABLE genres(
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255),
  created_at  TIMESTAMP DEFAULT now(),
  updated_at  TIMESTAMP DEFAULT now()
);
CREATE TABLE movies_genres(
  id        SERIAL PRIMARY KEY,
  movie_id  INT NOT NULL REFERENCES movies(id),
  genre_id  INT NOT NULL REFERENCES genres(id)
);

CREATE TABLE directors(
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255),
  created_at  TIMESTAMP DEFAULT now(),
  updated_at  TIMESTAMP DEFAULT now()
);
CREATE TABLE movie_directors(
  id           SERIAL PRIMARY KEY,
  movie_id     INT NOT NULL REFERENCES movies(id),
  director_id  INT NOT NULL REFERENCES directors(id)
);

CREATE TABLE cities(
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(255),
  province    VARCHAR(255),
  created_at  TIMESTAMP DEFAULT now(),
  updated_at  TIMESTAMP DEFAULT now()
);
CREATE TABLE cinemas(
  id          SERIAL PRIMARY KEY,
  city_id     INT NOT NULL REFERENCES cities(id),
  name        VARCHAR(255),
  address     VARCHAR(255),
  is_active   BOOLEAN DEFAULT FALSE,
  created_at  TIMESTAMP DEFAULT now(),
  updated_at  TIMESTAMP DEFAULT now()
);
CREATE TABLE theaters(
  id          SERIAL PRIMARY KEY,
  cinema_id   INT NOT NULL REFERENCES cinemas(id),
  name        VARCHAR(255),
  capacity    INT,
  is_active   BOOLEAN DEFAULT TRUE,
  created_at  TIMESTAMP DEFAULT now(),
  updated_at  TIMESTAMP DEFAULT now()
);
CREATE TABLE showtimes(
  id          SERIAL PRIMARY KEY,
  movie_id    INT NOT NULL REFERENCES movies(id),
  theater_id  INT NOT NULL REFERENCES theaters(id),
  show_date   TIMESTAMP NOT NULL,
  show_time   TIME NOT NULL,
  base_price  DECIMAL(10,2),
  available_seats INT
);

CREATE TABLE seats (
  id          SERIAL PRIMARY KEY,
  theater_id  INT NOT NULL REFERENCES theaters(id),
  seat_letter VARCHAR(1) NOT NULL,
  seat_number INT NOT NULL,
  is_active   BOOLEAN DEFAULT FALSE
);

CREATE TABLE bookings(
  id              SERIAL PRIMARY KEY,
  booking_code    VARCHAR(255) UNIQUE NOT NULL,
  user_id         INT NOT NULL REFERENCES users(id),
  showtime_id     INT NOT NULL REFERENCES showtimes(id),
  status          booking_status DEFAULT 'pending',
  total_amount    DECIMAL(10,2),
  discount_amount DECIMAL(10,2),
  tax_amount      DECIMAL(10,2),
  booking_time    TIMESTAMP DEFAULT now(),
  expires_at      TIMESTAMP
);

CREATE TABLE bookings_seats(
  id          SERIAL PRIMARY KEY,
  seat_id     INT NOT NULL REFERENCES seats(id),
  booking_id  INT NOT NULL REFERENCES bookings(id),
  seat_price  DECIMAL(10,2)
);

CREATE TABLE payments(
  id SERIAL   PRIMARY KEY,
  method_name VARCHAR(100),
  provider    VARCHAR(100),
  fee_process DECIMAL(10,2),
  is_active   BOOLEAN DEFAULT FALSE
);

CREATE TABLE payments_transactions(
  id               SERIAL PRIMARY KEY,
  booking_id       INT NOT NULL REFERENCES bookings(id),
  payment_id       INT NOT NULL REFERENCES payments(id),
  transaction_id   VARCHAR(255),
  gateway_response VARCHAR(255),
  status           payment_transaction_status DEFAULT 'pending',
  amount           DECIMAL(10,2),
  completed_at     TIMESTAMP DEFAULT now(),
  created_at       TIMESTAMP DEFAULT now()
);


-- supaya ga double booking seat yang sama untuk showtime yang sama
ALTER TABLE bookings_seats ADD CONSTRAINT unique_seat_per_showtime 
UNIQUE (seat_id, booking_id);

-- posisi seat harus unik di tiap theater
ALTER TABLE seats ADD CONSTRAINT unique_seat_position 
UNIQUE (theater_id, seat_letter, seat_number);

-- showtiem harus unik
ALTER TABLE showtimes ADD CONSTRAINT unique_showtime 
UNIQUE (movie_id, theater_id, show_date, show_time);

-- indexing untuk performa ketika query
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_showtimes_movie_date ON showtimes(movie_id, show_date);
CREATE INDEX idx_bookings_seats_booking ON bookings_seats(booking_id);
CREATE INDEX idx_sessions_token ON sessions(token);
CREATE INDEX idx_payments_transactions_booking ON payments_transactions(booking_id);