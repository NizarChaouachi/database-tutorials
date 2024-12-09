

### 1. Creating and Connecting to a Database

```sql
CREATE DATABASE university_db;
\c university_db
```

- **`CREATE DATABASE university_db;`**: This creates a new PostgreSQL database called `university_db`. Each database is a separate container for storing data.
- **`\c university_db;`**: This command is used to connect to the `university_db` database. From this point, any operations (e.g., table creation, data insertion) are applied to this database.

**Formula:**
```sql
CREATE DATABASE database_name;
\c database_name
```

### 2. Creating the `students` Table with Constraints

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18 and age <= 120),
    enrollment_date DATE CHECK (enrollment_date >= '2020-01-01'),
    gpa DECIMAL(3,2) DEFAULT 0.00,
    phone_number CHAR(10),
    gender CHAR(1) CHECK (gender IN ('M','F','O')),
    is_member BOOLEAN DEFAULT True
);
```

- **`CREATE TABLE students (...);`**: This creates a table named `students` with several columns. Each column has a data type, constraints, and default values.
    - **`student_id SERIAL PRIMARY KEY`**: A unique identifier for each student. The `SERIAL` type auto-increments, and `PRIMARY KEY` ensures each value is unique.
    - **`first_name VARCHAR(50) NOT NULL`**: The student's first name, with a maximum of 50 characters. The `NOT NULL` constraint ensures a value must be provided.
    - **`last_name VARCHAR(50) NOT NULL`**: The student's last name, also required.
    - **`email VARCHAR(100) UNIQUE`**: A unique email address (up to 100 characters). The `UNIQUE` constraint prevents duplicate emails.
    - **`age INT CHECK (age >= 18 AND age <= 120)`**: The age of the student must be between 18 and 120. The `CHECK` constraint ensures this.
    - **`enrollment_date DATE CHECK (enrollment_date >= '2020-01-01')`**: The enrollment date must be on or after January 1, 2020.
    - **`gpa DECIMAL(3,2) DEFAULT 0.00`**: The student's GPA, with up to 3 digits (2 after the decimal point). If not provided, it defaults to `0.00`.
    - **`phone_number CHAR(10)`**: The phone number, which must be exactly 10 characters long.
    - **`gender CHAR(1) CHECK (gender IN ('M', 'F', 'O'))`**: Gender must be one of `M` (male), `F` (female), or `O` (other). The `CHECK` constraint enforces this.
    - **`is_member BOOLEAN DEFAULT True`**: Whether the student is a member. Defaults to `True`.

**Formula:**
```sql
CREATE TABLE table_name (
    column_name data_type CONSTRAINT,
    ...
);
```

### 3. Inserting Data and Violating Constraints

```sql
INSERT INTO students (first_name, last_name, email, enrollment_date, age, gpa, phone_number, gender)
VALUES ('John', 'Doe', 'johndoe@email.com', '2023-01-01', 25, 2.55, '14569874', 'M');
```

- **`INSERT INTO students (...) VALUES (...);`**: This inserts a new student into the `students` table. The values correspond to the columns defined earlier. This works as long as all constraints (e.g., `NOT NULL`, `CHECK`, `UNIQUE`) are met.

**Examples of Violating Constraints:**
- **Missing `last_name`**:
   - The second `INSERT` statement will fail because `last_name` is `NOT NULL`.
- **Duplicate `email`**:
   - The third `INSERT` fails because the `email` value `'johndoe@email.com'` already exists (due to the `UNIQUE` constraint).
- **Invalid `age`**:
   - The fourth `INSERT` fails because the `age` is `12`, which violates the `CHECK` constraint (age must be between 18 and 120).

**Formula:**
```sql
INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
```

### 4. Altering the Table and Adding Constraints

#### a) Adding a Unique Constraint
```sql
ALTER TABLE students 
ADD CONSTRAINT unique_phone_number UNIQUE (phone_number);
```

- **`ALTER TABLE students ADD CONSTRAINT unique_phone_number UNIQUE (phone_number);`**: This adds a `UNIQUE` constraint to the `phone_number` column, ensuring that no two students can have the same phone number.

#### b) Dropping a Constraint
```sql
ALTER TABLE students 
DROP CONSTRAINT students_age_check;
```

- **`ALTER TABLE students DROP CONSTRAINT students_age_check;`**: This removes the `CHECK` constraint that was previously placed on the `age` column.

#### c) Modifying Columns

- **Set `age` as `NOT NULL`**:
    ```sql
    ALTER TABLE students 
    ALTER COLUMN age SET NOT NULL;
    ```

    This ensures that the `age` column cannot have null values.

- **Drop `NOT NULL` from `last_name`**:
    ```sql
    ALTER TABLE students
    ALTER COLUMN last_name DROP NOT NULL;
    ```

    This removes the `NOT NULL` constraint from `last_name`, allowing it to accept null values.

- **Add a `CHECK` constraint**:
    ```sql
    ALTER TABLE students
    ADD CONSTRAINT not_admin_student CHECK (first_name != 'Admin');
    ```

    This adds a `CHECK` constraint ensuring that no student's first name can be `Admin`.

- **Set a new default for `gpa`**:
    ```sql
    ALTER TABLE students
    ALTER COLUMN gpa SET DEFAULT 2.00;
    ```

    This changes the default value for `gpa` to `2.00` if no value is provided during insertion.

**Formula:**
```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column);
```
```sql
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
```
```sql
ALTER TABLE table_name
ALTER COLUMN column_name [SET | DROP] CONSTRAINT;
```

### 5. Full Re-creation of the `students` Table

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18 and age <= 120),
    enrollment_date DATE CHECK (enrollment_date >= '2020-01-01'),
    gpa DECIMAL(3,2) DEFAULT 0.00,
    phone_number CHAR(10) UNIQUE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    is_member BOOLEAN DEFAULT True
);
```

This final section shows the full table creation script for the `students` table, incorporating all the constraints added through the `ALTER TABLE` commands.

---

