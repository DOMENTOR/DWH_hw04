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

-- Добавляем дополнительные записи бронирований
INSERT INTO bookings (book_ref, book_date, total_amount)
VALUES
  ('BOK006', '2024-12-06 12:00:00', 800.00),
  ('BOK007', '2024-12-07 13:00:00', 1500.00),
  ('BOK008', '2024-12-08 14:00:00', 2000.00),
  ('BOK009', '2024-12-09 15:00:00', 950.00),
  ('BOK010', '2024-12-10 16:00:00', 1200.00),
  ('BOK011', '2024-12-11 17:00:00', 1100.00),
  ('BOK012', '2024-12-12 18:00:00', 900.00),
  ('BOK013', '2024-12-13 19:00:00', 1400.00),
  ('BOK014', '2024-12-14 20:00:00', 1350.00),
  ('BOK015', '2024-12-15 21:00:00', 1100.00);

-- Добавляем пассажиров и билеты
INSERT INTO tickets (ticket_no, book_ref, passenger_id, passenger_name, contact_data)
VALUES
  ('TICKET010', 'BOK006', 'P001', 'John Doe', '{"email": "johndoe@example.com", "phone": "+1234567890"}'),
  ('TICKET011', 'BOK006', 'P010', 'Lucas Green', '{"email": "lucasgreen@example.com", "phone": "+1234567899"}'),
  ('TICKET012', 'BOK007', 'P002', 'Jane Smith', '{"email": "janesmith@example.com", "phone": "+1234567891"}'),
  ('TICKET013', 'BOK007', 'P011', 'Oliver White', '{"email": "oliverwhite@example.com", "phone": "+1234567810"}'),
  ('TICKET014', 'BOK008', 'P003', 'Bob Johnson', '{"email": "bobjohnson@example.com", "phone": "+1234567892"}'),
  ('TICKET015', 'BOK008', 'P012', 'Sophia Black', '{"email": "sophiablack@example.com", "phone": "+1234567811"}'),
  ('TICKET016', 'BOK009', 'P013', 'Emily Miller', '{"email": "emilymiller@example.com", "phone": "+1234567812"}'),
  ('TICKET017', 'BOK009', 'P004', 'Alice Brown', '{"email": "alicebrown@example.com", "phone": "+1234567893"}'),
  ('TICKET018', 'BOK010', 'P014', 'Henry Clark', '{"email": "henryclark@example.com", "phone": "+1234567813"}'),
  ('TICKET019', 'BOK010', 'P005', 'Charlie Davis', '{"email": "charliedavis@example.com", "phone": "+1234567894"}');

-- Связываем билеты с рейсами и указываем класс обслуживания и стоимость
INSERT INTO ticket_flights (ticket_no, flight_id, fare_conditions, amount)
VALUES
  ('TICKET010', 1, 'Economy', 200.00),
  ('TICKET011', 2, 'Economy', 200.00),
  ('TICKET012', 3, 'Business', 450.00),
  ('TICKET013', 4, 'Business', 450.00),
  ('TICKET014', 5, 'Economy', 180.00),
  ('TICKET015', 6, 'Business', 550.00),
  ('TICKET016', 7, 'Economy', 210.00),
  ('TICKET017', 8, 'Economy', 210.00),
  ('TICKET018', 9, 'Economy', 220.00),
  ('TICKET019', 10, 'Business', 500.00);

-- Добавляем данные для посадочных талонов
INSERT INTO boarding_passes (ticket_no, flight_id, boarding_no, seat_no)
VALUES
  ('TICKET010', 1, 2, '5B'),
  ('TICKET011', 2, 3, '5C'),
  ('TICKET012', 3, 3, '2C'),
  ('TICKET013', 4, 4, '2D'),
  ('TICKET014', 5, 2, '6A'),
  ('TICKET015', 6, 3, '1F'),
  ('TICKET016', 7, 4, '6B'),
  ('TICKET017', 8, 5, '7A'),
  ('TICKET018', 9, 4, '8B'),
  ('TICKET019', 10, 3, '3C');

  -- Добавляем новые рейсы на те же даты, но с другим временем
