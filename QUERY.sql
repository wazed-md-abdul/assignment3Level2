-- =============================================================================
-- Football Ticket Booking System - SQL Queries
-- =============================================================================
-- Database: PostgreSQL
-- Description: Queries 1 through 7 covering Filtering, Pattern Matching,
--              NULL Handling, INNER/LEFT JOINs, Subqueries, and Pagination.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Query 1: Retrieve all upcoming football matches belonging to the 
--          'Champions League' where the match status is 'Available'.
-- Expected Output Columns: match_id, fixture, base_ticket_price
-- -----------------------------------------------------------------------------
SELECT 
    match_id, 
    fixture, 
    base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';


-- -----------------------------------------------------------------------------
-- Query 2: Search for all users whose full names start with 'Tanvir' or 
--          contain the phrase 'Haque' (case-insensitive).
-- Concepts used: LIKE, ILIKE
-- Expected Output Columns: user_id, full_name, email
-- -----------------------------------------------------------------------------
SELECT 
    user_id, 
    full_name, 
    email
FROM users
WHERE full_name ILIKE 'Tanvir%' 
   OR full_name ILIKE '%Haque%';


-- -----------------------------------------------------------------------------
-- Query 3: Retrieve all booking records where the payment status is missing 
--          (NULL), replacing the empty result with 'Action Required'.
-- Concepts used: IS NULL, COALESCE
-- Expected Output Columns: booking_id, user_id, match_id, systematic_status
-- -----------------------------------------------------------------------------
SELECT 
    booking_id, 
    user_id, 
    match_id, 
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM bookings
WHERE payment_status IS NULL;


-- -----------------------------------------------------------------------------
-- Query 4: Retrieve match booking details along with the User's full name 
--          and the scheduled Match fixture teams.
-- Concepts used: INNER JOIN
-- Expected Output Columns: booking_id, full_name, fixture, total_cost
-- -----------------------------------------------------------------------------
SELECT 
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN matches m ON b.match_id = m.match_id;


-- -----------------------------------------------------------------------------
-- Query 5: Display a comprehensive list of all users and their booking IDs, 
--          ensuring that fans who have never bought a ticket are still listed.
-- Concepts used: LEFT JOIN / FULL JOIN
-- Expected Output Columns: user_id, full_name, booking_id
-- -----------------------------------------------------------------------------
SELECT 
    u.user_id,
    u.full_name,
    b.booking_id
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id;


-- -----------------------------------------------------------------------------
-- Query 6: Find all ticket bookings where the total cost is strictly higher 
--          than the average cost of all ticket bookings.
-- Concepts used: Subquery, Aggregation (AVG)
-- Expected Output Columns: booking_id, match_id, total_cost
-- -----------------------------------------------------------------------------
SELECT 
    booking_id, 
    match_id, 
    total_cost
FROM bookings
WHERE total_cost > (
    SELECT AVG(total_cost) FROM bookings
);


-- -----------------------------------------------------------------------------
-- Query 7: Retrieve the top 2 most expensive matches sorted by base ticket 
--          price, skipping the absolute highest premium match.
-- Concepts used: ORDER BY, LIMIT, OFFSET
-- Expected Output Columns: match_id, fixture, base_ticket_price
-- -----------------------------------------------------------------------------
SELECT 
    match_id, 
    fixture, 
    base_ticket_price
FROM matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;

