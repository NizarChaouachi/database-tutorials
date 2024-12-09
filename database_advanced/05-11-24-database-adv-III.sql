CREATE DATABASE phone_store_db ;

\c phone_store_db

CREATE TABLE phones (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    descrption TEXT,
    price NUMERIC(10,2),
    attributes JSONB
);
INSERT INTO phones (name, descrption, price, attributes)
VALUES
    ('iPhone 13', 'The latest iPhone', 799.99, '{"color": "Silver", "storage": "128GB", "camera": "12MP", "brand": "Apple"}'),
    ('Samsung Galaxy S21', 'High-end Android phone', 699.99, '{"color": "Phantom Black", "storage": "256GB", "camera": "108MP", "brand": "Samsung"}'),
    ('Google Pixel 6', 'Flagship Google phone', 599.99, '{"color": "Sorta Seafoam", "storage": "128GB", "camera": "50MP", "brand": "Google"}'),
    ('OnePlus 9', 'Powerful Android device', 649.99, '{"color": "Astral Black", "storage": "256GB", "camera": "48MP", "brand": "OnePlus"}'),
    ('Xiaomi Mi 11', 'Feature-packed Xiaomi phone', 549.99, '{"color": "Midnight Gray", "storage": "128GB", "camera": "108MP", "brand": "Xiaomi"}'),
    ('Huawei P40', 'Flagship Huawei device', 599.99, '{"color": "Deep Sea Blue", "storage": "256GB", "camera": "50MP", "brand": "Huawei"}'),
    ('LG G8', 'LGs flagship model', 449.99, '{"color": "Platinum Gray", "storage": "128GB", "camera": "16MP", "brand": "LG"}'),
    ('Sony Xperia 5', 'Sonys Xperia series', 699.99, '{"color": "Red", "storage": "128GB", "camera": "12MP", "brand": "Sony"}'),
    ('Nokia 9', 'A comeback from Nokia', 399.99, '{"color": "Midnight Blue", "storage": "128GB", "camera": "12MP", "brand": "Nokia"}'),
    ('Motorola Moto G7', 'Affordable Android option', 199.99, '{"color": "Ceramic Black", "storage": "64GB", "camera": "12MP", "brand": "Motorola"}');

SELECT * FROM phones ;

SELECT * FROM phones WHERE attributes ->> 'brand' = 'Samsung';
SELECT * FROM phones WHERE attributes ->> 'storage' = '128GB';

SELECT name,attributes #>> '{brand}' AS brand FROM phones ;
SELECT name,attributes #> '{brand}' AS brand FROM phones ;

SELECT name,attributes #> '{storage}'  FROM phones ;

SELECT name,descrption FROM phones WHERE attributes @> '{"brand":"Apple"}';

SELECT * FROM phones WHERE attributes @> '{"brand":"Samsung","storage":"256GB"}';

UPDATE phones SET attributes = jsonb_set(attributes,'{storage}','"256GB"') WHERE name = 'LG G8';

UPDATE phones SET attributes = jsonb_set(attributes,'{screen size}','"6 inches"') WHERE name = 'Samsung Galaxy S21';