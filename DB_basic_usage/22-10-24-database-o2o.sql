-- One to one relation
CREATE DATABASE authors_db ;
\c authors_db;


 CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE author_profile (
id SERIAL PRIMARY KEY,
bio TEXT,
website VARCHAR(100),
author_id INT UNIQUE NOT NULL REFERENCES authors(id) ON DELETE CASCADE);


INSERT INTO authors (name, email)
VALUES ('Author 1', 'author1@example.com'),
       ('Author 2', 'author2@example.com');

INSERT INTO author_profile (bio, website, author_id)
VALUES ('Author 1 bio', 'www.author1.com', 1),
       ('Author 2 bio', 'www.author2.com', 2);

SELECT authors.name,author_profile.bio,author_profile.website,authors.email
FROM authors JOIN author_profile
ON authors.id = author_profile.author_id;

DELETE FROM authors WHERE id = 1;