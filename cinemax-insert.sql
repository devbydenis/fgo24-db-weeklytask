
INSERT INTO users (username, email, password, phone_number, is_verified, role) VALUES
('johndoe', 'john@email.com', '$2b$10$hashedpassword1', '+6281234567890', true, 'user'),
('janedoe', 'jane@email.com', '$2b$10$hashedpassword2', '+6281234567891', true, 'user'),
('adminuser', 'admin@cinemax.com', '$2b$10$hashedpassword3', '+6281234567892', true, 'admin'),
('mikebrown', 'mike@email.com', '$2b$10$hashedpassword4', '+6281234567893', false, 'user'),
('sarahjones', 'sarah@email.com', '$2b$10$hashedpassword5', '+6281234567894', true, 'user');

INSERT INTO profiles (user_id, firstname, lastname, birthday, gender) VALUES
(1, 'John', 'Doe', '1990-05-15', 'male'),
(2, 'Jane', 'Doe', '1992-08-22', 'female'),
(3, 'Admin', 'User', '1985-12-01', 'male'),
(4, 'Mike', 'Brown', '1988-03-10', 'male'),
(5, 'Sarah', 'Jones', '1995-11-07', 'female');

INSERT INTO sessions (user_id, token, device_info, is_active, expired_at) VALUES
(1, 'token_john_123456', 'Mozilla/5.0 Chrome/91.0', true, '2025-06-30 23:59:59'),
(2, 'token_jane_789012', 'Mozilla/5.0 Safari/14.1', true, '2025-06-30 23:59:59'),
(3, 'token_admin_345678', 'Mozilla/5.0 Firefox/89.0', true, '2025-06-30 23:59:59'),
(4, 'token_mike_901234', 'Mobile App iOS 14.6', false, '2025-06-25 23:59:59'),
(5, 'token_sarah_567890', 'Mobile App Android 11', true, '2025-06-30 23:59:59');

INSERT INTO cities (name, province) VALUES
('Jakarta', 'DKI Jakarta'),
('Bandung', 'Jawa Barat'),
('Surabaya', 'Jawa Timur'),
('Medan', 'Sumatera Utara'),
('Yogyakarta', 'DI Yogyakarta');

INSERT INTO cinemas (city_id, name, address, is_active) VALUES
(1, 'Cinemax Grand Indonesia', 'Jl. MH Thamrin No.1, Jakarta Pusat', true),
(1, 'Cinemax Kelapa Gading', 'Jl. Boulevard Raya, Jakarta Utara', true),
(2, 'Cinemax Bandung Indah Plaza', 'Jl. Merdeka No.56, Bandung', true),
(3, 'Cinemax Surabaya Town Square', 'Jl. Pemuda No.31-37, Surabaya', true),
(4, 'Cinemax Medan Fair Plaza', 'Jl. Gatot Subroto KM 7.5, Medan', true);

INSERT INTO theaters (cinema_id, name, capacity, is_active) VALUES
(1, 'Theater 1', 120, true),
(1, 'Theater 2', 150, true),
(2, 'Theater Premium', 80, true),
(3, 'Theater IMAX', 200, true),
(4, 'Theater Standard', 100, true);

INSERT INTO seats (theater_id, seat_letter, seat_number, is_active) VALUES
(1, 'A', 1, true), (1, 'A', 2, true), (1, 'B', 1, true), (1, 'B', 2, true),
(2, 'A', 1, true), (2, 'A', 2, true), (2, 'B', 1, true), (2, 'B', 2, true),
(3, 'A', 1, true), (3, 'A', 2, true), (3, 'B', 1, true), (3, 'B', 2, true),
(4, 'A', 1, true), (4, 'A', 2, true), (4, 'B', 1, true), (4, 'B', 2, true),
(5, 'A', 1, true), (5, 'A', 2, true), (5, 'B', 1, true), (5, 'B', 2, true);

INSERT INTO genres (name) VALUES
('Action'),
('Comedy'),
('Drama'),
('Horror'),
('Romance');

INSERT INTO directors (name) VALUES
('Christopher Nolan'),
('Steven Spielberg'),
('Quentin Tarantino'),
('Martin Scorsese'),
('Denis Villeneuve');

INSERT INTO casts (name, role) VALUES
('Leonardo DiCaprio', 'Actor'),
('Scarlett Johansson', 'Actress'),
('Robert Downey Jr.', 'Actor'),
('Emma Stone', 'Actress'),
('Tom Hanks', 'Actor');

