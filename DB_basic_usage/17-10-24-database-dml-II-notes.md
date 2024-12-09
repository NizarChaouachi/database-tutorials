
1. **`CREATE DATABASE another_company;`**  
   - This creates a new database named `another_company`. It will be used to store data such as departments, employees, and more.

2. **`CREATE TABLE IF NOT EXISTS departments (id SERIAL PRIMARY KEY, department_name VARCHAR(50) UNIQUE NOT NULL, manager_id INT, location VARCHAR(100));`**  
   - This creates a table named `departments` if it doesn’t already exist. The fields included are:
     - `id`: Auto-incrementing integer and the primary key of the table.
     - `department_name`: A string with a maximum length of 50 characters. It is required to be unique and cannot be `NULL`.
     - `manager_id`: An integer representing the ID of the manager.
     - `location`: A string with a maximum length of 100 characters, representing the department’s location.

3. **`INSERT INTO departments (department_name,manager_id,location) VALUES ('Finance',1,'Berlin'), ('Marketing',3,'Hamburg');`**  
   - This inserts two rows into the `departments` table:
     - The first row represents the `Finance` department with a manager ID of `1`, located in `Berlin`.
     - The second row represents the `Marketing` department with a manager ID of `3`, located in `Hamburg`.

4. **`DROP TABLE IF EXISTS departments;`**  
   - This deletes the `departments` table if it exists, removing both the table structure and its data.

---

### Task:
- Run the provided SQL commands step by step.
- After each step, verify the structure or content of the table with the appropriate commands like `\d departments` or `SELECT * FROM departments;` to confirm the changes.
- You can add this to your exercise flow and take screenshots of each step to confirm the execution, just like in the previous tasks.

This example demonstrates the creation of a table with basic fields and constraints, data insertion, and the conditionally dropping of the table using `IF EXISTS`.