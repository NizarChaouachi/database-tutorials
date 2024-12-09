CREATE DATABASE employee_db ;
\c employee_db 

CREATE TABLE departments(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE );

CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT REFERENCES departments(id) ON DELETE SET NULL,
    salary NUMERIC(10,2) NOT NULL,
    hire_date DATE not NULL
);
INSERT INTO departments (name) VALUES 
('HR'),
('Finance'),
('IT'),
('Sales');

INSERT INTO employees (first_name, last_name, department_id, salary, hire_date) VALUES
('Alice', 'Smith', 1, 60000, '2022-01-15'),
('Bob', 'Johnson', 2, 75000, '2021-03-22'),
('Charlie', 'Williams', 3, 70000, '2023-06-01'),
('Diana', 'Jones', 1, 50000, '2022-11-30'),
('Ethan', 'Brown', 2, 80000, '2021-08-14'),
('Fiona', 'Davis', 3, 90000, '2023-05-05'),
('George', 'Garcia', 4, 65000, '2023-02-20');

CREATE VIEW employee_full_name AS
SELECT first_name || ' ' || last_name AS full_name 
FROM employees ORDER BY first_name ;

SELECT * FROM employee_full_name ;

SELECT * FROM employee_full_name  WHERE full_name LIKE 'C%';--starts with C

CREATE VIEW high_salary_emp AS 
SELECT first_name,last_name,salary FROM employees
WHERE salary >= 80000 ORDER BY salary DESC;

SELECT * FROM high_salary_emp ;

\dv --display views

CREATE VIEW experienced_emp AS
SELECT  first_name || ' ' || last_name AS full_name,hire_date
FROM employees
WHERE CURRENT_DATE-hire_date > 700 ;

SELECT * FROM experienced_emp ;

CREATE OR REPLACE VIEW experienced_emp AS
SELECT  first_name || ' ' || last_name AS full_name,hire_date
FROM employees
WHERE CURRENT_DATE-hire_date > 700 ORDER BY hire_date;--UPDATING A VIEW

CREATE VIEW empl_dep_view AS 
SELECT employees.first_name,employees.last_name,departments.name FROM
employees JOIN departments ON employees.department_id = departments.id ;

SELECT * FROM empl_dep_view ;
SELECT * FROM empl_dep_view WHERE name= 'IT';

DROP VIEW experienced_emp;