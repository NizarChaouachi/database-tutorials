### Explanation of the SQL Queries and Views


#### Step 1: Create the Database and Switch to It

```sql
CREATE DATABASE employee_db;
\c employee_db;
```
- **CREATE DATABASE employee_db:** This creates a new database named `employee_db`.
- **\c employee_db:** Switches to the `employee_db` database so you can run commands within this specific database.

#### Step 2: Create Tables `departments` and `employees`

```sql
CREATE TABLE departments(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE 
);
```
- **CREATE TABLE departments:** This creates a `departments` table with two columns: `id` and `name`.
    - `id` is an auto-incrementing primary key.
    - `name` is a string (up to 100 characters) that must be unique for each department.

```sql
CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT REFERENCES departments(id) ON DELETE SET NULL,
    salary NUMERIC(10,2) NOT NULL,
    hire_date DATE NOT NULL
);
```
- **CREATE TABLE employees:** Creates an `employees` table with columns for employee details:
    - `id`: Auto-incrementing primary key.
    - `first_name` and `last_name`: Employee names (required).
    - `department_id`: Links to the `departments` table via a foreign key. `ON DELETE SET NULL` ensures that if the referenced department is deleted, the `department_id` in the `employees` table is set to `NULL` rather than deleting the employee.
    - `salary`: The employee's salary as a numeric value.
    - `hire_date`: The date the employee was hired.

#### Step 3: Insert Data into Tables

```sql
INSERT INTO departments (name) VALUES 
('HR'),
('Finance'),
('IT'),
('Sales');
```
- This inserts four departments: HR, Finance, IT, and Sales into the `departments` table.

```sql
INSERT INTO employees (first_name, last_name, department_id, salary, hire_date) VALUES
('Alice', 'Smith', 1, 60000, '2022-01-15'),
('Bob', 'Johnson', 2, 75000, '2021-03-22'),
('Charlie', 'Williams', 3, 70000, '2023-06-01'),
('Diana', 'Jones', 1, 50000, '2022-11-30'),
('Ethan', 'Brown', 2, 80000, '2021-08-14'),
('Fiona', 'Davis', 3, 90000, '2023-05-05'),
('George', 'Garcia', 4, 65000, '2023-02-20');
```
- This inserts seven employees with their corresponding details (name, department, salary, hire date) into the `employees` table.

#### Step 4: Create Views

**1. View for Full Employee Names**

```sql
CREATE VIEW employee_full_name AS
SELECT first_name || ' ' || last_name AS full_name 
FROM employees ORDER BY first_name;
```
- **CREATE VIEW employee_full_name AS:** This creates a view called `employee_full_name` that concatenates the `first_name` and `last_name` columns into a single column `full_name` for all employees. The result is ordered by the `first_name`.

```sql
SELECT * FROM employee_full_name;
```
- Selects all entries from the `employee_full_name` view.

```sql
SELECT * FROM employee_full_name WHERE full_name LIKE 'C%';
```
- Retrieves employees whose full names start with the letter 'C'. (`%` is a wildcard in SQL).

**2. View for High Salary Employees**

```sql
CREATE VIEW high_salary_emp AS 
SELECT first_name, last_name, salary FROM employees
WHERE salary >= 80000 ORDER BY salary DESC;
```
- **CREATE VIEW high_salary_emp AS:** Creates a view named `high_salary_emp` that selects employees who have a salary greater than or equal to 80,000. The results are ordered by salary in descending order.

```sql
SELECT * FROM high_salary_emp;
```
- Selects all entries from the `high_salary_emp` view.

**3. View for Experienced Employees**

```sql
CREATE VIEW experienced_emp AS
SELECT  first_name || ' ' || last_name AS full_name, hire_date
FROM employees
WHERE CURRENT_DATE - hire_date > 700;
```
- **CREATE VIEW experienced_emp AS:** This view selects employees who have been hired for more than 700 days (about 2 years). The `CURRENT_DATE - hire_date` calculates the difference between today’s date and the hire date.

```sql
SELECT * FROM experienced_emp;
```
- Selects all employees from the `experienced_emp` view.

**4. Updating the `experienced_emp` View**

```sql
CREATE OR REPLACE VIEW experienced_emp AS
SELECT first_name || ' ' || last_name AS full_name, hire_date
FROM employees
WHERE CURRENT_DATE - hire_date > 700
ORDER BY hire_date;
```
- **CREATE OR REPLACE VIEW:** This updates the existing `experienced_emp` view to include ordering by the `hire_date`.

**5. View for Employee and Department Names**

```sql
CREATE VIEW empl_dep_view AS 
SELECT employees.first_name, employees.last_name, departments.name 
FROM employees 
JOIN departments ON employees.department_id = departments.id;
```
- **CREATE VIEW empl_dep_view AS:** This view joins the `employees` and `departments` tables to show the first and last names of employees along with the department name they belong to.

```sql
SELECT * FROM empl_dep_view;
```
- Selects all entries from the `empl_dep_view`.

```sql
SELECT * FROM empl_dep_view WHERE name = 'IT';
```
- Selects all employees from the `empl_dep_view` who belong to the "IT" department.

**6. Dropping a View**

```sql
DROP VIEW experienced_emp;
```
- **DROP VIEW experienced_emp:** This deletes the `experienced_emp` view from the database.

### What Are Views in PostgreSQL?

- **Views** are virtual tables based on the result of a query. Unlike regular tables, they do not store data physically. Instead, they store the query definition, and whenever the view is queried, PostgreSQL runs the underlying query to generate the result set.
  
### Why Do We Use Views?

1. **Simplifying Complex Queries:** Views can encapsulate complex SQL queries, making them easier to reuse without rewriting them.
2. **Security:** By granting access to a view rather than the actual tables, you can restrict what data users can see.
3. **Data Abstraction:** Views can present the data in different ways without changing the actual underlying table.
4. **Consistency:** If a frequently used query changes, you can update the view, and all applications using it will get the updated result.

### Formula for Creating a View

```sql
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column;
```

- **`view_name`:** The name of the view you want to create.
- **`SELECT column1, column2, ...`:** Defines which columns will be included in the view.
- **`FROM table_name`:** Specifies the table (or tables) from which the data will be retrieved.
- **`WHERE condition`:** Filters the rows (optional).
- **`ORDER BY column`:** Sorts the result (optional). 

This formula creates a reusable, virtual representation of a table based on the SQL query.