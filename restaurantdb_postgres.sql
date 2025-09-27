-- Buat database
CREATE DATABASE restaurantdb;

-- Tabel menu
CREATE TABLE menu (
  item_id VARCHAR(6) PRIMARY KEY,
  item_name VARCHAR(255),
  item_type VARCHAR(255),
  item_category VARCHAR(255),
  item_price NUMERIC(10, 2),
  item_description VARCHAR(255)
);

-- Tabel accounts
CREATE TABLE accounts (
  account_id SERIAL PRIMARY KEY,
  email VARCHAR(255),
  register_date DATE,
  phone_number VARCHAR(255),
  password VARCHAR(255)
);

-- Tabel staffs
CREATE TABLE staffs (
  staff_id SERIAL PRIMARY KEY,
  staff_name VARCHAR(255),
  role VARCHAR(255),
  account_id INT REFERENCES accounts(account_id)
);

-- Tabel memberships
CREATE TABLE memberships (
  member_id SERIAL PRIMARY KEY,
  member_name VARCHAR(255),
  points INT,
  account_id INT REFERENCES accounts(account_id)
);

-- Tabel meja restoran
CREATE TABLE restaurant_tables (
  table_id SERIAL PRIMARY KEY,
  capacity INT,
  is_available BOOLEAN DEFAULT true
);

-- Tabel ketersediaan meja
CREATE TABLE table_availability (
  availability_id SERIAL PRIMARY KEY,
  table_id INT REFERENCES restaurant_tables(table_id),
  reservation_date DATE,
  reservation_time TIME,
  status VARCHAR(20)
);

-- Tabel reservasi
CREATE TABLE reservations (
  reservation_id INT PRIMARY KEY,
  customer_name VARCHAR(255),
  table_id INT REFERENCES restaurant_tables(table_id),
  reservation_time TIME,
  reservation_date DATE,
  head_count INT,
  special_request VARCHAR(255)
);

-- Tabel pembayaran kartu
CREATE TABLE card_payments (
    card_id SERIAL PRIMARY KEY,
    account_holder_name VARCHAR(255) NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    expiry_date VARCHAR(7) NOT NULL,
    security_code VARCHAR(3) NOT NULL
);

-- Tabel bills
CREATE TABLE bills (
  bill_id SERIAL PRIMARY KEY,
  staff_id INT REFERENCES staffs(staff_id),
  member_id INT REFERENCES memberships(member_id),
  reservation_id INT REFERENCES reservations(reservation_id),
  table_id INT REFERENCES restaurant_tables(table_id),
  card_id INT REFERENCES card_payments(card_id),
  payment_method VARCHAR(255),
  bill_time TIMESTAMP,
  payment_time TIMESTAMP
);

-- Tabel detail bill
CREATE TABLE bill_items (
  bill_item_id SERIAL PRIMARY KEY,
  bill_id INT REFERENCES bills(bill_id),
  item_id VARCHAR(6) REFERENCES menu(item_id),
  quantity INT
);

-- Tabel dapur
CREATE TABLE kitchen (
    kitchen_id SERIAL PRIMARY KEY,
    table_id INT REFERENCES restaurant_tables(table_id),
    item_id VARCHAR(6) REFERENCES menu(item_id),
    quantity INT,
    time_submitted TIMESTAMP,
    time_ended TIMESTAMP
);

-- Seed Data
INSERT INTO restaurant_tables (table_id, capacity, is_available) VALUES
(1, 4, true),
(2, 4, true),
(3, 4, true),
(4, 6, true),
(5, 6, true),
(6, 6, true),
(7, 6, true),
(8, 8, true),
(9, 8, true),
(10, 8, true);

