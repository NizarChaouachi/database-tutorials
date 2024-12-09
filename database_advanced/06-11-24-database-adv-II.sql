 CREATE DATABASE population_db ;

 \c population_db 

 CREATE TABLE city_population (
    city_id serial PRIMARY KEY,
    city_name VARCHAR(50),
    country_name VARCHAR(50),
    population INT,
    year INT
);

INSERT INTO city_population (city_name, country_name, population, year) VALUES
    ('New York City', 'United States', 8537673, 2020),
    ('Los Angeles', 'United States', 39776830, 2020),
    ('Chicago', 'United States', 2693976, 2020),
    ('Toronto', 'Canada', 2731571, 2020),
    ('London', 'United Kingdom', 8961989, 2020),
    ('Paris', 'France', 2148271, 2020),
    ('Sydney', 'Australia', 5312163, 2020),
    ('Mumbai', 'India', 12442373, 2020),
    ('Shanghai', 'China', 27382955, 2020),
    ('São Paulo', 'Brazil', 22043028, 2020),
    ('New York City', 'United States', 8419600, 2010),
    ('Los Angeles', 'United States', 37954200, 2010),
    ('Chicago', 'United States', 2695598, 2010),
    ('Toronto', 'Canada', 2503281, 2010),
    ('London', 'United Kingdom', 8173941, 2010),
    ('Paris', 'France', 2110694, 2010),
    ('Sydney', 'Australia', 4299195, 2010),
    ('Mumbai', 'India', 12478277, 2010),
    ('Shanghai', 'China', 23019148, 2010),
    ('São Paulo', 'Brazil', 19989307, 2010);



     SELECT city_name || ' ' || country_name FROM city_population ;
     SELECT COUNT(*) FROM city_population;

     SELECT COUNT(DISTINCT country_name) FROM city_population;
     SELECT COUNT(DISTINCT country_name) FROM city_population;
     SELECT country_name,COUNT(city_name) FROM city_population WHERE year = 2020 GROUP BY country_name ;
     SELECT year,AVG(population) AS average FROM city_population GROUP BY year ;

     SELECT country_name,AVG(population) as average_2020 from CITY_POPULATION WHERE year = 2020 GROUP BY country_name ;

    SELECT city_name || ' ' || country_name  FROM city_population ORDER BY country_name ;

    select year,SUM(population) FROM city_population GROUP BY year;

     SELECT country_name,SUM(population) as sum_2020 from CITY_POPULATION WHERE year = 2020 GROUP BY country_name ;

     SELECT SUM(population) AS total_sum FROM city_population WHERE year = 2010 ;

     SELECT MAX(population) AS max_2020 FROM city_population WHERE year = 2020 ;
     SELECT MIN(population) AS max_2020 FROM city_population WHERE year = 2020 ;

     SELECT year,MAX(population) FROM city_population GROUP BY year ;

    SELECT year,MIN(population) FROM city_population GROUP BY year ;

    SELECT
    country_name,MAX(population) AS max_population_2020
    FROM
    city_population
    WHERE
    year = 2020 GROUP BY country_name;