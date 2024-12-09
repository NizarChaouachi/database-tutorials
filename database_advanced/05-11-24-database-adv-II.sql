CREATE DATABASE weather_data;
\c weather_data
CREATE TABLE temp_data (
    city varchar(20),
    temp_readings numeric[][]--2D array of numerics
);

INSERT INTO temp_data (city,temp_readings) VALUES 
('Berlin',ARRAY[[12.3,15.7,10],[14.2,17.5,11],[10.8,13.2,8.8]]),
('Hamburg',ARRAY[[11.3,16.7,8.5],[12.2,17.8,10.5],[9.8,11.2,6.8]]);

SELECT * FROM temp_data;

SELECT city,temp_readings[1][2] FROM temp_data;

SELECT city,temp_readings[2][1] FROM temp_data;

SELECT city,temp_readings[1:1] as day_1 FROM temp_data;

SELECT city,temp_readings[1:2] as day_1 FROM temp_data;

UPDATE temp_data SET temp_readings[2][1] = 15 WHERE city = 'Berlin';

UPDATE temp_data SET temp_readings = temp_readings || '{22.0,25,17}' WHERE city = 'Hamburg';

--UPDATE temp_data SET temp_readings=array_append(temp_readings,'{22.0,25,17}') WHERE city = 'Berlin';--not working on 2D arrays
