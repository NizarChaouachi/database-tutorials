# Database extensions

## Introduction

The database extensions are a set of extensions that allow you to interact with a database. The extensions are designed to be easy to use and provide a simple way to interact with a database.

## psql hstore extension

The psql hstore extension is a PostgreSQL extension that allows you to store key-value pairs in a single column. This extension is useful for storing data that does not fit into a traditional relational database schema.

To use the psql hstore extension, you need to install the extension using the following command:

```sql
CREATE EXTENSIONIF NOT EXISTS hstore;
```

Once the extension is installed, you can use the `hstore` data type to store key-value pairs in a single column. For example, you can create a table with an `hstore` column like this:

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    data hstore
);
```

You can then insert data into the `hstore` column like this:

```sql
INSERT INTO users (data) VALUES ('name => John, age => 30');
```

You can query the data in the `hstore` column like this:

```sql
SELECT data->'name' AS name, data->'age' AS age FROM users;
```

The psql hstore extension provides a simple way to store key-value pairs in a single column in a PostgreSQL database.

## psql pgcrypto extension

The psql pgcrypto extension is a PostgreSQL extension that provides cryptographic functions for encrypting and decrypting data. This extension is useful for storing sensitive data in a database.

To use the psql pgcrypto extension, you need to install the extension using the following command:

```sql
CREATE EXTENSIONIF NOT EXISTS pgcrypto;
```

Once the extension is installed, you can use the `pgcrypto` functions to encrypt and decrypt data. For example, you can encrypt data like this:

```sql
CREATE TABLE user_passwords (username varchar(100) PRIMARY KEY, crypttext text);

INSERT INTO tbl_sym_crypt (username, crypttext)
    VALUES ('user1', pgp_sym_encrypt('user1_password','<Password_Key>')),
       ('user2', pgp_sym_encrypt('user2_password','<Password_Key>'));

SELECT * FROM user_passwords;
```

the output will be something like this:

```sql
 username | crypttext
----------+-----------
    user1    | \x\DEADBEEF
    user2    | \x\DEADBEEF
    (2 rows)
```

You can encrypt data using the `pgp_sym_encrypt` function, which encrypts the data using a symmetric key. For example, you can encrypt data like this:

```sql
SELECT ENCRYPT ('data', 'password');
```

You can decrypt data like this:

```sql
SELECT DECRYPT ('data', 'password');
```

The psql pgcrypto extension provides a simple way to encrypt and decrypt data in a PostgreSQL database.

```sql
INSERT INTO users (username, password) VALUES ('alex', crypt('password', gen_salt('bf')));
```

this script will insert a new user into the users table with the username 'alex' and the password 'password'. The `crypt` function encrypts the password using the Blowfish algorithm, and the `gen_salt` function generates a random salt value for the encryption.

Through this script, you can check if the user with the username 'alex' and the password 'password' exists in the users table. The `crypt` function encrypts the password using the Blowfish algorithm, and the `password` column in the users table contains the encrypted password. The output of this script will be the user with the username 'alex' and the encrypted password 'password'.

## psql uuid-ossp extension

The psql uuid-ossp extension is a PostgreSQL extension that provides functions for generating UUIDs. This extension is useful for generating unique identifiers for rows in a database.

To use the psql uuid-ossp extension, you need to install the extension using the following command:

```sql
CREATE EXTENSIONIF NOT EXISTS "uuid-ossp";
```

Once the extension is installed, you can use the `uuid_generate_v4` function to generate a UUID like this:

```sql
SELECT uuid_generate_v4();
```

The `uuid_generate_v4` function generates a random UUID using version 4 of the UUID standard.

We can use the `uuid_generate_v4` function to generate a UUID for each row in a table. For example, you can create a table with a UUID column like this:

```sql
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    product_name VARCHAR(100)
    product_description TEXT
);
```

You can then insert data into the table like this:

```sql
INSERT INTO users (product_name, product_description) VALUES ('product1', 'description1');
```
