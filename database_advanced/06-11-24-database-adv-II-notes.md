
### Aggregation Functions

Aggregation functions are used to perform calculations on multiple rows of data and return a single result. Here are some common aggregation functions:

- **`COUNT()`**: Counts the number of rows, or non-`NULL` values in a specified column.
- **`SUM()`**: Adds up all values in a column.
- **`AVG()`**: Calculates the average (mean) of values in a column.
- **`MAX()`**: Returns the maximum value in a column.
- **`MIN()`**: Returns the minimum value in a column.

These functions are often used to get high-level insights from large datasets, such as finding total populations, averages, or counts of specific entries.

### `GROUP BY` Clause

The `GROUP BY` clause groups rows that have the same values in specified columns into summary rows. Once grouped, aggregation functions can be applied to each group independently.

For example, in the query:

```sql
SELECT country_name, COUNT(city_name)
FROM city_population
WHERE year = 2020
GROUP BY country_name;
```

- **`GROUP BY country_name`**: Groups rows by the `country_name` column.
- For each unique country name in the `city_population` table, the query will count the cities (using `COUNT(city_name)`) where the `year` is 2020.

### Applying These Concepts in the Queries

1. **Counting Rows and Distinct Countries**:
   ```sql
   SELECT COUNT(*) FROM city_population;
   SELECT COUNT(DISTINCT country_name) FROM city_population;
   ```
   - `COUNT(*)` returns the total number of rows in `city_population`.
   - `COUNT(DISTINCT country_name)` returns the number of unique countries in the table.

2. **Counting Cities by Country for 2020**:
   ```sql
   SELECT country_name, COUNT(city_name)
   FROM city_population
   WHERE year = 2020
   GROUP BY country_name;
   ```
   - Groups rows by `country_name` for 2020, then counts how many cities each country has in that year.

3. **Average Population by Year**:
   ```sql
   SELECT year, AVG(population) AS average
   FROM city_population
   GROUP BY year;
   ```
   - Groups rows by `year` and calculates the average population for each year.

4. **Total Population by Country for 2020**:
   ```sql
   SELECT country_name, SUM(population) AS sum_2020
   FROM city_population
   WHERE year = 2020
   GROUP BY country_name;
   ```
   - Groups rows by `country_name` for the year 2020 and calculates the sum of populations for each country.

5. **Max Population by Country for 2020**:
   ```sql
   SELECT country_name, MAX(population) AS max_population_2020
   FROM city_population
   WHERE year = 2020
   GROUP BY country_name;
   ```
   - Groups rows by `country_name` for 2020 and finds the maximum population for each country that year.

In summary, aggregation functions provide a way to compute metrics (like sums or averages) across groups defined by `GROUP BY`, which helps break down data into manageable summaries based on specified criteria.