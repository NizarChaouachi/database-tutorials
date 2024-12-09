### DML (Data Manipulation Language) in PostgreSQL

**DML (Data Manipulation Language)** in PostgreSQL consists of the SQL commands used to manipulate the data in a database. These include `INSERT`, `UPDATE`, `DELETE`, and `SELECT` operations. Unlike DDL (Data Definition Language), which alters the structure of the database (like creating or altering tables), DML operations work on the data stored in those structures.

### DML Operations Explained:

1. **INSERT**: Adds new records to a table.
2. **SELECT**: Retrieves data from one or more tables.
3. **UPDATE**: Modifies existing data in a table.
4. **DELETE**: Removes rows from a table.
5. **TRUNCATE**: Removes all rows from a table but keeps the table structure.

### Code Explanation 

---

#### **Database and Table Creation**

```sql
CREATE DATABASE onlie_shop_db ;
```

- **Creates a new database** named `onlie_shop_db`.

```sql
\c onlie_shop_db
```

- **Connects to the newly created database**.

```sql
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15) DEFAULT 'Unkown',
    age INT CHECK(age >= 18 AND age <= 100),
    registration_date DATE DEFAULT CURRENT_DATE
);
```

- **Creates a `Customer` table**:
  - `customer_id`: Primary key (auto-incremented).
  - `first_name`, `last_name`: Cannot be `NULL`.
  - `email`: Must be unique (no two customers can have the same email).
  - `phone_number`: Default is `'Unknown'` if no value is provided.
  - `age`: Must be between 18 and 100 (constraint).
  - `registration_date`: Defaults to the current date if not provided.

```sql
\d Customer
```

- **Displays the structure of the `Customer` table**.

---

#### **INSERT (Create Operation)**

```sql
INSERT INTO Customer VALUES (1, 'nizar', 'nizar', 'nizar@email.com', '145632879', 28, DEFAULT);
```

- Inserts a new customer with specified values.
  - `customer_id`: Manually set to 1.
  - `DEFAULT` for `registration_date` uses the current date.

```sql
INSERT INTO Customer (first_name, last_name, age, email, registration_date)
VALUES ('James', 'jobs', 45, 'james@email.com', '2023-05-31');
```

- Inserts another customer, specifying only certain columns. 
  - The default values are used for `customer_id` and `phone_number`.

```sql
INSERT INTO Customer (first_name, last_name, email, phone_number, age)
VALUES 
('John', 'Doe', 'john.doe@example.com', '555-1234', 30),
...
('Anna', 'Adams', 'anna.adams@example.com', '555-2020', 58);
```

- Inserts multiple rows with specified values.
  - If a `phone_number` is `NULL`, the default value `'Unknown'` will be used.

---

#### **SELECT (Read Operation)**

```sql
SELECT * FROM Customer;
```

- Retrieves all columns for all rows from the `Customer` table.

```sql
SELECT first_name, last_name, email, registration_date FROM Customer;
```

- Retrieves specific columns (`first_name`, `last_name`, `email`, `registration_date`) for all rows.

```sql
SELECT first_name || '-' || last_name AS full_name, email FROM Customer;
```

- Concatenates `first_name` and `last_name` with `'-'` in between and displays it as `full_name` with the email.

```sql
SELECT first_name, CURRENT_DATE - registration_date AS duration FROM Customer;
```

- Calculates the difference between the current date and `registration_date` for each customer (how long they have been registered).

```sql
SELECT * FROM Customer WHERE first_name = 'Charles';
```

- Retrieves rows where `first_name` is `'Charles'`.

```sql
SELECT first_name, email, phone_number FROM Customer WHERE customer_id > 10 AND age < 35;
```

- Retrieves `first_name`, `email`, and `phone_number` for customers with `customer_id` greater than 10 and age less than 35.

```sql
SELECT first_name, email, phone_number FROM Customer WHERE first_name = 'nizar' OR last_name = 'Brown';
```

- Retrieves customers where `first_name` is `'nizar'` OR `last_name` is `'Brown'`.

```sql
SELECT * FROM Customer WHERE age BETWEEN 20 AND 40;
```

- Retrieves customers whose age is between 20 and 40 (inclusive).

```sql
SELECT * FROM Customer WHERE customer_id IN (1, 5, 6, 14);
```

- Retrieves customers with specific `customer_id` values.

```sql
SELECT * FROM Customer WHERE phone_number IS NULL;
```

- Retrieves rows where `phone_number` is `NULL`.

```sql
SELECT * FROM Customer WHERE CUSTOMER_id NOT IN (1, 3, 15);
```

- Retrieves customers whose `customer_id` is not in the list `(1, 3, 15)`.

---

#### **UPDATE (Update Operation)**

```sql
UPDATE Customer SET last_name = 'python' WHERE first_name = 'nizar';
```

- Updates the `last_name` to `'python'` where the `first_name` is `'nizar'`.

```sql
UPDATE Customer SET phone_number = 1256397 WHERE phone_number IS NULL OR phone_number = 'Unkown';
```

- Updates the `phone_number` for customers who have `NULL` or `'Unknown'` values for `phone_number`.

```sql
UPDATE Customer SET last_name = 'Loyal Customer' WHERE customer_id < 10;
```

- Updates the `last_name` to `'Loyal Customer'` for all customers with `customer_id` less than 10.

```sql
UPDATE Customer SET first_name = first_name || '-JR' WHERE age < 26;
```

- Appends `'-JR'` to the `first_name` for all customers younger than 26.

---

#### **DELETE (Delete Operation)**

```sql
DELETE FROM Customer WHERE first_name = 'nizar';
```

- Deletes rows where the `first_name` is `'nizar'`.

```sql
DELETE FROM Customer WHERE CURRENT_DATE - registration_date > 365;
```

- Deletes rows where the customer has been registered for more than 365 days.

```sql
DELETE FROM Customer WHERE age BETWEEN 20 AND 45;
```

- Deletes rows where the customer's age is between 20 and 45.

---

#### **TRUNCATE**

```sql
TRUNCATE Customer;
```

- **Removes all rows** from the `Customer` table but **keeps the table structure**.

---

### Formula for Each CRUD Operation:

1. **INSERT**: 
   ```sql
   INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
   ```

2. **SELECT**:
   ```sql
   SELECT column1, column2, ... FROM table_name WHERE condition;
   ```

3. **UPDATE**:
   ```sql
   UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
   ```

4. **DELETE**:
   ```sql
   DELETE FROM table_name WHERE condition;
   ```

5. **TRUNCATE**:
   ```sql
   TRUNCATE table_name;
   ``` 

