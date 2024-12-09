CREATE DATABASE onlie_shop_db ;

\c onlie_shop_db 

CREATE TABLE Customer (
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
phone_number VARCHAR(15) DEFAULT 'Unkown',
age INT CHECK(AGE >= 18 AND age <= 100),
registration_date DATE DEFAULT CURRENT_DATE);

\d Customer
--Create
INSERT INTO Customer VALUES 
(1,'nizar','nizar','nizar@email.com','145632879',28,DEFAULT);

INSERT INTO Customer(first_name,last_name,age,email,registration_date) VALUES
('James','jobs',45,'james@email.com','2023-05-31');

 INSERT INTO Customer (first_name, last_name, email, phone_number, age)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '555-1234', 30),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 25),
    ('Emily', 'Davis', 'emily.davis@example.com', '555-8765', 40),
    ('Michael', 'Brown', 'michael.brown@example.com', NULL, 50),
    ('Sarah', 'Wilson', 'sarah.wilson@example.com', '555-3456', 22),
    ('David', 'Lee', 'david.lee@example.com', NULL, 35),
    ('Paul', 'Taylor', 'paul.taylor@example.com', '555-9988', 60),
    ('Laura', 'Anderson', 'laura.anderson@example.com', '555-5567', 45),
    ('Thomas', 'Miller', 'thomas.miller@example.com', '555-1122', 33),
    ('Jessica', 'Martinez', 'jessica.martinez@example.com', NULL, 29),
    ('Robert', 'Garcia', 'robert.garcia@example.com', '555-3344', 31),
    ('Linda', 'Rodriguez', 'linda.rodriguez@example.com', NULL, 44),
    ('Susan', 'Martinez', 'susan.martinez@example.com', '555-7788', 50),
    ('James', 'Hernandez', 'james.hernandez@example.com', '555-2211', 36),
    ('Charles', 'Lopez', 'charles.lopez@example.com', '555-6677', 27),
    ('Karen', 'Gonzalez', 'karen.gonzalez@example.com', NULL, 38),
    ('Joseph', 'Hall', 'joseph.hall@example.com', '555-9987', 49),
    ('Patricia', 'King', 'patricia.king@example.com', '555-1001', 21),
    ('Daniel', 'Scott', 'daniel.scott@example.com', '555-1010', 39),
    ('Anna', 'Adams', 'anna.adams@example.com', '555-2020', 58);

--Read
SELECT * FROM customer;

SELECT first_name,last_name,email,registration_date FROM Customer ;

SELECT first_name || '-' || last_name AS full_name,email from customer;

SELECT first_name, CURRENT_DATE - registration_date  AS duration from Customer;

SELECT * FROM customer WHERE first_name = 'Charles';

SELECT first_name,email,phone_number FROM Customer WHERE customer_id > 10 AND age < 35 ;

SELECT first_name,email,phone_number FROM Customer WHERE first_name = 'nizar' OR last_name = 'Brown';

SELECT * FROM Customer WHERE age BETWEEN 20 AND 40 ;

SELECT * FROM Customer WHERE age >= 20 AND age <= 40 ;

SELECT * FROM Customer WHERE customer_id IN (1,5,6,14);

SELECT * FROM Customer WHERE age IN (20, 40) ;

SELECT * from Customer WHERE phone_number IS NULL;

SELECT * from Customer WHERE phone_number IS NOT NULL;

SELECT * FROM Customer WHERE CUSTOMER_id NOT IN (1,3,15);

SELECT * FROM Customer WHERE first_name NOT IN ('nizar','David','Karen','Linda');

SELECT * from Customer WHERE first_name != 'David' ;

--Update 

UPDATE Customer SET last_name = 'python' WHERE first_name = 'nizar';

UPDATE Customer SET phone_number = 1256397 WHERE phone_number IS NULL OR phone_number = 'Unkown';

UPDATE Customer SET last_name = 'Loyal Customer' WHERE customer_id < 10 ;

UPDATE Customer SET first_name = first_name || '-JR' WHERE age < 26 ;

--DELETE

DELETE FROM Customer WHERE first_name ='nizar';

DELETE FROM Customer WHERE CURRENT_DATE - registration_date > 365 ;

DELETE FROM Customer WHERE age BETWEEN 20 AND 45 ;

TRUNCATE Customer ;