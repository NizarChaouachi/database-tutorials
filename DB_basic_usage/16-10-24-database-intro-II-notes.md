

### 1. **Create a New Database**

```sql
CREATE DATABASE employees_db;
```

- **Explanation**: Creates a new database named `employees_db`.
- **Formula**:
  ```sql
  CREATE DATABASE database_name;
  ```

---

### 2. **Connect to the Database**

```sql
\c employees_db
```

- **Explanation**: Connects to the `employees_db` database. All subsequent commands will be executed in this database.
- **Formula**:
  ```bash
  \c database_name
  ```

---

### 3. **Create a New Schema**

```sql
CREATE SCHEMA company_schema;
```

- **Explanation**: Creates a new schema called `company_schema` inside the `employees_db` database.
- **Formula**:
  ```sql
  CREATE SCHEMA schema_name;
  ```

---

### 4. **List All Schemas**

```sql
\dn
```

- **Explanation**: Lists all available schemas in the current database.
- **Formula**:
  ```bash
  \dn
  ```

---

### 5. **Create a Table within a Schema**

```sql
CREATE TABLE company_schema.employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE,
    salary DECIMAL(10,2),
    office_nr INT,
    email VARCHAR(70),
    is_full_time BOOLEAN,
    bio TEXT
);
```

- **Explanation**: Creates a table `employees` within the `company_schema` schema, defining various columns with different data types.
- **Formula**:
  ```sql
  CREATE TABLE schema_name.table_name (
      column1 datatype constraints,
      column2 datatype constraints,
      ...
  );
  ```

---

### 6. **Describe a Table**

```sql
\d company_schema.employees
```

- **Explanation**: Shows the structure of the `employees` table inside the `company_schema` schema.
- **Formula**:
  ```bash
  \d schema_name.table_name
  ```

---

### 7. **Add a New Column to the Table**

```sql
ALTER TABLE company_schema.employees 
ADD COLUMN bonus INT;
```

- **Explanation**: Adds a new column called `bonus` of type `INT` to the `employees` table.
- **Formula**:
  ```sql
  ALTER TABLE schema_name.table_name
  ADD COLUMN column_name datatype;
  ```

---

### 8. **Rename a Table**

```sql
ALTER TABLE company_schema.employees 
RENAME TO staff;
```

- **Explanation**: Renames the table `employees` to `staff`.
- **Formula**:
  ```sql
  ALTER TABLE schema_name.old_table_name
  RENAME TO new_table_name;
  ```

---

### 9. **Rename a Column**

```sql
ALTER TABLE company_schema.staff 
RENAME COLUMN office_nr TO office_number;
```

- **Explanation**: Renames the column `office_nr` to `office_number` in the `staff` table.
- **Formula**:
  ```sql
  ALTER TABLE schema_name.table_name
  RENAME COLUMN old_column_name TO new_column_name;
  ```

---

### 10. **Change the Data Type of a Column**

```sql
ALTER TABLE company_schema.staff 
ALTER COLUMN office_number TYPE VARCHAR(4);
```

- **Explanation**: Changes the data type of the column `office_number` to `VARCHAR(4)`.
- **Formula**:
  ```sql
  ALTER TABLE schema_name.table_name
  ALTER COLUMN column_name TYPE new_data_type;
  ```

---

### 11. **Drop (Delete) a Column**

```sql
ALTER TABLE company_schema.staff 
DROP COLUMN bio;
```

- **Explanation**: Deletes the `bio` column from the `staff` table.
- **Formula**:
  ```sql
  ALTER TABLE schema_name.table_name
  DROP COLUMN column_name;
  ```

---

### 12. **Truncate (Empty) a Table**

```sql
TRUNCATE company_schema.staff;
```

- **Explanation**: Removes all rows from the `staff` table but keeps the table structure intact.
- **Formula**:
  ```sql
  TRUNCATE schema_name.table_name;
  ```

---

### 13. **Drop (Delete) a Table**

```sql
DROP TABLE company_schema.staff;
```

- **Explanation**: Deletes the `staff` table from the `company_schema` schema.
- **Formula**:
  ```sql
  DROP TABLE schema_name.table_name;
  ```

---

### 14. **Drop (Delete) a Schema**

```sql
DROP SCHEMA company_schema;
```

- **Explanation**: Deletes the entire `company_schema` schema, along with all objects within it (if any).
- **Formula**:
  ```sql
  DROP SCHEMA schema_name;
  ```

- **Note**: If the schema contains objects, you need to add `CASCADE` to delete all dependent objects:
  ```sql
  DROP SCHEMA schema_name CASCADE;
  ```

---

### 15. **Reconnect to the Default `postgres` Database**

```sql
\c postgres
```

- **Explanation**: Reconnects to the default `postgres` database.
- **Formula**:
  ```bash
  \c postgres
  ```

---

### 16. **Drop (Delete) the Database**

```sql
DROP DATABASE employees_db;
```

- **Explanation**: Deletes the entire `employees_db` database.
- **Formula**:
  ```sql
  DROP DATABASE database_name;
  ```

---

### 17. **Run an SQL File**

```bash
\i path/to/file.sql
```

- **Explanation**: Executes an external SQL file (`file.sql`) containing SQL commands.
- **Formula**:
  ```bash
  \i path/to/file.sql
  ```

- **Note**: You need to provide the absolute or relative path to the file.

