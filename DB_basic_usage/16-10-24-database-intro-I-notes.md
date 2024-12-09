
### 1. **Create a Database**

```sql
CREATE DATABASE my_first_db;
```

#### Explanation:
- `CREATE DATABASE`: This command creates a new database in PostgreSQL.
- `my_first_db`: This is the name of the database being created. You can replace it with any name you'd like for your database.

#### Formula:
```sql
CREATE DATABASE database_name;
```

- `database_name`: The name you want to assign to your new database.

---

### 2. **Connect to the Database**

```sql
\c my_first_db
```

#### Explanation:
- `\c`: This is a PostgreSQL **psql** (command-line tool) meta-command used to connect to a specific database.
- `my_first_db`: The name of the database you want to connect to. After this command, you will be connected to `my_first_db`, and all subsequent commands will be executed within this database.

#### Formula:
```bash
\c database_name
```

- `database_name`: The name of the database you wish to connect to.

---

### 3. **List All Databases**

```sql
\l
```

#### Explanation:
- `\l`: This is another **psql** meta-command that lists all databases in the PostgreSQL server. It shows important information like the database name, owner, encoding, and more.

#### Formula:
```bash
\l
```

- No parameters are required. This command will list all the databases available.

---

### 4. **List All Tables in the Connected Database**

```sql
\dt
```

#### Explanation:
- `\dt`: This **psql** meta-command lists all the tables in the currently connected database. It displays a table with the names of the tables, their schema, and type (e.g., table, view).
  
If no tables have been created, this command will return an empty list.

#### Formula:
```bash
\dt
```

- No parameters are required. It will list all tables in the current database.

---

### 5. **Drop (Delete) a Database**

```sql
DROP DATABASE my_first_db;
```

#### Explanation:
- `DROP DATABASE`: This command permanently deletes an existing database, including all tables and data within it.
- `my_first_db`: The name of the database you want to delete. After this command, the `my_first_db` database will no longer exist.

> **Important**: Be careful when using the `DROP DATABASE` command, as it cannot be undone.

#### Formula:
```sql
DROP DATABASE database_name;
```

- `database_name`: The name of the database you want to drop.

---

### Putting It All Together

```sql
CREATE DATABASE my_first_db;  -- Creates a new database named my_first_db
\c my_first_db                -- Connects to the my_first_db database
\l                            -- Lists all databases in the PostgreSQL instance
\dt                           -- Lists all tables in the connected database (my_first_db in this case)
DROP DATABASE my_first_db;     -- Deletes the my_first_db database
```

This series of commands creates a new database, connects to it, lists the databases and tables, and finally deletes the database. Each command provides essential functionality when managing databases in PostgreSQL.