### One-to-One Relationship Overview:

A **one-to-one** relationship in a relational database is a type of association where one record in a table corresponds to exactly one record in another table, and vice versa. In this case:
- Each **author** has exactly one associated **profile**.
- Each **profile** belongs to exactly one **author**.

This relationship is often implemented by using a **foreign key** in one table (the "dependent" table) that references the primary key of another table (the "primary" table) and includes the `UNIQUE` constraint to enforce the one-to-one relationship.

### Code Explanation:

#### 1. **Creating the Database and Switching Context:**
```sql
CREATE DATABASE authors_db;
\c authors_db;
```
- This creates a new database named `authors_db`.
- The `\c authors_db` command connects to the `authors_db` database so that all subsequent commands are executed in this context.

#### 2. **Creating the `authors` Table:**
```sql
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
```
- The `authors` table has three columns:
  - `id`: A unique identifier for each author, auto-incremented with the `SERIAL` type.
  - `name`: The author's name, which is required (`NOT NULL`).
  - `email`: The author's email, which must be unique (`UNIQUE`) and not null.

#### 3. **Creating the `author_profile` Table with a Foreign Key:**
```sql
CREATE TABLE author_profile (
    id SERIAL PRIMARY KEY,
    bio TEXT,
    website VARCHAR(100),
    author_id INT UNIQUE NOT NULL REFERENCES authors(id) ON DELETE CASCADE
);
```
- The `author_profile` table contains:
  - `id`: A unique identifier for each profile, auto-incremented.
  - `bio`: A text field for the author's biography.
  - `website`: The author's personal website.
  - `author_id`: A foreign key that references the `id` column of the `authors` table. 
    - The `UNIQUE` constraint ensures that each profile is linked to only one author.
    - The `ON DELETE CASCADE` ensures that if an author is deleted, the corresponding profile is also deleted.

#### 4. **Inserting Data into the `authors` Table:**
```sql
INSERT INTO authors (name, email)
VALUES ('Author 1', 'author1@example.com'),
       ('Author 2', 'author2@example.com');
```
- Two authors are inserted into the `authors` table, each with a name and a unique email.

#### 5. **Inserting Data into the `author_profile` Table:**
```sql
INSERT INTO author_profile (bio, website, author_id)
VALUES ('Author 1 bio', 'www.author1.com', 1),
       ('Author 2 bio', 'www.author2.com', 2);
```
- Two profiles are created, each associated with an author via the `author_id` foreign key. For example, `'Author 1 bio'` is associated with `Author 1` (i.e., `author_id = 1`).

#### 6. **Reading Data:**

**Select authors and their profiles:**
```sql
SELECT authors.name, author_profile.bio, author_profile.website, authors.email
FROM authors 
JOIN author_profile ON authors.id = author_profile.author_id;
```
- This query joins the `authors` table with the `author_profile` table on the `author_id` foreign key, displaying the author’s name, bio, website, and email in the result.

#### 7. **Deleting Data:**

**Delete an author (and their profile due to `ON DELETE CASCADE`):**
```sql
DELETE FROM authors WHERE id = 1;
```
- This deletes `Author 1` from the `authors` table. Due to the `ON DELETE CASCADE` constraint on the `author_profile` table, the corresponding profile for `Author 1` is also deleted from the `author_profile` table.

### Summary:

In this example:
- A **one-to-one relationship** is established between the `authors` and `author_profile` tables.
- Each author can have one profile, and each profile is linked to one author.
- The `UNIQUE` constraint on `author_id` in the `author_profile` table ensures that each author can have only one profile.
- The `ON DELETE CASCADE` constraint ensures that when an author is deleted, the corresponding profile is also automatically removed.