import psycopg2
from PIL import Image
from io import BytesIO
import time 
import os
from dotenv import load_dotenv


load_dotenv()
DATABASE = os.getenv('database')
USERNAME = os.getenv('user')
PASSWORD = os.getenv('password')


class DatabaseConfig:
    def __init__(self,database,user,password,host,port) :
        self.database = database
        self.user = user
        self.password = password
        self.host = host
        self.port = port
        
        
class DatabaseConnection:
    def __init__(self,config : DatabaseConfig) -> None:
        self.config = config
        self.conn = None
        self.cursor = None
        
    def connect(self):
        self.conn = psycopg2.connect(
            database = self.config.database,
            user = self.config.user,
            password=self.config.password,
            host=self.config.host,
            port=self.config.port,
        )
        self.cursor = self.conn.cursor()

    def close(self):
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()
            
class ImageStorage:
    def __init__(self,db_connection : DatabaseConnection) :
        self.db_connection = db_connection
    
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
        
    def save_image(self,image_binary:bytes):
        self.db_connection.cursor.execute(
            "INSERT INTO my_album (image_data) VALUES (%s)",
                    (psycopg2.Binary(image_binary),),
        )
        self.db_connection.conn.commit()
        
    def fetch_image(self,image_id):
        self.db_connection.cursor.execute(
            f"SELECT image_data FROM my_album WHERE id={image_id};"
        )
        image_binary = self.db_connection.cursor.fetchone()[0]
        return image_binary
    
class ImageHandler:
    
    @staticmethod
    def read_image(file_path):
        with open(file_path,'rb') as image_file:
            return image_file.read()
    @staticmethod
    def display_image(image_binary):
        image =Image.open(BytesIO(image_binary))
        image.show()
        
class ImageApp:
    def __init__(self,db_connection:DatabaseConnection) :
        self.db_connection = db_connection
        self.image_storage = ImageStorage(self.db_connection)
        
    def run(self,image_path):
        image_binary = ImageHandler.read_image(image_path)
        self.image_storage.create_table()
        print('table created')
        time.sleep(0.5)
        self.image_storage.save_image(image_binary)
        print('image saved')
        time.sleep(0.5)
        fechted_image = self.image_storage.fetch_image(3)#retreiving the first image with id 1
        print('image fetched')
        ImageHandler.display_image(fechted_image)


if __name__ =='__main__':
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
    