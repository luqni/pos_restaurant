-- ===============================
-- PostgreSQL schema for restaurantdb
-- ===============================

-- Hapus tabel kalau sudah ada (supaya fresh)
DROP TABLE IF EXISTS bill_items CASCADE;
DROP TABLE IF EXISTS bills CASCADE;
DROP TABLE IF EXISTS kitchen CASCADE;
DROP TABLE IF EXISTS table_availability CASCADE;
DROP TABLE IF EXISTS restaurant_tables CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS menu CASCADE;

-- ===============================
-- Accounts
-- ===============================
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    register_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- Staff
-- ===============================
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL,
    staff_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ===============================
-- Customers
-- ===============================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    membership_level VARCHAR(50),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- ===============================
-- Restaurant Tables
-- ===============================
CREATE TABLE restaurant_tables (
    table_id SERIAL PRIMARY KEY,
    table_number INT NOT NULL UNIQUE,
    capacity INT NOT NULL
);

-- ===============================
-- Table Availability
-- ===============================
CREATE TABLE table_availability (
    availability_id SERIAL PRIMARY KEY,
    table_id INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (table_id) REFERENCES restaurant_tables(table_id) ON DELETE CASCADE
);

-- ===============================
-- Menu
-- ===============================
CREATE TABLE menu (
    item_id VARCHAR(10) PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- ===============================
-- Bills
-- ===============================
CREATE TABLE bills (
    bill_id SERIAL PRIMARY KEY,
    table_id INT NOT NULL,
    customer_id INT,
    staff_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (table_id) REFERENCES restaurant_tables(table_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

-- ===============================
-- Bill Items
-- ===============================
CREATE TABLE bill_items (
    bill_item_id SERIAL PRIMARY KEY,
    bill_id INT NOT NULL,
    item_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu(item_id) ON DELETE CASCADE
);

-- ===============================
-- Kitchen Orders
-- ===============================
CREATE TABLE kitchen (
    kitchen_id SERIAL PRIMARY KEY,
    table_id INT NOT NULL,
    item_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    time_submitted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    time_ended TIMESTAMP NULL,
    FOREIGN KEY (table_id) REFERENCES restaurant_tables(table_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu(item_id) ON DELETE CASCADE
);

-- ===============================
-- Sample Data
-- ===============================

-- Menu Items
INSERT INTO menu (item_id, item_name, category, price) VALUES
('MD1', 'Nasi Goreng', 'Main Dish', 25000),
('MD2', 'Mie Goreng', 'Main Dish', 22000),
('MD3', 'Ayam Bakar', 'Main Dish', 30000),
('SD1', 'Es Teh Manis', 'Drink', 8000),
('SD2', 'Jus Jeruk', 'Drink', 12000),
('DS1', 'Pisang Goreng', 'Dessert', 15000);

-- Tables
INSERT INTO restaurant_tables (table_number, capacity) VALUES
(1, 4),
(2, 4),
(3, 2),
(4, 6);

-- Table Availability
INSERT INTO table_availability (table_id, is_available) VALUES
(1, TRUE),
(2, TRUE),
(3, TRUE),
(4, TRUE);

-- Accounts
INSERT INTO accounts (email, password, phone_number) VALUES
('admin@resto.com', 'admin123', '08123456789'),
('staff1@resto.com', 'staff123', '08123456780'),
('cust1@mail.com', 'cust123', '0811111111');

-- Staff
INSERT INTO staff (account_id, staff_name, role) VALUES
(1, 'Admin Resto', 'Manager'),
(2, 'Budi Staff', 'Waiter');

-- Customers
INSERT INTO customers (account_id, customer_name, membership_level) VALUES
(3, 'Andi Customer', 'Gold');

-- Bills
INSERT INTO bills (table_id, customer_id, staff_id, total_amount) VALUES
(1, 1, 2, 37000);

-- Bill Items
INSERT INTO bill_items (bill_id, item_id, quantity) VALUES
(1, 'MD1', 1),
(1, 'SD1', 2);

-- Kitchen Orders
INSERT INTO kitchen (table_id, item_id, quantity) VALUES
(1, 'MD1', 1),
(1, 'SD1', 2);

-- ===============================
-- Done
-- ===============================