INSERT INTO flights (flight_id, flight_no, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, status, aircraft_code)
VALUES
  (11, 'AA110', '2024-12-20 18:00:00', '2024-12-20 20:00:00', 'JFK', 'ORD', 'Scheduled', 'A32'),
  (12, 'UA111', '2024-12-21 19:30:00', '2024-12-21 21:30:00', 'LAX', 'JFK', 'Scheduled', 'B73'),
  (13, 'DL112', '2024-12-22 20:00:00', '2024-12-22 22:00:00', 'ORD', 'SFO', 'Scheduled', 'A32'),
  (14, 'AA113', '2024-12-23 21:00:00', '2024-12-23 23:00:00', 'JFK', 'ATL', 'Scheduled', 'A32'),
  (15, 'UA114', '2024-12-24 22:30:00', '2024-12-24 00:30:00', 'LAX', 'SFO', 'Scheduled', 'B73'),
  (16, 'DL115', '2024-12-25 23:00:00', '2024-12-26 01:00:00', 'ORD', 'LAX', 'Scheduled', 'A32'),
  (17, 'AA116', '2024-12-26 06:00:00', '2024-12-26 08:00:00', 'JFK', 'SFO', 'Scheduled', 'A32'),
  (18, 'UA117', '2024-12-27 07:30:00', '2024-12-27 09:30:00', 'LAX', 'ORD', 'Scheduled', 'B73'),
  (19, 'DL118', '2024-12-28 08:00:00', '2024-12-28 10:00:00', 'ORD', 'JFK', 'Scheduled', 'A32'),
  (20, 'AA119', '2024-12-29 09:30:00', '2024-12-29 11:30:00', 'ATL', 'LAX', 'Scheduled', 'A32');

-- Связываем существующих пассажиров с новыми рейсами
INSERT INTO ticket_flights (ticket_no, flight_id, fare_conditions, amount)
VALUES
  -- Рейс 11
  ('TICKET001', 11, 'Economy', 200.00),
  ('TICKET002', 11, 'Economy', 200.00),
  ('TICKET003', 11, 'Business', 450.00),
  ('TICKET004', 11, 'Business', 450.00),

  -- Рейс 12
  ('TICKET005', 12, 'Economy', 180.00),
  ('TICKET006', 12, 'Economy', 180.00),
  ('TICKET007', 12, 'Economy', 210.00),
  ('TICKET008', 12, 'Economy', 210.00),

  -- Рейс 13
  ('TICKET009', 13, 'Economy', 220.00),
  ('TICKET010', 13, 'Economy', 200.00),
  ('TICKET011', 13, 'Economy', 200.00),
  ('TICKET012', 13, 'Business', 450.00),

  -- Рейс 14
  ('TICKET013', 14, 'Business', 450.00),
  ('TICKET014', 14, 'Economy', 180.00),
  ('TICKET015', 14, 'Business', 550.00),
  ('TICKET016', 14, 'Economy', 210.00),

  -- Рейс 15
  ('TICKET017', 15, 'Economy', 210.00),
  ('TICKET018', 15, 'Economy', 220.00),
  ('TICKET019', 15, 'Business', 500.00),
  ('TICKET001', 15, 'Economy', 200.00),

  -- Рейс 16
  ('TICKET002', 16, 'Economy', 200.00),
  ('TICKET003', 16, 'Business', 450.00),
  ('TICKET004', 16, 'Business', 450.00),
  ('TICKET005', 16, 'Economy', 180.00),

  -- Рейс 17
  ('TICKET006', 17, 'Economy', 180.00),
  ('TICKET007', 17, 'Economy', 210.00),
  ('TICKET008', 17, 'Economy', 210.00),
  ('TICKET009', 17, 'Economy', 220.00),

  -- Рейс 18
  ('TICKET010', 18, 'Economy', 200.00),
  ('TICKET011', 18, 'Economy', 200.00),
  ('TICKET012', 18, 'Business', 450.00),
  ('TICKET013', 18, 'Business', 450.00),

  -- Рейс 19
  ('TICKET014', 19, 'Economy', 180.00),
  ('TICKET015', 19, 'Business', 550.00),
  ('TICKET016', 19, 'Economy', 210.00),
  ('TICKET017', 19, 'Economy', 210.00),

  -- Рейс 20
  ('TICKET018', 20, 'Economy', 220.00),
  ('TICKET019', 20, 'Business', 500.00),
  ('TICKET001', 20, 'Economy', 200.00),
  ('TICKET002', 20, 'Economy', 200.00);

