CREATE DATABASE employees_db ;
\c employees_db 
CREATE SCHEMA company_schema;
\dn
CREATE TABLE company_schema.employees (
employee_id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
birthdate DATE,
salary DECIMAL(10,2),
office_nr INT,
email VARCHAR(70),
is_full_time BOOLEAN,
bio TEXT);
\d company_schema.employees
ALTER TABLE company_schema.employees 
ADD COLUMN bonus INT;

ALTER TABLE company_schema.employees 
RENAME TO staff ;

ALTER TABLE company_schema.staff 
RENAME COLUMN office_nr TO office_number;

ALTER TABLE company_schema.staff 
ALTER COLUMN office_number TYPE VARCHAR(4);

ALTER TABLE company_schema.staff 
DROP COLUMN bio;

TRUNCATE company_schema.staff ;

DROP TABLE company_schema.staff ;

DROP SCHEMA company_schema ;

\c postgres 

DROP DATABASE employees_db ;

-- To run an sql file
\i path/to/file.sql