-- Insert Menu
INSERT INTO menu (item_id, item_name, item_type, item_category, item_price, item_description) VALUES
('ID1', 'Nasi Goreng Spesial', 'Indonesian Food', 'Main Dishes', 28, 'Nasi goreng dengan telur, ayam, dan sate'),
('ID2', 'Sate Ayam', 'Indonesian Food', 'Main Dishes', 32, 'Tusuk sate ayam dengan bumbu kacang'),
('ID3', 'Sop Buntut', 'Indonesian Food', 'Main Dishes', 45, 'Sup buntut sapi khas Indonesia'),
('ID4', 'Ayam Penyet', 'Indonesian Food', 'Main Dishes', 30, 'Ayam goreng sambal terasi'),
('ID5', 'Rendang Daging', 'Indonesian Food', 'Main Dishes', 48, 'Rendang sapi khas Minang'),
('ID6', 'Ikan Bakar Jimbaran', 'Indonesian Food', 'Main Dishes', 42, 'Ikan bakar bumbu khas Bali'),
('ME1', 'Nasi Mandhi Ayam', 'Middle Eastern', 'Main Dishes', 40, 'Nasi berbumbu khas Yaman dengan ayam'),
('ME2', 'Nasi Biryani Kambing', 'Middle Eastern', 'Main Dishes', 55, 'Nasi biryani dengan kambing'),
('ME3', 'Shawarma Daging', 'Middle Eastern', 'Main Dishes', 32, 'Shawarma daging sapi dengan saus tahini'),
('ME4', 'Chicken Kebab', 'Middle Eastern', 'Main Dishes', 35, 'Kebab ayam panggang dengan roti pita'),
('ME5', 'Lamb Kebab', 'Middle Eastern', 'Main Dishes', 45, 'Kebab daging kambing panggang'),
('ME6', 'Hummus & Falafel', 'Middle Eastern', 'Main Dishes', 28, 'Hummus dengan falafel goreng'),
('AS1', 'Beef Bulgogi', 'Asian Food', 'Main Dishes', 42, 'Hidangan Korea dengan daging sapi manis gurih'),
('AS2', 'Chicken Teriyaki', 'Asian Food', 'Main Dishes', 35, 'Ayam panggang saus teriyaki khas Jepang'),
('AS3', 'Ramen Ayam', 'Asian Food', 'Main Dishes', 30, 'Mie kuah Jepang dengan ayam halal'),
('AS4', 'Tom Yum Goong', 'Asian Food', 'Main Dishes', 38, 'Sup pedas asam khas Thailand dengan udang'),
('AS5', 'Pad Thai', 'Asian Food', 'Main Dishes', 32, 'Mie goreng khas Thailand'),
('AS6', 'Dimsum Halal', 'Asian Food', 'Main Dishes', 28, 'Aneka dimsum halal ayam dan udang'),
('SD1', 'Kentang Goreng', 'Side Dishes', 'Side Snacks', 12, 'Kentang goreng renyah'),
('SD2', 'Tahu Isi', 'Side Dishes', 'Side Snacks', 10, 'Tahu goreng isi sayuran pedas'),
('SD3', 'Bakwan Jagung', 'Side Dishes', 'Side Snacks', 10, 'Bakwan jagung renyah'),
('SD4', 'Hummus dengan Pita', 'Side Dishes', 'Side Snacks', 18, 'Roti pita dengan hummus'),
('DS1', 'Es Cendol', 'Dessert', 'Side Snacks', 15, 'Minuman segar khas Indonesia'),
('DS2', 'Klepon', 'Dessert', 'Side Snacks', 12, 'Kue tradisional isi gula merah'),
('DS3', 'Baklava', 'Dessert', 'Side Snacks', 18, 'Kue manis khas Timur Tengah'),
('DS4', 'Kue Lumpur', 'Dessert', 'Side Snacks', 12, 'Kue tradisional manis dan lembut'),
('DR1', 'Teh Tarik', 'Drinks', 'Drinks', 10, 'Teh susu tarik khas Asia'),
('DR2', 'Es Teh Manis', 'Drinks', 'Drinks', 5, 'Teh manis dingin'),
('DR3', 'Es Jeruk', 'Drinks', 'Drinks', 6, 'Jeruk peras segar'),
('DR4', 'Jus Alpukat', 'Drinks', 'Drinks', 18, 'Jus alpukat kental dengan coklat'),
('DR5', 'Air Mineral', 'Drinks', 'Drinks', 3, 'Air mineral dingin');
