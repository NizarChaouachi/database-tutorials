
### 1. Creating the Database and Switching to It

```sql
CREATE DATABASE weather_data;
\c weather_data
```

- **Explanation**: Creates a new database called `weather_data` and switches the session to this database.

---

### 2. Creating the `temp_data` Table

```sql
CREATE TABLE temp_data (
    city varchar(20),
    temp_readings numeric[][] -- 2D array of numerics
);
```

- **Explanation**: Creates a table called `temp_data` with:
  - `city` as a `VARCHAR` column (for city names, with a max length of 20 characters).
  - `temp_readings` as a 2D array of numeric values, designed to hold temperature readings in a matrix format.

---

### 3. Inserting Data into `temp_data`

```sql
INSERT INTO temp_data (city, temp_readings) VALUES 
('Berlin', ARRAY[[12.3, 15.7, 10], [14.2, 17.5, 11], [10.8, 13.2, 8.8]]),
('Hamburg', ARRAY[[11.3, 16.7, 8.5], [12.2, 17.8, 10.5], [9.8, 11.2, 6.8]]);
```

- **Explanation**: Inserts temperature readings as 2D arrays for Berlin and Hamburg. Each array represents daily temperature readings across multiple days, with each row being a different day.

---

### 4. Selecting All Data from `temp_data`

```sql
SELECT * FROM temp_data;
```

- **Explanation**: Displays all columns and rows from `temp_data`, showing each city's temperature readings.

---

### 5. Accessing Specific Elements in the 2D Array

```sql
SELECT city, temp_readings[1][2] FROM temp_data;
```

- **Explanation**: Selects the second temperature reading on the first day for each city.
  - `temp_readings[1][2]` accesses the second element in the first row (day 1).
  - Example output: if `temp_readings[1][2]` for Berlin is `15.7`, it will display that value.

```sql
SELECT city, temp_readings[2][1] FROM temp_data;
```

- **Explanation**: Selects the first temperature reading on the second day for each city.
  - `temp_readings[2][1]` accesses the first element in the second row (day 2).

---

### 6. Selecting a Range of Days

```sql
SELECT city, temp_readings[1:1] AS day_1 FROM temp_data;
```

- **Explanation**: Selects only the readings from the first day for each city, returning a 2D array with just the first row.
  - `temp_readings[1:1]` slices the array to return only the first row as a 2D array.

```sql
SELECT city, temp_readings[1:2] AS day_1_and_2 FROM temp_data;
```

- **Explanation**: Selects readings for the first and second days as a 2D array containing both rows.

---

### 7. Updating a Specific Element in the 2D Array

```sql
UPDATE temp_data SET temp_readings[2][1] = 15 WHERE city = 'Berlin';
```

- **Explanation**: Updates the first temperature reading on the second day to `15` for the city of Berlin.
  - `temp_readings[2][1] = 15` specifically updates the element at position `[2][1]` in the 2D array.

---

### 8. Appending a Row to the 2D Array

```sql
UPDATE temp_data SET temp_readings = temp_readings || '{22.0, 25, 17}' WHERE city = 'Hamburg';
```

- **Explanation**: Appends a new row, `{22.0, 25, 17}`, to the end of the `temp_readings` array for Hamburg.
  - The `||` operator is used to concatenate arrays in PostgreSQL.
  - This adds a new "day" of temperature readings as a new row in the 2D array.

---

### 9. Explanation for Why `array_append` Doesn’t Work with 2D Arrays

```sql
-- UPDATE temp_data SET temp_readings = array_append(temp_readings, '{22.0, 25, 17}') WHERE city = 'Berlin'; -- not working on 2D arrays
```

- **Explanation**: The `array_append` function doesn’t work with 2D arrays because it’s designed for 1D arrays. Attempting to use `array_append` with a 2D array causes an error since `array_append` cannot handle multidimensional structures.
