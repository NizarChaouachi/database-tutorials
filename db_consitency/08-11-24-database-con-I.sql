CREATE DATABASE online_shop ;

\c online_shop 

CREATE TABLE customers (
    ID SERIAL PRIMARY KEY,
    username VARCHAR(50),
    balance DECIMAL(10,2) CHECK(BALANCE>=0)
) ;

CREATE TABLE products (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT CHECK(stock > 0));

CREATE TABLE store_owner(
    id SERIAL PRIMARY KEY,
    owner_name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO customers (username, balance) VALUES
('Alice', 100.00),
('Bob', 200.00),
('Charlie', 150.00);

INSERT INTO products (name, price, stock) VALUES
('Laptop', 300.00, 10),
('Smartphone', 150.00, 5),
('Headphones', 50.00, 20);

INSERT INTO store_owner (owner_name, balance) VALUES
('John Smith', 1000.00),
('Emma Brown', 1500.00);
SELECT * FROM customers;
SELECT * FROM products ;
BEGIN;

UPDATE products
SET stock = stock - 1
WHERE name = 'Smartphone';
UPDATE customers
SET balance = balance - 150
WHERE username = 'Bob';

COMMIT;

SELECT * FROM customers;
SELECT * FROM products ;

BEGIN;
 UPDATE products
 SET stock = stock - 1
 WHERE name = 'Laptop' ;

 UPDATE customers 
 set balance = balance -  300
 WHERE username = 'Alice';

 ROLLBACK ; 

SELECT * FROM customers;
SELECT * FROM products ;

-- Let us introduce a savepoint 
BEGIN;
 UPDATE PRODUCTS SET
 stock = stock - 1 WHERE
 name = 'Smartphone' ;

 UPDATE customers SET balance = balance - (SELECT price FROM products WHERE
 name = 'Smartphone') WHERE name = 'Alice';

 SAVEPOINT AfterPhonePurchase ;
  
  UPDATE PRODUCTS SET
 stock = stock - 1 WHERE
 name = 'Laptop' ;
SELECT * FROM products ;
  UPDATE customers SET balance = balance - (SELECT price FROM products WHERE
 name = 'Laptop') WHERE username = 'Alice';

ROLLBACK TO SAVEPOINT AfterPhonePurchase;

 UPDATE PRODUCTS SET
 stock = stock - 1 WHERE
 name = 'Headphones' ;

 UPDATE customers SET balance = balance - (SELECT price FROM products WHERE
 name = 'Headphones') WHERE username = 'Alice';

 commit ;

 SELECT * FROM customers;
SELECT * FROM products ;