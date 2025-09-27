-- Buat database (jalankan manual jika perlu)
-- CREATE DATABASE restaurantdb;

-- Gunakan database
-- \c restaurantdb;

-- ===========================
-- DROP TABLES (jika ada)
-- ===========================
DROP TABLE IF EXISTS bill_items CASCADE;
DROP TABLE IF EXISTS bills CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS kitchen CASCADE;
DROP TABLE IF EXISTS menu CASCADE;
DROP TABLE IF EXISTS staffs CASCADE;
DROP TABLE IF EXISTS memberships CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS table_availability CASCADE;

-- ===========================
-- TABLE DEFINITIONS
-- ===========================

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE staffs (
    staff_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE
);

CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    points INT DEFAULT 0,
    account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE
);

CREATE TABLE menu (
    menu_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    table_number INT NOT NULL,
    reservation_time TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    account_id INT REFERENCES accounts(account_id) ON DELETE CASCADE
);

CREATE TABLE bills (
    bill_id SERIAL PRIMARY KEY,
    reservation_id INT REFERENCES reservations(reservation_id) ON DELETE CASCADE,
    total_amount NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(50),
    paid BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bill_items (
    bill_item_id SERIAL PRIMARY KEY,
    bill_id INT REFERENCES bills(bill_id) ON DELETE CASCADE,
    menu_id INT REFERENCES menu(menu_id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE kitchen (
    kitchen_id SERIAL PRIMARY KEY,
    bill_item_id INT REFERENCES bill_items(bill_item_id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'pending',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE table_availability (
    availability_id SERIAL PRIMARY KEY,
    table_number INT NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================
-- SEED DATA
-- ===========================

-- Accounts
INSERT INTO accounts (username, password, role)
VALUES 
    ('admin', 'admin123', 'admin'),
    ('staff1', 'staff123', 'staff'),
    ('john_doe', 'customer123', 'customer')
ON CONFLICT (username) DO NOTHING;

-- Staffs
INSERT INTO staffs (name, position, phone, account_id)
VALUES
    ('Alice', 'Manager', '08123456789', 2)
ON CONFLICT DO NOTHING;

-- Memberships
INSERT INTO memberships (customer_name, phone, points, account_id)
VALUES
    ('John Doe', '08987654321', 100, 3)
ON CONFLICT DO NOTHING;

-- Menu
INSERT INTO menu (name, category, price, available) VALUES
    ('Nasi Goreng Spesial', 'Makanan', 25000, TRUE),
    ('Mie Ayam Bakso', 'Makanan', 20000, TRUE),
    ('Sate Ayam', 'Makanan', 30000, TRUE),
    ('Es Teh Manis', 'Minuman', 5000, TRUE),
    ('Jus Alpukat', 'Minuman', 15000, TRUE),
    ('Kopi Hitam', 'Minuman', 8000, TRUE)
ON CONFLICT DO NOTHING;

-- Reservations
INSERT INTO reservations (customer_name, table_number, reservation_time, status, account_id)
VALUES
    ('John Doe', 1, NOW() + INTERVAL '1 hour', 'confirmed', 3)
ON CONFLICT DO NOTHING;

-- Bills
INSERT INTO bills (reservation_id, total_amount, payment_method, paid)
VALUES
    (1, 45000, 'cash', TRUE)
ON CONFLICT DO NOTHING;

-- Bill Items
INSERT INTO bill_items (bill_id, menu_id, quantity, price) VALUES
    (1, 1, 1, 25000),
    (1, 4, 2, 10000),
    (1, 6, 1, 8000)
ON CONFLICT DO NOTHING;

-- Kitchen
INSERT INTO kitchen (bill_item_id, status) VALUES
    (1, 'cooking'),
    (2, 'done'),
    (3, 'pending')
ON CONFLICT DO NOTHING;

-- Table Availability
INSERT INTO table_availability (table_number, available) VALUES
    (1, FALSE),
    (2, TRUE),
    (3, TRUE),
    (4, TRUE)
ON CONFLICT DO NOTHING;
