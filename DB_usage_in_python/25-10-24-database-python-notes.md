
### Imports and Environment Setup

```python
import psycopg2
from PIL import Image
from io import BytesIO
import time 
import os
from dotenv import load_dotenv
```

- `psycopg2`: This module connects Python to PostgreSQL databases.
- `PIL.Image`: The `Image` module from the Python Imaging Library (PIL) (or `Pillow`, its more recent fork) is used to handle image processing.
- `io.BytesIO`: This in-memory binary stream is used for reading and writing binary data, enabling conversion between images and bytes.
- `time`: This module is used to add delays in execution.
- `os`: Handles interactions with the operating system, like accessing environment variables.
- `dotenv.load_dotenv()`: Loads environment variables from a `.env` file, making database credentials easily configurable.

```python
load_dotenv()
DATABASE = os.getenv('database')
USERNAME = os.getenv('user')
PASSWORD = os.getenv('password')
```

- `load_dotenv()`: Loads environment variables from the `.env` file into the application.
- `DATABASE`, `USERNAME`, `PASSWORD`: These environment variables store database connection details (`database`, `user`, and `password`), making them configurable.

### Database Configuration and Connection Classes

#### `DatabaseConfig` Class
```python
class DatabaseConfig:
    def __init__(self, database, user, password, host, port):
        self.database = database
        self.user = user
        self.password = password
        self.host = host
        self.port = port
```

- `DatabaseConfig`: Stores database connection parameters.
- `__init__`: Initializes the connection details such as database name, username, password, host, and port.

#### `DatabaseConnection` Class
```python
class DatabaseConnection:
    def __init__(self, config: DatabaseConfig) -> None:
        self.config = config
        self.conn = None
        self.cursor = None
```

- `DatabaseConnection`: Manages the database connection and cursor for executing SQL queries.
- `__init__`: Initializes the `config`, and sets `conn` (connection) and `cursor` (cursor object for SQL operations) to `None`.

```python
    def connect(self):
        self.conn = psycopg2.connect(
            database=self.config.database,
            user=self.config.user,
            password=self.config.password,
            host=self.config.host,
            port=self.config.port,
        )
        self.cursor = self.conn.cursor()
```

- `connect()`: Establishes a connection to the database using the parameters from `DatabaseConfig`, and initializes the cursor for executing SQL commands.

```python
    def close(self):
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()
```

- `close()`: Closes the cursor and connection if they are open, releasing database resources.

### Image Storage in the Database

#### `ImageStorage` Class
```python
class ImageStorage:
    def __init__(self, db_connection: DatabaseConnection):
        self.db_connection = db_connection
```

- `ImageStorage`: Manages image storage in the database.
- `__init__`: Initializes with a `DatabaseConnection` instance, allowing database operations on image data.

```python
    def create_table(self):
        self.db_connection.cursor.execute(
        """
            CREATE TABLE IF NOT EXISTS my_album (
                id serial PRIMARY KEY,
                image_data bytea
            );
        """
        )
        self.db_connection.conn.commit()
```

- `create_table()`: Creates a table named `my_album` if it doesn’t exist, with columns for `id` (auto-incremented primary key) and `image_data` (binary data for storing images).

```python
    def save_image(self, image_binary: bytes):
        self.db_connection.cursor.execute(
            "INSERT INTO my_album (image_data) VALUES (%s)",
                    (psycopg2.Binary(image_binary),),
        )
        self.db_connection.conn.commit()
```

- `save_image()`: Inserts a new image into the `my_album` table. The image is stored as a binary object using `psycopg2.Binary()` to convert `image_binary` into a format compatible with PostgreSQL.

```python
    def fetch_image(self, image_id):
        self.db_connection.cursor.execute(
            f"SELECT image_data FROM my_album WHERE id={image_id};"
        )
        image_binary = self.db_connection.cursor.fetchone()[0]
        return image_binary
```

- `fetch_image()`: Retrieves an image from the database by `image_id`, fetches the `image_data` field, and returns the binary data of the image.

### Image Handling Functions

#### `ImageHandler` Class
```python
class ImageHandler:
    
    @staticmethod
    def read_image(file_path):
        with open(file_path, 'rb') as image_file:
            return image_file.read()
```

- `read_image()`: Reads an image file as binary data. Using `rb` (read-binary mode) makes it suitable for database storage.

```python
    @staticmethod
    def display_image(image_binary):
        image = Image.open(BytesIO(image_binary))
        image.show()
```

- `display_image()`: Converts binary data back into an image using `BytesIO` and opens it with `PIL.Image`’s `show()` to display.

### Main Application Logic

#### `ImageApp` Class
```python
class ImageApp:
    def __init__(self, db_connection: DatabaseConnection):
        self.db_connection = db_connection
        self.image_storage = ImageStorage(self.db_connection)
```

- `ImageApp`: Main application class that runs the image storage program.
- `__init__`: Initializes with a `DatabaseConnection` and an `ImageStorage` instance.

```python
    def run(self, image_path):
        image_binary = ImageHandler.read_image(image_path)
        self.image_storage.create_table()
        print('table created')
        time.sleep(0.5)
```

- `run()`: Handles the core steps of the application. It first reads an image from the given `image_path`, creates the `my_album` table, and confirms table creation with a short delay (`sleep`).

```python
        self.image_storage.save_image(image_binary)
        print('image saved')
        time.sleep(0.5)
```

- Saves the image binary data into the `my_album` table and prints a confirmation with a delay.

```python
        fechted_image = self.image_storage.fetch_image(3)  # retreiving the first image with id 1
        print('image fetched')
        ImageHandler.display_image(fechted_image)
```

- Fetches an image with `id=3` (example image) from the table and displays it.

### Running the Script

```python
if __name__ == '__main__':
    db_params = DatabaseConfig(
        database=DATABASE,
        user=USERNAME,
        password=PASSWORD,
        host='localhost',
        port=5432
    )
    db_connection = DatabaseConnection(db_params)
    db_connection.connect()
    app = ImageApp(db_connection)
    app.run('src/python.jpeg')
    db_connection.close()
```

1. Creates a `DatabaseConfig` instance with parameters from environment variables.
2. Initializes and connects a `DatabaseConnection`.
3. Instantiates the main application (`ImageApp`) with the connected database.
4. Calls `run()` on the app, performing all image storage and retrieval operations with `'src/python.jpeg'`.
5. Closes the database connection at the end. 

This sequence ensures a clean connection lifecycle, from initialization to closing.