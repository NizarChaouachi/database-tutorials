
### 1. **Creating the Database and Tables**
```sql
CREATE DATABASE online_shop ;

\c online_shop 
```
- **`CREATE DATABASE online_shop`** creates a new database called `online_shop`.
- **`\c online_shop`** connects to the `online_shop` database after it's created.

```sql
CREATE TABLE customers (
    ID SERIAL PRIMARY KEY,
    username VARCHAR(50),
    balance DECIMAL(10,2) CHECK(BALANCE>=0)
);
```
- Creates the `customers` table with columns: `ID`, `username`, and `balance`.
  - **`ID SERIAL PRIMARY KEY`** auto-generates a unique ID for each customer.
  - **`balance DECIMAL(10,2)`** stores the customer's balance with two decimal places.
  - **`CHECK(BALANCE>=0)`** ensures that the balance cannot be negative.

```sql
CREATE TABLE products (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT CHECK(stock > 0)
);
```
- Creates the `products` table with columns: `ID`, `name`, `price`, and `stock`.
  - **`stock INT CHECK(stock > 0)`** ensures there is at least 1 product in stock.

```sql
CREATE TABLE store_owner (
    id SERIAL PRIMARY KEY,
    owner_name VARCHAR(50),
    balance DECIMAL(10,2)
);
```
- Creates the `store_owner` table with columns: `id`, `owner_name`, and `balance`.
  - **`balance DECIMAL(10,2)`** stores the balance of the store owner.

### 2. **Inserting Data into Tables**
```sql
INSERT INTO customers (username, balance) VALUES
('Alice', 100.00),
('Bob', 200.00),
('Charlie', 150.00);
```
- Inserts three records into the `customers` table with the `username` and `balance` of each customer.

```sql
INSERT INTO products (name, price, stock) VALUES
('Laptop', 300.00, 10),
('Smartphone', 150.00, 5),
('Headphones', 50.00, 20);
```
- Inserts records into the `products` table, representing products available in the store.

```sql
INSERT INTO store_owner (owner_name, balance) VALUES
('John Smith', 1000.00),
('Emma Brown', 1500.00);
```
- Inserts two records into the `store_owner` table, representing the store owners with their initial balances.

### 3. **Transactions with COMMIT and ROLLBACK**

#### **COMMIT Example**
```sql
BEGIN;

UPDATE products
SET stock = stock - 1
WHERE name = 'Smartphone';

UPDATE customers
SET balance = balance - 150
WHERE username = 'Bob';

COMMIT;
```
- **`BEGIN`** starts a new transaction. All operations that follow until `COMMIT` will be part of the transaction.
- **`UPDATE`** commands reduce the stock of the product and deduct the balance of the customer (Bob).
- **`COMMIT`** saves all the changes made in the transaction to the database. After `COMMIT`, the changes are permanent.

#### **ROLLBACK Example**
```sql
BEGIN;

UPDATE products
SET stock = stock - 1
WHERE name = 'Laptop';

UPDATE customers
SET balance = balance - 300
WHERE username = 'Alice';

ROLLBACK;
```
- **`ROLLBACK`** undoes all changes made during the current transaction, meaning that the stock of the `Laptop` and Alice’s balance are not affected.
- The changes are discarded as if they were never made.

### 4. **Using Savepoints**

#### **SAVEPOINT Example**
```sql
BEGIN;

UPDATE PRODUCTS SET stock = stock - 1 WHERE name = 'Smartphone';

UPDATE customers SET balance = balance - (SELECT price FROM products WHERE name = 'Smartphone') WHERE username = 'Alice';

SAVEPOINT AfterPhonePurchase;

UPDATE PRODUCTS SET stock = stock - 1 WHERE name = 'Laptop';

UPDATE customers SET balance = balance - (SELECT price FROM products WHERE name = 'Laptop') WHERE username = 'Alice';

ROLLBACK TO SAVEPOINT AfterPhonePurchase;

UPDATE PRODUCTS SET stock = stock - 1 WHERE name = 'Headphones';

UPDATE customers SET balance = balance - (SELECT price FROM products WHERE name = 'Headphones') WHERE username = 'Alice';

COMMIT;
```
- **`SAVEPOINT`** sets a point within the transaction to which you can later roll back if needed. Here, after updating the stock and balance for the smartphone, a savepoint is created (`AfterPhonePurchase`).
- **`ROLLBACK TO SAVEPOINT`** undoes all actions made after the `SAVEPOINT`. The update to the laptop is rolled back, but changes made before the savepoint (Smartphone) remain.
- **`COMMIT`** finalizes the transaction, making all changes permanent, including those before the savepoint.

### ACID Properties of Databases:
The ACID properties ensure that database transactions are processed reliably.

1. **Atomicity**: 
   - A transaction is a single unit of work, either fully completed or fully rolled back. If part of a transaction fails, all changes are discarded.
   - In the code above, `COMMIT` ensures that all operations within a transaction are saved, and `ROLLBACK` ensures no partial updates are kept if an error occurs.

2. **Consistency**: 
   - A transaction must transition the database from one valid state to another. Constraints like `CHECK(BALANCE>=0)` ensure that the database maintains integrity.

3. **Isolation**: 
   - Transactions are isolated from each other, so one transaction’s work is not visible to others until it is committed. If a second transaction begins during the first, it does not see the uncommitted changes until the first is committed.
   - In this case, no other transactions would see the updates to the `products` or `customers` tables until `COMMIT` is executed.

4. **Durability**: 
   - Once a transaction has been committed, its changes are permanent and survive system crashes or failures.
   - After `COMMIT`, the updates to stock and balance are guaranteed to be saved, even if the system crashes immediately afterward.

### **COMMIT, ROLLBACK, and SAVEPOINT**:
- **`COMMIT`**: Finalizes the transaction, making all changes permanent.
- **`ROLLBACK`**: Reverts all changes made during the current transaction.
- **`SAVEPOINT`**: Sets a point within the transaction to which you can later roll back, allowing partial rollbacks.

This approach helps ensure the integrity of data and allows for flexible error handling, giving you more control over how changes are made to the database.