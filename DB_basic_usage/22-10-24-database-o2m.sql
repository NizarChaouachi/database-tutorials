CREATE DATABASE books_db ;
\c books_db

CREATE TABLE authors (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL);

CREATE TABLE books (
id SERIAL PRIMARY KEY,
title VARCHAR(200) NOT NULL,
publication_year INT,
author_id INT REFERENCES authors(id) ON DELETE CASCADE);

INSERT INTO authors (name, email)
VALUES ('Author 1', 'author1@example.com'),
       ('Author 2', 'author2@example.com');

INSERT INTO books (title, publication_year, author_id)
VALUES ('Book 1', 2021, 1),
       ('Book 2', 2022, 1),
       ('Book 3', 2020, 2),
       ('Book 4', 2024, 2);

SELECT * FROM books ;
SELECT title,publication_year FROM books where author_id=1 ;

SELECT authors.name,books.title,books.publication_year FROM 
books JOIN authors
ON authors.id = books.author_id;


UPDATE books SET title = title || 'by author 1'WHERE author_id=1;

DELETE FROM books WHERE id = 4;

DELETE FROM authors WHERE id=1;--books also will be deleted

ALTER TABLE books DROP CONSTRAINT books_author_id_fkey;
ALTER TABLE books ADD CONSTRAINT books_author_id_fkey FOREIGN KEY (auhtor_id) 
REFERENCES authors(id) ;

TRUNCATE authors CASCADE;