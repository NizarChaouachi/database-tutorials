import psycopg2
import csv

def connect_db():
    try :
        conn = psycopg2.connect(
            dbname = 'test_db_python',
            user= 'postgres',
            password = 'postgres',
            host='localhost',
            port=5432
        )
        print("Connection to database established successfully")
        return conn
    
    except psycopg2.Error as e:
        print(f"an error occured while connection to db : {e}")
        return None
    
    except Exception as e:
        print(f"An unexpected error occured {e}")
        return None


def create_table():
    conn = connect_db()
    
    if conn is None:#if not conn
        print("Failed to connect to the database.")
        return
    
    try:
        cursor = conn.cursor()
        
        create_table_query = """
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(50) NOT NULL,
            email VARCHAR(100) NOT NULL,
            age INTEGER NOT NULL CHECK(age>15),
            city VARCHAR(50),
            country VARCHAR(50)
        );
        """
        cursor.execute(create_table_query)
        conn.commit()
        print('Table users created successfully.')
        
    except psycopg2.Error as e:
        print(f"An error occuered during table creation {e}")
        
    except Exception as e:
        print(f"An unexpected error occured {e}")
        
    finally:
        cursor.close()
        conn.close()
        

def create_user(name,email,age,city,country):
    conn = connect_db()
    cursor=conn.cursor()
    insert_query = f"""INSERT INTO users (name,email,age,city,country)
    VALUEs ('{name}','{email}','{age}','{city}','{country}')"""
    cursor.execute(insert_query)
    conn.commit()
    cursor.close()
    conn.close()
    
def create_many_users(file):
    conn = connect_db()
    cursor=conn.cursor()
    with open(file,'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            insert_query = f"""INSERT INTO users (name,email,age,city,country)
                VALUES ('{row['name']}','{row['email']}','{row['age']}','{row['city']}','{row['country']}')"""
            cursor.execute(insert_query)
            conn.commit()
    cursor.close()
    conn.close() 
     
def read_users():
    conn=connect_db()
    cursor = conn.cursor()
    select_query ="""SELECT * FROM users; """
    cursor.execute(select_query)
    rows = cursor.fetchall()#list
    cursor.close()
    conn.close()
    return rows

def get_user_by_id(user_id):
    conn=connect_db()
    cursor = conn.cursor()
    select_query =f"""SELECT * FROM users WHERE id={user_id}; """
    cursor.execute(select_query)
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    if user:
        return user
    return None

def get_user_by_name(user_name):
    conn=connect_db()
    cursor = conn.cursor()
    select_query =f"""SELECT * FROM users WHERE name={user_name}; """
    cursor.execute(select_query)
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    if user:
        return user
    return None
def get_user_by_id_range(id_min,id_max):
    conn=connect_db()
    cursor = conn.cursor()
    select_query =F"""SELECT * FROM users WHERE id BETWEEN {id_min} AND {id_max} ORDER BY name; """
    cursor.execute(select_query)
    rows = cursor.fetchall()#list
    cursor.close()
    conn.close()
    return rows

def update_user(user_id,name=None,email=None,age=None,city=None,country=None):
    conn=connect_db()
    cursor = conn.cursor()
    update_query = "UPDATE users SET "
    updates=[]
    if name:
        updates.append(f"name = '{name}'")
    if email :
        updates.append(f"email = '{email}'")
    if age is not None:
        updates.append(f"age = '{age}'")
    if city:
        updates.append(f"city = '{city}'")
    if country:
        updates.append(f"country = '{country}'")
    update_query += ', '.join(updates)+f"WHERE id={user_id};"
    cursor.execute(update_query)
    conn.commit()
    cursor.close()
    conn.close()
    
def delete_user(user_id=None,user_name=None):
    conn=connect_db()
    cursor = conn.cursor()
    delete_query ="DELETE FROM users WHERE "
    if user_id:
        delete_query += f"id ={user_id}"
        print(f"user with user_id = {user_id} was deleted")
    if user_name :
        delete_query += f"name ='{user_name}'"
        print(f"user with name = {user_name} was deleted")
    cursor.execute(delete_query)
    conn.commit()
    cursor.close()
    conn.close()
    
if __name__=='__main__':
    connect_db()
    # create_table()
    # create_user('Alice','alice1@example.com',30,'Berlin','Germany')
    # create_many_users('test_data2.csv')
    users = read_users()
    for user in users:   
        print(user)
    # user=get_user_by_id(5)
    # print(user)
    # update_user(8,name='Killian')
    # update_user(12,city='Bremen',country='Poland')
    # delete_user(user_id=8)
    # delete_user(user_name='Alice')
    # users=get_user_by_id_range(8,14)
    # for user in users:   
    #     print(user)