✈️ Airline Reservation System – Database Project
Welcome aboard the Airline Reservation System – a complete relational database backend for managing flights, passengers, bookings, and payments like a real-world airline.
This repository is designed for students, beginners, and backend enthusiasts who want to understand how an airline’s core data layer actually works.

🚀 Features
Flight management: Airlines, flights, routes, schedules, and statuses
Booking system: Reservations, ticketing, seat assignment, booking history
Passenger profiles: Personal details, contact info, and travel records
Payments: Fares, payment methods, and transaction logging
Admin operations: Add/update/delete flights, routes, and aircrafts
Relational design: Proper keys, constraints, and relationships
Sample data: Ready-made test data to run queries immediately

🧱 Tech Stack
Database: MySQL
Language: SQL (DDL + DML)
Tools: MySQL Workbench

📂 Repository Structure
schema.sql – Creates all tables, keys, and constraints
data.sql – Inserts sample data (flights, passengers, bookings, etc.)
queries.sql – Example queries and reports
views.sql – Helpful views for common operations (optional)
triggers.sql – Business rules and automatic updates (optional)
docs/ – ER diagram, architecture notes, and design decisions


🧬 Database Design Overview
Core entities include:

Airline – Airline details
Airport – Sourceand destination airports
Aircraft – Plane details and capacities
Flight – Flight number, route, timing, aircraft
Passenger – Customer records
Booking / Reservation – Who booked what and when
Ticket – Ticket info, seat, class
Payment – Amounts, methods, and status

Example relationship:
One Flight can have multiple Bookings, and one Passenger can have multiple Bookings, but each Booking links exactly one passenger to one specific flight.

🛠️ How to Run
Clone the repo

bash
git clone https://github.com/santh0sh00/AirlineReservationSystem-database.git
cd AirlineReservationSystem-database
Create database

sql
CREATE DATABASE airline_reservation;
USE airline_reservation;
Run schema

sql
SOURCE schema.sql;
Insert sample data

sql
SOURCE data.sql;
Test queries

sql
SOURCE queries.sql;
Update the commands to match your DB engine and file names.

🔍 Sample Queries
A few examples you can run after setup:
List all upcoming flights between two cities
Find available seats for a given flight and date
Show booking history for a specific passenger
Daily revenue report by flight or route
You can add real SQL samples here, for example:

sql
SELECT f.flight_no, a1.city AS source_city, a2.city AS destination_city, f.departure_time
FROM flights f
JOIN airports a1 ON f.source_airport_id = a1.airport_id
JOIN airports a2 ON f.destination_airport_id = a2.airport_id
WHERE a1.city = 'Delhi' AND a2.city = 'Mumbai';
📊 ER Diagram


🎓 Use Cases
This project is ideal for:
Database design / DBMS course projects
Practicing SQL queries, joins, and constraints
Demonstrating backend/database skills in your portfolio
Extending into a full-stack airline reservation app

🛠️ Possible Extensions
Add user roles (admin, agent, customer)
Integrate with a web UI or API
Add loyalty program and reward points
Implement cancellation policies and waitlists

🤝 Contributing
Contributions are welcome:
Report bugs
Suggest schema improvements
Add optimized queries, views, or stored procedures
Improve documentation or diagrams
Fork the repo
Create a feature branch
Commit changes
Open a pull request


✉️ Contact
Author: Your Name

Email: your.email@example.com

LinkedIn/GitHub: your links here
