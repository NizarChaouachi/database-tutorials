CREATE DATABASE students ;

CREATE TABLE students (
id SERIAL PRIMARY KEY,
student_name varchar(50),
course_enrollments text[]);-- array of texts

INSERT INTO students (student_name,course_enrollments) VALUES
('Alice',ARRAY['Math','History','Biology']),
('Bob', ARRAY['Science', 'English']),
('Charlie', ARRAY['Math', 'Art']);

SELECT * FROM students ;

SELECT student_name,course_enrollments[1] AS first_course FROM students; --indexing starts from 1
SELECT student_name,unnest(course_enrollments) FROM students;

SELECT student_name FROM students WHERE 'Math' = ANY(course_enrollments) ;

UPDATE students SET course_enrollments[1] = 'Music' WHERE student_name = 'Bob';

UPDATE students
SET course_enrollments = array_replace(course_enrollments, 'Music', 'Python')
WHERE student_name = 'Bob';

UPDATE students
SET course_enrollments = array_append(course_enrollments, 'Physics')
WHERE student_name = 'Alice';

UPDATE students
SET course_enrollments = array_remove(course_enrollments, 'English')
WHERE student_name = 'Bob';