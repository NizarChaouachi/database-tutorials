CREATE DATABASE project_manager_db ;
\c project_manager_db

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE projects (
    project_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);
CREATE TYPE status_name AS ENUM('Pending', 'In Progress', 'Completed');
CREATE TABLE tasks (
    task_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID REFERENCES projects(project_id),
    user_id UUID REFERENCES users(user_id),
    task_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status status_name DEFAULT 'In Progress',
    hours_worked INT
);

INSERT INTO users (name, email)
VALUES 
    ('Alice Johnson', 'alice.johnson@example.com'),
    ('Bob Smith', 'bob.smith@example.com'),
    ('Catherine Green', 'catherine.green@example.com'),
    ('David Brown', 'david.brown@example.com'),
    ('Emma Wilson', 'emma.wilson@example.com'),
    ('Frank Harris', 'frank.harris@example.com'),
    ('Grace Lee', 'grace.lee@example.com'),
    ('Henry King', 'henry.king@example.com'),
    ('Ivy White', 'ivy.white@example.com'),
    ('Jack Black', 'jack.black@example.com');

INSERT INTO projects (project_name, start_date, end_date)
VALUES 
    ('Project Alpha', '2023-01-01', '2023-06-30'),
    ('Project Beta', '2023-02-15', '2023-07-15'),
    ('Project Gamma', '2023-03-01', '2023-08-01'),
    ('Project Delta', '2023-04-01', '2023-09-01'),
    ('Project Epsilon', '2023-05-01', NULL),  -- Ongoing
    ('Project Zeta', '2023-06-15', NULL),      -- Ongoing
    ('Project Eta', '2023-07-01', '2023-12-31'),
    ('Project Theta', '2023-08-01', '2024-01-31'),
    ('Project Iota', '2023-09-01', '2024-02-28'),
    ('Project Kappa', '2023-10-01', NULL);     -- Ongoing



INSERT INTO tasks (project_id,user_id,task_name,start_date,end_date,status,hours_worked) VALUES 
((SELECT project_id FROM projects WHERE project_name = 'Project Alpha'),
 (SELECT user_id FROM users WHERE email = 'alice.johnson@example.com'),
  'Task A1', '2023-01-05', '2023-01-20', 'Completed', 20),

   ((SELECT project_id FROM projects WHERE project_name = 'Project Alpha'), 
     (SELECT user_id FROM users WHERE email = 'bob.smith@example.com'), 
     'Task A2', '2023-01-10', '2023-02-10', 'Completed', 30),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Beta'), 
     (SELECT user_id FROM users WHERE email = 'catherine.green@example.com'), 
     'Task B1', '2023-02-20', '2023-03-05', 'In Progress', 15),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Beta'), 
     (SELECT user_id FROM users WHERE email = 'david.brown@example.com'), 
     'Task B2', '2023-02-25', '2023-04-01', 'Completed', 40),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Gamma'), 
     (SELECT user_id FROM users WHERE email = 'emma.wilson@example.com'), 
     'Task C1', '2023-03-10', '2023-04-10', 'Pending', 10),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Gamma'), 
     (SELECT user_id FROM users WHERE email = 'frank.harris@example.com'), 
     'Task C2', '2023-03-15', '2023-05-01', 'In Progress', 25),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Delta'), 
     (SELECT user_id FROM users WHERE email = 'grace.lee@example.com'), 
     'Task D1', '2023-04-05', '2023-05-20', 'Completed', 35),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Delta'), 
     (SELECT user_id FROM users WHERE email = 'henry.king@example.com'), 
     'Task D2', '2023-04-10', '2023-06-01', 'In Progress', 50),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Epsilon'), 
     (SELECT user_id FROM users WHERE email = 'ivy.white@example.com'), 
     'Task E1', '2023-05-05', NULL, 'Pending', 5),
    
    ((SELECT project_id FROM projects WHERE project_name = 'Project Epsilon'), 
     (SELECT user_id FROM users WHERE email = 'jack.black@example.com'), 
     'Task E2', '2023-05-15', NULL, 'Pending', 10);

    SELECT * FROM tasks WHERE project_id = (SELECT project_id FROM projects WHERE project_name = 'Project Alpha');

    SELECT * FROM tasks WHERE user_id = (SELECT user_id FROM users WHERE email = 'catherine.green@example.com');
    

    SELECT user_id,name FROM users WHERE user_id IN (SELECT user_id FROM tasks GROUP BY user_id HAVING SUM(hours_worked)>20);

    SELECT user_id,name FROM users WHERE user_id IN (SELECT user_id FROM tasks GROUP BY user_id HAVING SUM(hours_worked)<10);

    SELECT user_id,name FROM users WHERE user_id IN (SELECT user_id FROM tasks WHERE status = 'In Progress' GROUP BY user_id HAVING SUM(hours_worked)<10);


    SELECT project_id,project_name FROM projects WHERE project_id = (SELECT project_id FROM tasks GROUP BY project_id ORDER BY sum(hours_worked) DESC LIMIT 1);
    SELECT project_id,project_name FROM projects WHERE project_id IN (SELECT project_id FROM tasks GROUP BY project_id ORDER BY sum(hours_worked) DESC);

    SELECT project_id,project_name FROM projects WHERE project_id IN (SELECT project_id FROM tasks WHERE status = 'Completed');

    SELECT user_id,name FROM users WHERE user_id IN (SELECT user_id FROM tasks WHERE status = 'Completed');


    SELECT name,email FROM users WHERE user_id IN (SELECT user_id FROM tasks GROUP BY user_id HAVING COUNT(DISTINCT project_id) = 1);

    SELECT task_name,(SELECT project_name FROM projects WHERE projects.project_id = tasks.project_id ) AS project_name FROM tasks ;

    SELECT project_name ,(SELECT SUM(hours_worked) FROM tasks WHERE tasks.project_id = projects.project_id ) AS total_hours FROM projects ORDER BY total_hours;

    SELECT project_name ,(SELECT COUNT(*) FROM tasks WHERE tasks.project_id = projects.project_id AND status = 'Completed') AS completed_tasks_count FROM projects;


    SELECT project_name ,(SELECT AVG(hours_worked) FROM tasks WHERE tasks.project_id = projects.project_id ) AS average_hours FROM projects ORDER BY average_hours;

    SELECT name,email FROM users WHERE user_id IN (
        SELECT DISTINCT user_id FROM tasks WHERE project_id IN (
            SELECT project_id FROM projects WHERE end_date IS NOT NULL
            )
        );

    SELECT name,email FROM users WHERE user_id IN (
        SELECT DISTINCT user_id FROM tasks WHERE project_id IN (
            SELECT project_id FROM projects WHERE end_date IS NULL
            )
        );