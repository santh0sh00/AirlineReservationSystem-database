-- Create Database
DROP DATABASE IF EXISTS AirlineReservation;
CREATE DATABASE AirlineReservation;
USE AirlineReservation;

-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    passport_no VARCHAR(20) UNIQUE NOT NULL,
    nationality VARCHAR(50)
);

-- Create Flights Table
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10) UNIQUE NOT NULL, 
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL CHECK (available_seats >= 0)
);

-- Create Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    flight_id INT,
    seat_number VARCHAR(5),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'CONFIRMED',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20),
    status VARCHAR(20) DEFAULT 'SUCCESS',
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Insert Sample Customers
INSERT INTO Customers (full_name, email, phone, passport_no, nationality) VALUES
('aryan patil', 'aryanpatil@gmail.com', '9876543210', 'IN123456', 'Indian'),
('venkata lokesh', 'venkatalokesh@gmail.com', '9123456789', 'IN654321', 'Indian'),
('nikki', 'nikki@gmail.com', '9988776655', 'US567890', 'American');


-- Insert Sample Flights
INSERT INTO Flights (flight_number, source, destination, departure_time, arrival_time, total_seats, available_seats) VALUES
('AI101', 'Delhi', 'Mumbai', '2025-11-01 10:00:00', '2025-11-01 12:00:00', 150, 150),
('AI202', 'Mumbai', 'Chennai', '2025-11-02 14:00:00', '2025-11-02 16:30:00', 180, 180),
('AI303', 'Bangalore', 'Delhi', '2025-11-03 09:30:00', '2025-11-03 12:45:00', 200, 200);

-- Triggers for Seat Management

DELIMITER $$

-- Decrease seats after booking
CREATE TRIGGER trg_update_seats_after_booking
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    UPDATE Flights
    SET available_seats = available_seats - 1
    WHERE flight_id = NEW.flight_id;
END $$

-- Increase seats after cancellation
CREATE TRIGGER trg_update_seats_after_cancel
AFTER UPDATE ON Bookings
FOR EACH ROW
BEGIN
    IF NEW.status = 'CANCELLED' THEN
        UPDATE Flights
        SET available_seats = available_seats + 1
        WHERE flight_id = NEW.flight_id;
    END IF;
END $$

DELIMITER ;

-- Stored Procedure for Booking a Flight
DELIMITER $$

CREATE PROCEDURE BookFlight(
    IN c_id INT,
    IN f_id INT,
    IN seat VARCHAR(5),
    IN pay_method VARCHAR(20),
    IN amt DECIMAL(10,2)
)
BEGIN
    DECLARE booking INT;

    -- Insert booking record
    INSERT INTO Bookings (customer_id, flight_id, seat_number)
    VALUES (c_id, f_id, seat);

    SET booking = LAST_INSERT_ID();

    -- Insert payment record
    INSERT INTO Payments (booking_id, amount, payment_method)
    VALUES (booking, amt, pay_method);

    -- Update available seats
    UPDATE Flights
    SET available_seats = available_seats - 1
    WHERE flight_id = f_id;
END $$

DELIMITER ;

--  Create Views

CREATE VIEW FlightSchedule AS
SELECT flight_number, source, destination, departure_time, arrival_time
FROM Flights
ORDER BY departure_time;

CREATE VIEW PassengerList AS
SELECT f.flight_number, c.full_name, b.seat_number
FROM Bookings b
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Customers c ON b.customer_id = c.customer_id;

-- ===============================
--  SAMPLE QUERIES FOR TESTING
-- ===============================

--  List all available flights
SELECT * FROM FlightSchedule;

-- Make a booking using the stored procedure
CALL BookFlight(1, 1, 'A12', 'Credit Card', 5500.00);

-- View all bookings
SELECT * FROM Bookings;

-- View all payments
SELECT * FROM Payments;

-- View passengers on a particular flight
SELECT * FROM PassengerList WHERE flight_number = 'AI101';

-- Cancel a booking
UPDATE Bookings SET status = 'CANCELLED' WHERE booking_id = 1;

-- Check available seats after cancellation
SELECT flight_number, available_seats FROM Flights WHERE flight_id = 1;

-- Total revenue
SELECT SUM(amount) AS Total_Revenue FROM Payments WHERE status = 'SUCCESS';
