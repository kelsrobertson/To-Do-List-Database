# One-to-many relationship
CREATE DATABASE to_do_list_db;
USE to_do_list_db;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    sex VARCHAR (10),
    dob DATE,
    age INT, 
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    task_name VARCHAR(225) NOT NULL,
    status ENUM('pending', 'completed') NOT NULL,
    deadline DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


INSERT INTO users (username, sex, dob, age, email) VALUES
('jack_foxx', 'Male', '2000-10-12', 24, 'foxx.jackk@gmail.com'),
('sammy_smith','Male', '1999-12-20', 24, 'samsmith@gmail.com'),
('alice_johnson', 'Female', '1995-03-21', 29, 'alice@gmail.com');

INSERT INTO tasks (user_id, task_name, status, deadline) VALUES
(1, 'Finish project report', 'pending', '2024-11-01'),
(1, 'Review code', 'completed', '2024-10-15'),
(2, 'Plan next week\'s meetings', 'pending', '2024-10-22'),
(2, 'Update documentation', 'completed', '2024-09-30'),
(3, 'Research new technologies', 'pending', '2024-11-05'),
(3, 'Prepare presentation', 'pending', '2024-10-28');

SELECT * FROM tasks WHERE user_id = 1 AND status = 'pending';

SELECT * FROM tasks WHERE user_id = 1 ORDER BY deadline ASC;

SELECT COUNT(*) AS completed_tasks FROM tasks WHERE user_id = 1
AND status = 'completed';

SELECT * FROM tasks WHERE deadline < '2024-10-01';