INSERT INTO movies (title, synopsis, duration, release_date, rating, price, status, language) VALUES
('Inception', 'A thief who steals corporate secrets through dream-sharing technology.', '02:28:00', '2010-07-16', 8.8, 50000, 'now_playing', 'English'),
('The Dark Knight', 'Batman faces the Joker, a criminal mastermind wreaking havoc on Gotham.', '02:32:00', '2008-07-18', 9.0, 55000, 'now_playing', 'English'),
('Parasite', 'A poor family infiltrates a wealthy household with unexpected consequences.', '02:12:00', '2019-05-30', 8.6, 45000, 'now_playing', 'Korean'),
('Avengers: Endgame', 'The Avengers assemble once more to reverse Thanos snap.', '03:01:00', '2019-04-26', 8.4, 60000, 'ended', 'English'),
('Dune', 'Paul Atreides leads a rebellion to free his desert world from oppression.', '02:35:00', '2021-10-22', 8.0, 50000, 'coming_soon', 'English');

INSERT INTO movies_genres (movie_id, genre_id) VALUES
(1, 1), (1, 3),
(2, 1), (2, 3),
(3, 3), (3, 2),
(4, 1),
(5, 1), (5, 3);

INSERT INTO movie_directors (movie_id, director_id) VALUES
(1, 1),
(2, 1),
(3, 5),
(4, 2),
(5, 5);

INSERT INTO movies_casts (movie_id, cast_id, character_name) VALUES
(1, 1, 'Dom Cobb'),
(1, 2, 'Natasha'),
(2, 1, 'Bruce Wayne'),
(2, 3, 'Harvey Dent'),
(3, 4, 'Ki-jung'),
(3, 5, 'Ki-taek'),
(4, 3, 'Tony Stark'),
(4, 2, 'Black Widow'),
(5, 1, 'Paul Atreides'),
(5, 5, 'Duncan Idaho');

INSERT INTO showtimes (movie_id, theater_id, show_date, show_time, base_price, available_seats) VALUES
(1, 1, '2025-06-24', '14:00:00', 50000, 118),
(1, 1, '2025-06-24', '19:30:00', 55000, 120),
(2, 2, '2025-06-24', '16:00:00', 55000, 148),
(2, 3, '2025-06-25', '20:00:00', 60000, 79),
(3, 4, '2025-06-24', '15:30:00', 45000, 198),
(3, 5, '2025-06-25', '18:00:00', 45000, 100),
(5, 1, '2025-07-01', '21:00:00', 50000, 120),
(5, 4, '2025-07-01', '17:00:00', 55000, 200);

INSERT INTO payments (method_name, provider, fee_process, is_active) VALUES
('Credit Card', 'Visa', 2500, true),
('Debit Card', 'Mastercard', 2000, true),
('E-Wallet', 'GoPay', 1500, true),
('E-Wallet', 'OVO', 1500, true),
('Bank Transfer', 'BCA', 3000, true);

INSERT INTO bookings (booking_code, user_id, showtime_id, status, total_amount, discount_amount, tax_amount, expires_at) VALUES
('BOOK001', 1, 1, 'success', 102500, 0, 2500, '2025-06-24 13:00:00'),
('BOOK002', 2, 2, 'success', 112000, 5000, 2000, '2025-06-24 18:30:00'),
('BOOK003', 3, 3, 'pending', 57000, 0, 2000, '2025-06-24 15:00:00'),
('BOOK004', 4, 4, 'success', 122500, 0, 2500, '2025-06-25 19:00:00'),
('BOOK005', 5, 5, 'failed', 92000, 0, 2000, '2025-06-24 14:30:00');

INSERT INTO bookings_seats (seat_id, booking_id, seat_price) VALUES
(1, 1, 50000), (2, 1, 50000),
(5, 2, 55000),
(9, 3, 55000),
(13, 4, 60000), (14, 4, 60000),
(17, 5, 45000), (18, 5, 45000);

INSERT INTO payments_transactions (booking_id, payment_id, transaction_id, status, amount) VALUES
(1, 1, 'TXN001', 'success', 102500),
(2, 2, 'TXN002', 'success', 112000),
(3, 3, 'TXN003', 'pending', 57000),
(4, 1, 'TXN004', 'success', 122500),
(5, 4, 'TXN005', 'failed', 92000),
(5, 1, 'TXN006', 'pending', 92000);
