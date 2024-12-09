
CREATE DATABASE users_db ;

 \c users_db

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

 \dx 

 CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),--generate uuid4
    email VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 );

INSERT INTO users (username, email)
VALUES
    ('alice', 'alice@example.com'),
    ('bob', 'bob@example.com');

SELECT * FROM users;

