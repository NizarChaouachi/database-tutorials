CREATE DATABASE university_db ;
\c university_db 

CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
age INT CHECK (age >= 18 and age <= 120),
enrollment_date DATE CHECK (enrollment_date >= '2020-01-01'),
gpa DECIMAL(3,2) DEFAULT 0.00,
phone_number CHAR(10),
gender CHAR(1) CHECK (gender IN ('M','F','O')),
is_member BOOLEAN DEFAULT True);

INSERT INTO students (first_name,last_name,email,enrollment_date,age,gpa,phone_number,gender) VALUES
('John','Doe','johndoe@email.com','2023-01-01',25,2.55,'14569874','M');
--Thse INSERT queries will produce an error because they violate the constraints
--NOT NULL last_name
INSERT INTO students (first_name,email,enrollment_date,age,gpa,phone_number,gender) VALUES
('John','johndoe@email.com','2023-01-01',25,2.55,'14569874','M');
--UNIQUE EMAIL
INSERT INTO students (first_name,last_name,email,enrollment_date,age,gpa,phone_number,gender) VALUES
('Jane','Doe','johndoe@email.com','2023-01-01',28,2.55,'14569874','F');
-- CHECK age 
INSERT INTO students (first_name,last_name,email,enrollment_date,age,gpa,phone_number,gender) VALUES
('John','Doe','john@email.com','2023-01-01',12,2.55,'14569874','M');

ALTER TABLE students 
ADD CONSTRAINT unique_phohne_number UNIQUE (phone_number);

ALTER TABLE students                                                                                
DROP CONSTRAINT students_age_check ; --tablename_field_constraint

\d students

ALTER TABLE students 
ALTER COLUMN age SET NOT NULL;

ALTER TABLE students
ALTER COLUMN last_name DROP NOT NULL;

ALTER TABLE students
ADD CONSTRAINT not_admin_student CHECK(first_name != 'Admin');

ALTER TABLE students
ALTER COLUMN gpa SET DEFAULT 2.00;

--You can include more constraints 
CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
age INT CHECK (age >= 18 and age <= 120),
enrollment_date DATE CHECK (enrollment_date >= '2020-01-01'),
gpa DECIMAL(3,2) DEFAULT 0.00,
phone_number CHAR(10) UNIQUE NOT NULL,
gender CHAR(1) CHECK (gender IN ('M','F','O')),
is_member BOOLEAN DEFAULT True);