-- Удаляем существующие данные, если они уже есть в таблицах
TRUNCATE TABLE boarding_passes, ticket_flights, tickets, flights, aircrafts, airports CASCADE;

INSERT INTO bookings (book_ref, book_date, total_amount)
VALUES
  ('BOK001', '2024-12-01 12:00:00', 1000.00),
  ('BOK002', '2024-12-02 12:00:00', 1200.00),
  ('BOK003', '2024-12-03 12:00:00', 1100.00),
  ('BOK004', '2024-12-04 12:00:00', 900.00),
  ('BOK005', '2024-12-05 12:00:00', 950.00);

-- Вставка данных для аэропортов
-- Обратите внимание, что airport_code должен быть длиной 3 символа.
INSERT INTO airports (airport_code, airport_name, city, coordinates_lon, coordinates_lat, timezone)
VALUES
  ('JFK', 'John F. Kennedy', 'New York', -73.7781, 40.6413, 'America/New_York'),
  ('LAX', 'Los Angeles International', 'Los Angeles', -118.4085, 33.9416, 'America/Los_Angeles'),
  ('ORD', 'O’Hare', 'Chicago', -87.6298, 41.9744, 'America/Chicago'),
  ('SFO', 'San Francisco International', 'San Francisco', -122.3750, 37.7749, 'America/Los_Angeles'),
  ('ATL', 'Hartsfield–Jackson', 'Atlanta', -84.4279, 33.6407, 'America/New_York');

-- Вставка данных для самолетов
-- aircraft_code должен быть длиной 3 символа.
INSERT INTO aircrafts (aircraft_code, model, range)
VALUES
  ('A32', '{"model": "Airbus A320", "seats": 180}', 6000),
  ('B73', '{"model": "Boeing 737", "seats": 160}', 5500),
  ('A38', '{"model": "Airbus A380", "seats": 500}', 15000);

-- Вставка данных для рейсов
-- flight_no должен быть длиной 6 символов.
INSERT INTO flights (flight_id, flight_no, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, status, aircraft_code)
VALUES
  (1, 'AA100', '2024-12-20 06:00:00', '2024-12-20 08:00:00', 'JFK', 'ORD', 'Scheduled', 'A32'),
  (2, 'UA101', '2024-12-21 07:30:00', '2024-12-21 09:30:00', 'LAX', 'JFK', 'Scheduled', 'B73'),
  (3, 'DL102', '2024-12-22 08:00:00', '2024-12-22 10:00:00', 'ORD', 'SFO', 'Scheduled', 'A32'),
  (4, 'AA103', '2024-12-23 09:00:00', '2024-12-23 11:00:00', 'JFK', 'ATL', 'Scheduled', 'A32'),
  (5, 'UA104', '2024-12-24 10:30:00', '2024-12-24 12:30:00', 'LAX', 'SFO', 'Scheduled', 'B73'),
  (6, 'DL105', '2024-12-25 11:00:00', '2024-12-25 13:00:00', 'ORD', 'LAX', 'Scheduled', 'A32'),
  (7, 'AA106', '2024-12-26 12:00:00', '2024-12-26 14:00:00', 'JFK', 'SFO', 'Scheduled', 'A32'),
  (8, 'UA107', '2024-12-27 13:30:00', '2024-12-27 15:30:00', 'LAX', 'ORD', 'Scheduled', 'B73'),
  (9, 'DL108', '2024-12-28 14:00:00', '2024-12-28 16:00:00', 'ORD', 'JFK', 'Scheduled', 'A32'),
  (10, 'AA109', '2024-12-29 15:30:00', '2024-12-29 17:30:00', 'ATL', 'LAX', 'Scheduled', 'A32');

-- Вставка данных для билетов
-- Данные для ticket_no должны быть уникальными.
INSERT INTO tickets (ticket_no, book_ref, passenger_id, passenger_name, contact_data)
VALUES
  ('TICKET001', 'BOK001', 'P001', 'John Doe', '{"email": "johndoe@example.com", "phone": "+1234567890"}'),
  ('TICKET002', 'BOK001', 'P002', 'Jane Smith', '{"email": "janesmith@example.com", "phone": "+1234567891"}'),
  ('TICKET003', 'BOK002', 'P003', 'Bob Johnson', '{"email": "bobjohnson@example.com", "phone": "+1234567892"}'),
  ('TICKET004', 'BOK003', 'P004', 'Alice Brown', '{"email": "alicebrown@example.com", "phone": "+1234567893"}'),
  ('TICKET005', 'BOK003', 'P005', 'Charlie Davis', '{"email": "charliedavis@example.com", "phone": "+1234567894"}'),
  ('TICKET006', 'BOK004', 'P006', 'David Wilson', '{"email": "davidwilson@example.com", "phone": "+1234567895"}'),
  ('TICKET007', 'BOK004', 'P007', 'Eva Moore', '{"email": "evamoore@example.com", "phone": "+1234567896"}'),
  ('TICKET008', 'BOK005', 'P008', 'Frank Taylor', '{"email": "franktaylor@example.com", "phone": "+1234567897"}'),
  ('TICKET009', 'BOK005', 'P009', 'Grace Harris', '{"email": "graceharris@example.com", "phone": "+1234567898"}');

-- Вставка данных для связки билетов и рейсов
-- ticket_no и flight_id должны соответствовать вставленным данным
INSERT INTO ticket_flights (ticket_no, flight_id, fare_conditions, amount)
VALUES
  ('TICKET001', 1, 'Economy', 200.00),
  ('TICKET002', 2, 'Economy', 200.00),
  ('TICKET003', 3, 'Business', 450.00),
  ('TICKET004', 4, 'Business', 450.00),
  ('TICKET005', 5, 'Economy', 180.00),
  ('TICKET006', 6, 'Economy', 180.00),
  ('TICKET007', 7, 'Economy', 210.00),
  ('TICKET008', 8, 'Economy', 210.00),
  ('TICKET009', 9, 'Economy', 220.00);

-- Вставка данных для посадочных талонов
-- boarding_no и seat_no могут быть уникальными для каждого билета и рейса
INSERT INTO boarding_passes (ticket_no, flight_id, boarding_no, seat_no)
VALUES
  ('TICKET001', 1, 1, '1A'),
  ('TICKET002', 2, 2, '1B'),
  ('TICKET003', 3, 1, '2A'),
  ('TICKET004', 4, 2, '2B'),
  ('TICKET005', 5, 1, '3A'),
  ('TICKET006', 6, 2, '3B'),
  ('TICKET007', 7, 1, '4A'),
  ('TICKET008', 8, 2, '4B'),
  ('TICKET009', 9, 1, '5A');
