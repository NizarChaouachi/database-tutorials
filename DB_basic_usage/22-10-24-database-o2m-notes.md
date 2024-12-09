### One-to-Many Relationship Overview:

In relational databases, a **one-to-many** relationship is a type of association between two tables where one record in a table (the "one" side) can be related to many records in another table (the "many" side). For example, in this scenario:
- An **author** can write multiple **books** (one-to-many relationship between the `authors` table and the `books` table).
- Each **book** is written by a single **author**, linking them by a foreign key.

This relationship is represented by a **foreign key** in the table on the "many" side (in this case, `books`) that references the primary key of the table on the "one" side (in this case, `authors`).

### Code Explanation:

#### 1. **Creating the Database and Switching Context:**
```sql
CREATE DATABASE books_db;
\c books_db;
```
- This creates a new database named `books_db`.
- The `\c books_db` command connects to the `books_db` database so that all subsequent commands are executed in this context.

#### 2. **Creating the `authors` Table:**
```sql
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
```
- The `authors` table contains three columns: 
  - `id`: A unique identifier for each author, auto-incremented by using the `SERIAL` type.
  - `name`: The name of the author, which cannot be null.
  - `email`: The author's email, which must be unique and cannot be null.

#### 3. **Creating the `books` Table with a Foreign Key:**
```sql
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publication_year INT,
    author_id INT REFERENCES authors(id) ON DELETE CASCADE
);
```
- The `books` table has the following columns:
  - `id`: A unique identifier for each book, auto-incremented by using the `SERIAL` type.
  - `title`: The title of the book, which cannot be null.
  - `publication_year`: The year the book was published, stored as an integer.
  - `author_id`: A foreign key that references the `id` column in the `authors` table. The `ON DELETE CASCADE` constraint ensures that if an author is deleted, all related books will be deleted as well.

#### 4. **Inserting Data into `authors` Table:**
```sql
INSERT INTO authors (name, email)
VALUES ('Author 1', 'author1@example.com'),
       ('Author 2', 'author2@example.com');
```
- Two authors are inserted into the `authors` table, each with a name and a unique email.

#### 5. **Inserting Data into `books` Table:**
```sql
INSERT INTO books (title, publication_year, author_id)
VALUES ('Book 1', 2021, 1),
       ('Book 2', 2022, 1),
       ('Book 3', 2020, 2),
       ('Book 4', 2024, 2);
```
- Four books are inserted into the `books` table, with each book linked to an author through the `author_id` foreign key. For example, `'Book 1'` is associated with `Author 1` (`author_id = 1`).

#### 6. **Reading Data:**

**1. Select all books:**
```sql
SELECT * FROM books;
```
- Retrieves all columns and rows from the `books` table.

**2. Select specific columns for books by `author_id=1`:**
```sql
SELECT title, publication_year FROM books WHERE author_id=1;
```
- Retrieves the `title` and `publication_year` of books written by `Author 1` (`author_id=1`).

**3. Join `authors` and `books` to show author names and their books:**
```sql
SELECT authors.name, books.title, books.publication_year 
FROM books 
JOIN authors ON authors.id = books.author_id;
```
- Uses a `JOIN` to combine `authors` and `books` tables, displaying the author's name along with the titles and publication years of their books.

#### 7. **Updating Data:**

**Update book titles for `Author 1`:**
```sql
UPDATE books SET title = title || 'by author 1' WHERE author_id=1;
```
- This updates the titles of all books written by `Author 1` by appending the text `"by author 1"` to the existing title.

#### 8. **Deleting Data:**

**Delete a specific book:**
```sql
DELETE FROM books WHERE id = 4;
```
- Deletes the book with `id = 4` (i.e., `'Book 4'`).

**Delete an author and related books (cascade delete):**
```sql
DELETE FROM authors WHERE id=1;
```
- Deletes `Author 1` and, due to the `ON DELETE CASCADE` constraint, all books associated with `Author 1` will also be deleted.

#### 9. **Modifying Foreign Key Constraints:**

**Drop and re-add the foreign key:**
```sql
ALTER TABLE books DROP CONSTRAINT books_author_id_fkey;
ALTER TABLE books ADD CONSTRAINT books_author_id_fkey FOREIGN KEY (author_id) 
REFERENCES authors(id);
```
- Drops the existing foreign key constraint on the `books` table and then re-adds it, linking `author_id` in the `books` table to the `id` column in the `authors` table.

#### 10. **Truncating Data with Cascade:**

**Truncate the `authors` table with cascading delete:**
```sql
TRUNCATE authors CASCADE;
```
- Deletes all rows from the `authors` table and, because of the `CASCADE` option, all rows in the `books` table that reference those authors will also be deleted.

### CRUD Formulas:

1. **Create (INSERT):**
   - Insert new records into a table.
   ```sql
   INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
   ```

2. **Read (SELECT):**
   - Query data from one or more tables.
   ```sql
   SELECT column1, column2 FROM table_name WHERE condition;
   ```

3. **Update (UPDATE):**
   - Modify existing records in a table.
   ```sql
   UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;
   ```

4. **Delete (DELETE):**
   - Remove records from a table.
   ```sql
   DELETE FROM table_name WHERE condition;
   ```