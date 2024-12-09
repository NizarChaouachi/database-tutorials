
---

### 1. Creating the Database

```sql
CREATE DATABASE students;
```

- **Explanation**: This command creates a new database named `students`.

---

### 2. Creating the `students` Table

```sql
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  student_name varchar(50),
  course_enrollments text[]
);
```

- **Explanation**:
  - Creates a table called `students`.
  - The `id` column is defined as `SERIAL PRIMARY KEY`, meaning it will automatically increment for each new row.
  - `student_name` is a `VARCHAR` column with a maximum length of 50 characters, used to store the student's name.
  - `course_enrollments` is defined as an array of `TEXT`, used to store a list of courses each student is enrolled in.

---

### 3. Inserting Data into the `students` Table

```sql
INSERT INTO students (student_name, course_enrollments) VALUES
('Alice', ARRAY['Math', 'History', 'Biology']),
('Bob', ARRAY['Science', 'English']),
('Charlie', ARRAY['Math', 'Art']);
```

- **Explanation**: Inserts three records into the `students` table with `student_name` and `course_enrollments` (an array of course names).

---

### 4. Selecting All Data from the `students` Table

```sql
SELECT * FROM students;
```

- **Explanation**: Selects and displays all columns and rows from the `students` table.

---

### 5. Selecting the First Course for Each Student

```sql
SELECT student_name, course_enrollments[1] AS first_course FROM students;
```

- **Explanation**:
  - Selects the `student_name` and the first course from `course_enrollments` for each student.
  - **Note**: Array indexing in PostgreSQL starts at 1, so `course_enrollments[1]` gives the first course.

---

### 6. Expanding Each Student’s Courses into Individual Rows

```sql
SELECT student_name, unnest(course_enrollments) FROM students;
```

- **Explanation**:
  - The `unnest` function expands each element of the `course_enrollments` array into individual rows.
  - This results in one row per course for each student.

---

### 7. Finding Students Enrolled in "Math"

```sql
SELECT student_name FROM students WHERE 'Math' = ANY(course_enrollments);
```

- **Explanation**:
  - Uses the `ANY` function to check if `'Math'` is in the `course_enrollments` array for each student.
  - Returns the names of students enrolled in "Math".

---

### 8. Updating the First Course for "Bob" to "Music"

```sql
UPDATE students SET course_enrollments[1] = 'Music' WHERE student_name = 'Bob';
```

- **Explanation**:
  - Updates `Bob`'s first course in the `course_enrollments` array to `'Music'`.
  - **Note**: This modifies only the first element in `course_enrollments`.

---

### 9. Replacing "Music" with "Python" in `course_enrollments` for "Bob"

```sql
UPDATE students
SET course_enrollments = array_replace(course_enrollments, 'Music', 'Python')
WHERE student_name = 'Bob';
```

- **Explanation**:
  - Uses `array_replace` to replace all occurrences of `'Music'` with `'Python'` in `Bob`'s `course_enrollments` array.

---

### 10. Appending "Physics" to `course_enrollments` for "Alice"

```sql
UPDATE students
SET course_enrollments = array_append(course_enrollments, 'Physics')
WHERE student_name = 'Alice';
```

- **Explanation**:
  - Uses `array_append` to add `'Physics'` to the end of `Alice`'s `course_enrollments` array.

---

### 11. Removing "English" from `course_enrollments` for "Bob"

```sql
UPDATE students
SET course_enrollments = array_remove(course_enrollments, 'English')
WHERE student_name = 'Bob';
```

- **Explanation**:
  - Uses `array_remove` to delete all occurrences of `'English'` from `Bob`'s `course_enrollments` array.

---

This sequence demonstrates how to manipulate arrays in PostgreSQL, including indexing, expanding arrays into rows, filtering, and modifying array elements