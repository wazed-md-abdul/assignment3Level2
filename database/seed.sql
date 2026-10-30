-- =============================================================================
-- Football Ticket Booking System - Seed Data (DML)
-- =============================================================================

-- Clear existing data
TRUNCATE TABLE bookings, matches, users RESTART IDENTITY CASCADE;

-- 1. Insert Users
-- Note: 'password123' hashed with bcrypt (cost factor 10) for testing auth
INSERT INTO users (user_id, full_name, email, password, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', '$2b$10$wTqB0q7oZJg6q1nB5ZzM8.hO3Z3M8U9.wL5fQeF6rVbQ4XoE0j8eS', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', '$2b$10$wTqB0q7oZJg6q1nB5ZzM8.hO3Z3M8U9.wL5fQeF6rVbQ4XoE0j8eS', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', '$2b$10$wTqB0q7oZJg6q1nB5ZzM8.hO3Z3M8U9.wL5fQeF6rVbQ4XoE0j8eS', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', '$2b$10$wTqB0q7oZJg6q1nB5ZzM8.hO3Z3M8U9.wL5fQeF6rVbQ4XoE0j8eS', 'Football Fan', NULL);

-- Advance sequence to max user_id
SELECT setval('users_user_id_seq', (SELECT MAX(user_id) FROM users));

-- 2. Insert Matches
INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- Advance sequence to max match_id
SELECT setval('matches_match_id_seq', (SELECT MAX(match_id) FROM matches));

-- 3. Insert Bookings
INSERT INTO bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);

-- Advance sequence to max booking_id
SELECT setval('bookings_booking_id_seq', (SELECT MAX(booking_id) FROM bookings));