-- Добавляем посадочные талоны для новых рейсов
INSERT INTO boarding_passes (ticket_no, flight_id, boarding_no, seat_no)
VALUES
  -- Рейс 11
  ('TICKET001', 11, 1, '6A'),
  ('TICKET002', 11, 2, '6B'),
  ('TICKET003', 11, 3, '6C'),
  ('TICKET004', 11, 4, '6D'),

  -- Рейс 12
  ('TICKET005', 12, 1, '7A'),
  ('TICKET006', 12, 2, '7B'),
  ('TICKET007', 12, 3, '7C'),
  ('TICKET008', 12, 4, '7D'),

  -- Рейс 13
  ('TICKET009', 13, 1, '8A'),
  ('TICKET010', 13, 2, '8B'),
  ('TICKET011', 13, 3, '8C'),
  ('TICKET012', 13, 4, '8D'),

  -- Рейс 14
  ('TICKET013', 14, 1, '9A'),
  ('TICKET014', 14, 2, '9B'),
  ('TICKET015', 14, 3, '9C'),
  ('TICKET016', 14, 4, '9D'),

  -- Рейс 15
  ('TICKET017', 15, 1, '10A'),
  ('TICKET018', 15, 2, '10B'),
  ('TICKET019', 15, 3, '10C'),
  ('TICKET001', 15, 4, '10D'),

  -- Рейс 16
  ('TICKET002', 16, 1, '11A'),
  ('TICKET003', 16, 2, '11B'),
  ('TICKET004', 16, 3, '11C'),
  ('TICKET005', 16, 4, '11D'),

  -- Рейс 17
  ('TICKET006', 17, 1, '12A'),
  ('TICKET007', 17, 2, '12B'),
  ('TICKET008', 17, 3, '12C'),
  ('TICKET009', 17, 4, '12D'),

  -- Рейс 18
  ('TICKET010', 18, 1, '13A'),
  ('TICKET011', 18, 2, '13B'),
  ('TICKET012', 18, 3, '13C'),
  ('TICKET013', 18, 4, '13D'),

  -- Рейс 19
  ('TICKET014', 19, 1, '14A'),
  ('TICKET015', 19, 2, '14B'),
  ('TICKET016', 19, 3, '14C'),
  ('TICKET017', 19, 4, '14D'),

  -- Рейс 20
  ('TICKET018', 20, 1, '15A'),
  ('TICKET019', 20, 2, '15B'),
  ('TICKET001', 20, 3, '15C'),
  ('TICKET002', 20, 4, '15D');

-- Добавляем новый рейс с той же датой и временем отправления, как у рейса 11 (2024-12-20 18:00:00)
INSERT INTO flights (flight_id, flight_no, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, status, aircraft_code)
VALUES
  (21, 'DL120', '2024-12-20 18:00:00', '2024-12-20 20:00:00', 'JFK', 'SFO', 'Scheduled', 'A32');

-- Добавляем новый уникальный билет для пассажира
INSERT INTO tickets (ticket_no, book_ref, passenger_id, passenger_name, contact_data)
VALUES
  ('TICKET050', 'BOK006', 'P050', 'Henry Walker', '{"email": "henrywalker@example.com", "phone": "+1234567899"}');

-- Добавляем связь билета с новым рейсом
INSERT INTO ticket_flights (ticket_no, flight_id, fare_conditions, amount)
VALUES
  ('TICKET050', 21, 'Business', 500.00);

-- Добавляем посадочный талон для нового рейса
INSERT INTO boarding_passes (ticket_no, flight_id, boarding_no, seat_no)
VALUES
  ('TICKET050', 21, 1, '1F');
