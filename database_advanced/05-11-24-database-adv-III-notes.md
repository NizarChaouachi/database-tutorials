### 1. Database and Table Creation

```sql
CREATE DATABASE phone_store_db;
\c phone_store_db
```

- Creates a new database named `phone_store_db` and connects to it.

```sql
CREATE TABLE phones (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    descrption TEXT,
    price NUMERIC(10,2),
    attributes JSONB
);
```

- Creates a table named `phones` with columns:
  - `id`: auto-incremented primary key.
  - `name`: a short name for each phone.
  - `descrption`: a detailed description.
  - `price`: a numeric field with two decimal places.
  - `attributes`: a `JSONB` column for storing additional properties in JSON format (e.g., color, storage, brand).

---

### 2. Inserting Data

```sql
INSERT INTO phones (name, descrption, price, attributes)
VALUES
    ('iPhone 13', 'The latest iPhone', 799.99, '{"color": "Silver", "storage": "128GB", "camera": "12MP", "brand": "Apple"}'),
    ...
```

- Inserts records for each phone with their `name`, `description`, `price`, and `attributes` JSON data.

---

### 3. Basic Select Queries

```sql
SELECT * FROM phones;
```

- Retrieves all rows and columns from the `phones` table.

```sql
SELECT * FROM phones WHERE attributes ->> 'brand' = 'Samsung';
```

- Filters rows where the `brand` in `attributes` is `Samsung`. The `->>` operator extracts JSON values as text, making direct string comparisons possible.

```sql
SELECT * FROM phones WHERE attributes ->> 'storage' = '128GB';
```

- Filters rows where the `storage` attribute is `128GB`.

---

### 4. Extracting JSON Data with `#>>` and `#>`

```sql
SELECT name, attributes #>> '{brand}' AS brand FROM phones;
```

- Selects each phone's `name` and `brand` as a text value. `#>>` navigates JSON data and retrieves values as text.

```sql
SELECT name, attributes #> '{brand}' AS brand FROM phones;
```

- Selects each phone's `name` and `brand` as a JSONB object. `#>` keeps values in JSON format.

```sql
SELECT name, attributes #> '{storage}' FROM phones;
```

- Retrieves the `storage` value for each phone as a JSONB object.

---

### 5. Filtering JSONB with `@>`

```sql
SELECT name, descrption FROM phones WHERE attributes @> '{"brand":"Apple"}';
```

- Retrieves phones where the `brand` attribute contains `"Apple"`. `@>` checks if `attributes` includes this JSON structure.

```sql
SELECT * FROM phones WHERE attributes @> '{"brand":"Samsung","storage":"256GB"}';
```

- Retrieves phones with both `"Samsung"` as the `brand` and `"256GB"` as the `storage`.

---

### 6. Updating JSONB Data with `jsonb_set`

```sql
UPDATE phones SET attributes = jsonb_set(attributes, '{storage}', '"256GB"') WHERE name = 'LG G8';
```

- Updates the `storage` attribute for `LG G8` to `"256GB"` using `jsonb_set`, which replaces the existing value at the specified key path.

```sql
UPDATE phones SET attributes = jsonb_set(attributes, '{screen size}', '"6 inches"') WHERE name = 'Samsung Galaxy S21';
```

- Adds a new key `screen size` with value `"6 inches"` to the `attributes` JSON for `Samsung Galaxy S21`.