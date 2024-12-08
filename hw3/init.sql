CREATE TABLE bookings (
    book_ref CHAR(6) PRIMARY KEY,
    book_date TIMESTAMPTZ NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL
);

CREATE TABLE tickets (
    ticket_no CHAR(13) PRIMARY KEY,
    book_ref CHAR(6) REFERENCES bookings(book_ref),
    passenger_id VARCHAR(20) NOT NULL,
    passenger_name TEXT NOT NULL,
    contact_data JSONB
);

CREATE TABLE ticket_flights (
    ticket_no CHAR(13) REFERENCES tickets(ticket_no),
    flight_id INTEGER NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (ticket_no, flight_id)
);

CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    flight_no CHAR(6) NOT NULL,
    scheduled_departure TIMESTAMPTZ NOT NULL,
    scheduled_arrival TIMESTAMPTZ NOT NULL,
    departure_airport CHAR(3) NOT NULL,
    arrival_airport CHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL,
    aircraft_code CHAR(3) NOT NULL,
    actual_departure TIMESTAMPTZ,
    actual_arrival TIMESTAMPTZ
);

CREATE TABLE airports (
    airport_code CHAR(3) PRIMARY KEY,
    airport_name TEXT NOT NULL,
    city TEXT NOT NULL,
    coordinates_lon DOUBLE PRECISION NOT NULL,
    coordinates_lat DOUBLE PRECISION NOT NULL,
    timezone TEXT NOT NULL
);

CREATE TABLE aircrafts (
    aircraft_code CHAR(3) PRIMARY KEY,
    model JSONB NOT NULL,
    range INTEGER NOT NULL
);

CREATE TABLE seats (
    aircraft_code CHAR(3) REFERENCES aircrafts(aircraft_code),
    seat_no VARCHAR(4) NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    PRIMARY KEY (aircraft_code, seat_no)
);

CREATE TABLE boarding_passes (
    ticket_no CHAR(13) REFERENCES tickets(ticket_no),
    flight_id INTEGER REFERENCES flights(flight_id),
    boarding_no INTEGER NOT NULL,
    seat_no VARCHAR(4) NOT NULL,
    PRIMARY KEY (ticket_no, flight_id)
);
CREATE OR REPLACE VIEW airport_passenger_stats AS
SELECT
    a.airport_code AS airport_code,
    COUNT(DISTINCT f.flight_id) FILTER (WHERE f.departure_airport = a.airport_code) AS departure_flights_num,
    COUNT(bp.ticket_no) FILTER (WHERE f.departure_airport = a.airport_code) AS departure_psngr_num,
    COUNT(DISTINCT f.flight_id) FILTER (WHERE f.arrival_airport = a.airport_code) AS arrival_flights_num,
    COUNT(bp.ticket_no) FILTER (WHERE f.arrival_airport = a.airport_code) AS arrival_psngr_num
FROM
    airports a
LEFT JOIN
    flights f ON a.airport_code IN (f.departure_airport, f.arrival_airport)
LEFT JOIN
    boarding_passes bp ON f.flight_id = bp.flight_id
GROUP BY
    a.airport_code;

CREATE SCHEMA IF NOT EXISTS presentation;