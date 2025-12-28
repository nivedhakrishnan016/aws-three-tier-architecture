--Install MySQL Client (MariaDB)
sudo yum install mariadb105 -y

--Connect to Amazon RDS
mysql -h database-1.czqqisk6egja.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p

3. --List Existing Databases
show DATABASES;

-- Use database 
Use Database;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data (Demo purpose only)
INSERT INTO users (username, password, email) 
VALUES 
('Nivedha', 'Nive123#', 'nivedha@gmail.com'),
('Mukilan', 'Mukilan123', 'mukil@gmail.com'),
('Priya', 'Priya123', 'priya@gmail.com');

-- Verify Data
SELECT * FROM users;

