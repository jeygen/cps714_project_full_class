-- Insert data into User table
INSERT INTO User (user_id, username, email, password_hash, role, first_name, last_name, phone_number, address, city, postal_code, points_balance, created_at, updated_at) VALUES
(1, 'AliceJohnson', 'alice@example.com', 'password123', 'Client', 'Alice', 'Johnson', '123456789', '1 Toronto St.', 'Toronto', 'postalcode', 0, '2024-11-01 10:15:00', '2024-11-01 10:15:00'),
(2, 'Bob Smith', 'bob@example.com', 'password456', 'Admin', 'Bob', 'Smith', '123456789', '1 Toronto St.', 'Toronto', 'postalcode', 10, '2024-11-01 10:15:00', '2024-11-01 10:15:00'),
(3, 'Charlie Brown', 'charlie@example.com', 'password789', 'Admin', 'Charlie', 'Brown', '123456789', '1 Toronto St.', 'Toronto', 'postalcode', 100, '2024-11-01 10:15:00', '2024-11-01 10:15:00'),
(4, 'Daisy Lee', 'daisy@example.com', 'password101', 'Admin', 'Daisy', 'Lee', '123456789', '1 Toronto St.', 'Toronto', 'postalcode', 0, '2024-11-01 10:15:00', '2024-11-01 10:15:00');

-- Insert data into SupportTicket table
INSERT INTO SupportTicket (ticket_id, user_id, subject, description, category, status, priority, created_at, updated_at) VALUES
(1, 1, 'Login Issue', 'Cannot log in to the portal', 'Technical', 'Open', 'High', '2024-11-01 10:15:00', '2024-11-01 10:15:00'),
(2, 3, 'Payment Issue', 'Failed transaction while making a payment', 'Billing', 'In Progress', 'Medium', '2024-11-02 14:30:00', '2024-11-02 15:00:00'),
(3, 1, 'Account Locked', 'Account locked after multiple failed attempts', 'Technical', 'Closed', 'High', '2024-11-03 09:45:00', '2024-11-03 10:15:00');

-- Insert data into ChatSession table
INSERT INTO ChatSession (session_id, client_id, agent_id, start_time, end_time) VALUES
(1, 1, 2, '2024-11-01 10:20:00', '2024-11-01 10:40:00'),
(2, 3, 2, '2024-11-02 14:35:00', '2024-11-02 15:05:00'),
(3, 1, 4, '2024-11-03 09:50:00', '2024-11-03 10:10:00');

-- Insert data into ChatMessage table
INSERT INTO ChatMessage (message_id, session_id, sender_id, message_text, timestamp) VALUES
(1, 1, 1, 'I am unable to log in to my account', '2024-11-01 10:21:00'),
(2, 1, 2, 'I can help with that. Let me check your details.', '2024-11-01 10:22:00'),
(3, 2, 3, 'My payment failed, and I don’t know why.', '2024-11-02 14:36:00'),
(4, 2, 2, 'I’ll look into it right away. Please hold.', '2024-11-02 14:37:00'),
(5, 3, 1, 'My account got locked. Can you assist?', '2024-11-03 09:51:00'),
(6, 3, 4, 'Yes, I’ll unlock it for you now.', '2024-11-03 09:52:00');
