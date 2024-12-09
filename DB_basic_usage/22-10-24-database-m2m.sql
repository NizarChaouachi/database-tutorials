CREATE DATABASE online_school_db ;
\c online_school_db

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL
);

--Soltuon is to create junction table 

CREATE TABLE enrollments (
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO students (name)
VALUES ('Student 1'),
       ('Student 2'),
       ('Student 3');

INSERT INTO courses (title)
VALUES ('Math 101'),
       ('Physics 101'),
       ('Chemistry 101');

INSERT INTO enrollments (student_id, course_id) VALUES 
(1,1),
(1,3),
(2,2),
(2,1),
(3,1),
(3,2),
(3,3);

SELECT courses.title,student.name FROM 
enrollments JOIN courses ON enrollments.course_id = courses.id JOIN
students ON enrollments.student_id = students.id ;

SELECT courses.title AS course_title, students.name AS student_name
FROM enrollments
JOIN courses ON enrollments.course_id = courses.id
JOIN students ON enrollments.student_id = students.id;

UPDATE enrollments SET course_id = 2
WHERE student_id = 1 AND course_id = 3;

DELETE FROM courses WHERE id = 1;
DELETE FROM students WHERE id = 3;