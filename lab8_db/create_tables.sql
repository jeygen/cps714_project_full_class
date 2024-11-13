-- Table: User
CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Client', 'Admin') NOT NULL,
    first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(10),
address VARCHAR(255),
city VARCHAR(100),
postal_code VARCHAR(10),
points_balance INT,
    created_at DATETIME,
    updated_at DATETIME
);

-- Table: SupportTicket
CREATE TABLE SupportTicket (
    ticket_id INT PRIMARY KEY,
    user_id INT,
    subject VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    category VARCHAR(100),
    status ENUM('Open', 'In progress', 'Closed') NOT NULL,
    priority ENUM('Low', 'Medium', 'High') NOT NULL,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Table: ChatSession
CREATE TABLE ChatSession (
    session_id INT PRIMARY KEY,
    client_id INT,
    agent_id INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (client_id) REFERENCES User(user_id),
    FOREIGN KEY (agent_id) REFERENCES User(user_id)
);

-- Table: ChatMessage
CREATE TABLE ChatMessage (
    message_id INT PRIMARY KEY,
    session_id INT,
    sender_id INT,
    message_text VARCHAR(255),
    timestamp DATETIME,
    FOREIGN KEY (session_id) REFERENCES ChatSession(session_id),
    FOREIGN KEY (sender_id) REFERENCES User(user_id)
);
