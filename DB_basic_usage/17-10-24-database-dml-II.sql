CREATE DATABASE another_company;

CREATE TABLE IF NOT EXISTS departments(
id SERIAL PRIMARY KEY,
department_name VARCHAR(50) UNIQUE NOT NULL,
manager_id INT,
location VARCHAR(100));

INSERT INTO departments (department_name,manager_id,location) VALUES
('Finance',1,'Berlin'),
('Marketing',3,'Hamburg');

DROP TABLE IF EXISTS departments ;