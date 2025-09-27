-- Tabel menu
CREATE TABLE IF NOT EXISTS menu (
  item_id VARCHAR(6) PRIMARY KEY,
  item_name VARCHAR(255),
  item_type VARCHAR(255),
  item_category VARCHAR(255),
  item_price NUMERIC(10, 2),
  item_description VARCHAR(255)
);

-- Tabel accounts
CREATE TABLE IF NOT EXISTS accounts (
  account_id SERIAL PRIMARY KEY,
  email VARCHAR(255),
  register_date DATE,
  phone_number VARCHAR(255),
  password VARCHAR(255)
);

-- Tabel staffs
CREATE TABLE IF NOT EXISTS staffs (
  staff_id SERIAL PRIMARY KEY,
  staff_name VARCHAR(255),
  role VARCHAR(255),
  account_id INT REFERENCES accounts(account_id)
);

-- Tabel memberships
CREATE TABLE IF NOT EXISTS memberships (
  member_id SERIAL PRIMARY KEY,
  member_name VARCHAR(255),
  points INT,
  account_id INT REFERENCES accounts(account_id)
);

-- Tabel meja restoran
CREATE TABLE IF NOT EXISTS restaurant_tables (
  table_id SERIAL PRIMARY KEY,
  capacity INT,
  is_available BOOLEAN DEFAULT true
);

-- Tabel ketersediaan meja
CREATE TABLE IF NOT EXISTS table_availability (
  availability_id SERIAL PRIMARY KEY,
  table_id INT REFERENCES restaurant_tables(table_id),
  reservation_date DATE,
  reservation_time TIME,
  status VARCHAR(20)
);

-- Tabel reservasi
CREATE TABLE IF NOT EXISTS reservations (
  reservation_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255),
  table_id INT REFERENCES restaurant_tables(table_id),
  reservation_time TIME,
  reservation_date DATE,
  head_count INT,
  special_request VARCHAR(255)
);

-- Tabel pembayaran kartu
CREATE TABLE IF NOT EXISTS card_payments (
    card_id SERIAL PRIMARY KEY,
    account_holder_name VARCHAR(255) NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    expiry_date VARCHAR(7) NOT NULL,
    security_code VARCHAR(3) NOT NULL
);

-- Tabel bills
CREATE TABLE IF NOT EXISTS bills (
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
CREATE TABLE IF NOT EXISTS bill_items (
  bill_item_id SERIAL PRIMARY KEY,
  bill_id INT REFERENCES bills(bill_id),
  item_id VARCHAR(6) REFERENCES menu(item_id),
  quantity INT
);

-- Tabel dapur
CREATE TABLE IF NOT EXISTS kitchen (
    kitchen_id SERIAL PRIMARY KEY,
    table_id INT REFERENCES restaurant_tables(table_id),
    item_id VARCHAR(6) REFERENCES menu(item_id),
    quantity INT,
    time_submitted TIMESTAMP,
    time_ended TIMESTAMP
);

-- Seed Data Meja
INSERT INTO restaurant_tables (capacity, is_available) VALUES
(4, true),
(4, true),
(4, true),
(6, true),
(6, true),
(6, true),
(6, true),
(8, true),
(8, true),
(8, true)
ON CONFLICT DO NOTHING;

-- Seed Data Menu
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
('DR5', 'Air Mineral', 'Drinks', 'Drinks', 3, 'Air mineral dingin')
ON CONFLICT DO NOTHING;

-- =======================================
-- Extra Dummy Menu (for bill_items FK)
-- =======================================
INSERT INTO menu (item_id, item_name, item_type, item_category, item_price, item_description) VALUES
('MD1', 'Menu Dummy 1', 'Main Dishes', 'Dummy', 25, 'Auto generated menu item for bill'),
('MD2', 'Menu Dummy 2', 'Main Dishes', 'Dummy', 28, 'Auto generated menu item for bill'),
('MD4', 'Menu Dummy 4', 'Main Dishes', 'Dummy', 30, 'Auto generated menu item for bill'),
('MD5', 'Menu Dummy 5', 'Main Dishes', 'Dummy', 32, 'Auto generated menu item for bill'),
('MD9', 'Menu Dummy 9', 'Main Dishes', 'Dummy', 34, 'Auto generated menu item for bill'),
('MD15', 'Menu Dummy 15', 'Main Dishes', 'Dummy', 36, 'Auto generated menu item for bill'),
('MD16', 'Menu Dummy 16', 'Main Dishes', 'Dummy', 38, 'Auto generated menu item for bill'),
('MD19', 'Menu Dummy 19', 'Main Dishes', 'Dummy', 40, 'Auto generated menu item for bill'),
('MD21', 'Menu Dummy 21', 'Main Dishes', 'Dummy', 42, 'Auto generated menu item for bill'),
('MD23', 'Menu Dummy 23', 'Main Dishes', 'Dummy', 44, 'Auto generated menu item for bill'),
('MD29', 'Menu Dummy 29', 'Main Dishes', 'Dummy', 46, 'Auto generated menu item for bill'),
('MD32', 'Menu Dummy 32', 'Main Dishes', 'Dummy', 48, 'Auto generated menu item for bill'),
('MD33', 'Menu Dummy 33', 'Main Dishes', 'Dummy', 50, 'Auto generated menu item for bill'),
('MD41', 'Menu Dummy 41', 'Main Dishes', 'Dummy', 52, 'Auto generated menu item for bill'),
('MD42', 'Menu Dummy 42', 'Main Dishes', 'Dummy', 54, 'Auto generated menu item for bill'),
('S1', 'Side Dummy 1', 'Side Dishes', 'Dummy', 10, 'Auto generated menu item for bill'),
('S3', 'Side Dummy 3', 'Side Dishes', 'Dummy', 12, 'Auto generated menu item for bill'),
('S4', 'Side Dummy 4', 'Side Dishes', 'Dummy', 14, 'Auto generated menu item for bill'),
('S5', 'Side Dummy 5', 'Side Dishes', 'Dummy', 16, 'Auto generated menu item for bill'),
('S6', 'Side Dummy 6', 'Side Dishes', 'Dummy', 18, 'Auto generated menu item for bill'),
('S8', 'Side Dummy 8', 'Side Dishes', 'Dummy', 20, 'Auto generated menu item for bill'),
('L1', 'Large Dummy 1', 'Large Meals', 'Dummy', 22, 'Auto generated menu item for bill'),
('L2', 'Large Dummy 2', 'Large Meals', 'Dummy', 24, 'Auto generated menu item for bill'),
('L3', 'Large Dummy 3', 'Large Meals', 'Dummy', 26, 'Auto generated menu item for bill'),
('L5', 'Large Dummy 5', 'Large Meals', 'Dummy', 28, 'Auto generated menu item for bill'),
('HC2', 'Hot Combo 2', 'Combo', 'Dummy', 30, 'Auto generated menu item for bill'),
('HC3', 'Hot Combo 3', 'Combo', 'Dummy', 32, 'Auto generated menu item for bill'),
('HC4', 'Hot Combo 4', 'Combo', 'Dummy', 34, 'Auto generated menu item for bill'),
('HC5', 'Hot Combo 5', 'Combo', 'Dummy', 36, 'Auto generated menu item for bill'),
('C1', 'Combo 1', 'Combo', 'Dummy', 38, 'Auto generated menu item for bill'),
('C2', 'Combo 2', 'Combo', 'Dummy', 40, 'Auto generated menu item for bill'),
('C3', 'Combo 3', 'Combo', 'Dummy', 42, 'Auto generated menu item for bill'),
('C4', 'Combo 4', 'Combo', 'Dummy', 44, 'Auto generated menu item for bill'),
('SK3', 'Snack 3', 'Snacks', 'Dummy', 12, 'Auto generated menu item for bill'),
('SK6', 'Snack 6', 'Snacks', 'Dummy', 14, 'Auto generated menu item for bill'),
('CP1', 'Cold Pack 1', 'Drinks', 'Dummy', 15, 'Auto generated menu item for bill'),
('CP2', 'Cold Pack 2', 'Drinks', 'Dummy', 16, 'Auto generated menu item for bill'),
('CP3', 'Cold Pack 3', 'Drinks', 'Dummy', 17, 'Auto generated menu item for bill'),
('CP4', 'Cold Pack 4', 'Drinks', 'Dummy', 18, 'Auto generated menu item for bill'),
('CP5', 'Cold Pack 5', 'Drinks', 'Dummy', 19, 'Auto generated menu item for bill'),
('M1', 'Meal 1', 'Main Dishes', 'Dummy', 20, 'Auto generated menu item for bill'),
('M2', 'Meal 2', 'Main Dishes', 'Dummy', 22, 'Auto generated menu item for bill'),
('M4', 'Meal 4', 'Main Dishes', 'Dummy', 24, 'Auto generated menu item for bill'),
('M5', 'Meal 5', 'Main Dishes', 'Dummy', 26, 'Auto generated menu item for bill'),
('M6', 'Meal 6', 'Main Dishes', 'Dummy', 28, 'Auto generated menu item for bill'),
('HD1', 'Hot Dish 1', 'Main Dishes', 'Dummy', 30, 'Auto generated menu item for bill')
ON CONFLICT DO NOTHING;

INSERT INTO accounts (email, register_date, phone_number, password) VALUES 
('john@gmail.com', '2023-08-31', '+1234567890', 'password123'),
('susan@gmail.com', '2023-08-30', '+1987654321', 'susanpassword'),
('james@gmail.com', '2023-08-29', '+18887776666', 'jamespass'),
('alice@gmail.com', '2023-08-28', '+15555555555', 'alicepassword'),
('mike@gmail.com', '2023-08-27', '+14444444444', 'mikepass'),
('lisa@gmail.com', '2023-08-26', '+13333333333', 'lisapassword'),
('robert@gmail.com', '2023-08-25', '+12222222222', 'robertpass'),
('emily@gmail.com', '2023-08-24', '+16666666666', 'emilypassword'),
('david@gmail.com', '2023-08-23', '+1993219999', 'davidp321ass'),
('ddwd@gmail.com', '2023-08-23', '+1999999329999', 'davidpa2ss'),
('dadsvawvid@gmail.com', '2023-08-23', '+12234132199', 'david4pass'),
('davdavid@gmail.com', '2023-08-23', '+123239999', 'davidp13ass'),
('davvdasid@gmail.com', '2023-08-23', '+1995324319999', 'david2pass'),
('321david@gmail.com', '2023-08-23', '+1942199999', 'davidpa52ss'),
('32avid@gmail.com', '2023-08-23', '+1942193429999', 'da2332ss'),
('321da543vid@gmail.com', '2023-08-23', '+1942132199999', 'dav43a52ss'),
('3211234avid@gmail.com', '2023-08-23', '+194213599999', '32533pa52ss'),
('321543avid@gmail.com', '2023-08-23', '+1942154399999', '754dpa52ss'),
('rbsjsd@gmail.com', '2023-08-23', '+131351241239', '41f2s'),
    ('ol435143ivia@gmail.com', '2023-08-22', '+18888888888', 'oliviapass4215word'),
('robber@gmail.com', '2023-09-01', '+1234567890', 'password123'),
('jean@gmail.com', '2023-09-02', '+2345678901', 'password456'),
('emily@gmail.com', '2023-09-03', '+3456789012', 'password789'),
('robert@gmail.com', '2023-09-04', '+4567890123', 'passwordabc'),
('zoe@gmail.com', '2023-09-05', '+5678901234', 'passworddef'),
('lisa@gmail.com', '2023-09-06', '+6789012345', 'passwordghi'),
('taylor@gmail.com', '2023-09-07', '+7890123456', 'passwordjkl'),
('stephan@gmail.com', '2023-09-08', '+8901234567', 'passwordmno'),
('bruce@gmail.com', '2023-09-09', '+9012345678', 'passwordpqr'),
('jackie@gmail.com', '2023-09-10', '+0123456789', 'passwordstu')
ON CONFLICT DO NOTHING;


-- staffs table
-- INSERT INTO staffs (staff_name, role, account_id) VALUES ('John Smith', 'Waiter', 1),
-- ('Susan Johnson', 'Waiter', 2),
-- ('James Brown', 'Waiter', 3),
-- ('Alice Davis', 'Waiter', 4),
-- ('Mike Wilson', 'Waiter', 5),
-- ('Lisa Martinez', 'Chef', 6),
-- ('Robert Miller', 'Manager', 7),
-- ('Emily Moore', 'Manager', 8),
-- ('David Taylor', 'Chef', 9),
-- ('Olivia Anderson', 'Chef', 10)
-- ON CONFLICT DO NOTHING;

-- memberships table
-- INSERT INTO memberships (member_name, points,account_id) VALUES 
-- ('Abbel TuTuTu', 100,11),
-- ('Abignail Downey ', 200,12),
-- ('Jamie Mustafa', 300,13),
-- ('Luke Gun Slinger', 400,14),
-- ('Johny Rings', 500,15),
-- ('Wee Tuu Low', 600,16),
-- ('Sum Ting Wong', 700,17),
-- ('Ho Lee Fuk', 800,18),
-- ('Bang Ding Ow', 900,19),
-- ('Rocky Rocket', 1000,20),	
-- ('Robber Hellington', 250, 21),
-- ('Jean Ng', 300, 22),
-- ('Emily Davis', 400, 23),
-- ('Robert Wilson', 550, 24),
-- ('Zoe Chong', 650, 25),
-- ('Lisa Chia', 750, 26),
-- ('Taylor Swift', 900, 27),
-- ('Stephan Curry', 1050, 28),
-- ('Bruce Lee', 1200, 29),
-- ('Jackie Chan', 1350, 30)
-- ON CONFLICT DO NOTHING;



-- reservations table
INSERT INTO reservations (reservation_id, customer_name, table_id, reservation_time, reservation_date, head_count, special_request) VALUES 
(2220231, 'Abbel Tu Far Behind', 1, '22:00:34', '2023-09-28', 1, 'Prepare Panadol for me'),
(2220232, 'Abignaile Lin Downney Jr', 2, '22:00:34', '2023-09-29', 1, 'Default Special Request'),
(1920233, 'Jamie Mustafa', 3, '19:30:00', '2023-09-30', 2, 'Vegan options needed'),
(2020234, 'Luke Gun Slinger', 4, '20:00:00', '2023-09-30', 3, 'Birthday celebration'),
(1920235, 'Johny Rings', 5, '19:45:00', '2023-10-01', 2, 'Quiet corner, please'),
(1820237, 'Jean Ng', 7, '18:30:00', '2023-10-03', 2, 'Allergies: peanuts'),
(1920239, 'Taylor Swift', 9, '19:15:00', '2023-10-05', 2, 'Surprise dessert for anniversary'),
(1111111, 'Default', 9, '19:15:00', '2023-10-05', 2, 'Description'),
(14202310, 'Bruce Lee', 10, '14:45:00', '2023-10-06', 3, 'Window seat, if available')
ON CONFLICT DO NOTHING;

INSERT INTO card_payments (card_id, account_holder_name, card_number, expiry_date, security_code) VALUES
('1', 'John Smith', '1234567890123456', '10/15', '123'),
('2', 'Susan Johnson', '2345678901234567', '10/24', '456'),
('3', 'James Brown', '3456789012345678', '09/30', '789'),
('4', 'Alice Davis', '4567890123456789', '09/28', '321'),
('5', 'Mike Wilson', '5678901234567890', '09/29', '654'),
('6', 'Robert Miller', '7890123456789012', '10/19', '123'),
('7', 'Abbel TuTuTu', '1234123412341234', '10/25', '654'),
('8', 'Abignail Downey', '2345234523452345', '10/24', '987'),
('9', 'Jamie Mustafa', '3456345634563456', '09/23', '123'),
('10', 'Luke Gun Slinger', '4567456745674567', '09/22', '456')
ON CONFLICT DO NOTHING;

INSERT INTO bills (staff_id, member_id, reservation_id, table_id, card_id, payment_method, bill_time, payment_time) VALUES
(1, 1, 2220231, 1, 1, 'Card', '2023-09-28 22:45:00', '2023-09-28 22:50:00'),
(1, 5, NULL, 5, NULL, 'Cash', '2023-09-28 19:00:00', '2023-09-28 19:05:00'),
(1, 2, 2220232, 2, 2, 'Card', '2023-09-29 22:45:00', '2023-09-29 22:50:00'),
(2, 3, 1920233, 3, NULL, 'Cash', '2023-09-30 20:15:00', '2023-09-30 20:20:00'), 
(2, 4, 2020234, 4, 3, 'Card', '2023-09-30 20:30:00', '2023-09-30 20:35:00'),
(2, 8, NULL, 6, NULL, 'Cash', '2023-09-30 20:15:00', '2023-09-30 20:20:00'),
(3, 5, 1920235, 5, NULL, 'Cash', '2023-10-01 20:15:00', '2023-10-01 20:20:00'), 
(3, 6, NULL, 7, NULL, 'Cash', '2023-10-01 19:00:00', '2023-10-01 19:05:00'),
(3, 18, NULL, 2, NULL, 'Cash', '2023-10-01 18:30:00', '2023-10-01 18:35:00'),
(4, 7, NULL, 9, NULL, 'Cash', '2023-10-02 19:30:00', '2023-10-02 19:35:00'), 
(4, 17, NULL, 8, NULL, 'Cash', '2023-10-02 20:00:00', '2023-10-02 20:05:00'),
(4, 8, NULL, 10, 4, 'Card', '2023-10-02 19:00:00', '2023-10-02 19:05:00'),
(5, 9, 1820237, 6, 5, 'Card', '2023-10-03 18:45:00', '2023-10-03 18:50:00'),
(5, 16, NULL, 9, NULL, 'Cash', '2023-10-03 19:45:00', '2023-10-03 19:50:00'),
(5, 10, NULL, 5, NULL, 'Cash', '2023-10-03 20:00:00', '2023-10-03 20:05:00'), 
(6, 11, NULL, 4, 6, 'Card', '2023-10-03 20:15:00', '2023-10-03 20:20:00'),
(6, 8, NULL, 10, NULL, 'Cash', '2023-10-03 20:30:00', '2023-10-03 20:35:00'),
(6, 12, NULL, 3, 7, 'Card', '2023-10-04 19:30:00', '2023-10-04 19:35:00'),
(7, 13, NULL, 2, NULL, 'Cash', '2023-10-04 19:15:00', '2023-10-04 19:20:00'), 
(7, 14, 1920239, 1, NULL, 'Cash', '2023-10-05 20:30:00', '2023-10-05 20:35:00'),
(7, 1, NULL, 6, NULL, 'Cash', '2023-10-05 14:00:00', '2023-10-05 14:05:00'),
(8, 15, NULL, 8, 8, 'Card', '2023-10-05 20:45:00', '2023-10-05 20:50:00'),
(8, 16, NULL, 7, NULL, 'Cash', '2023-10-05 20:00:00', '2023-10-05 20:05:00'), 
(8, 2, NULL, 9, NULL, 'Cash', '2023-10-05 19:30:00', '2023-10-05 19:35:00'),
(8, 9, NULL, 4, NULL, 'Cash', '2023-10-05 20:15:00', '2023-10-05 20:20:00'),
(9, 17, NULL, 9, 9, 'Card', '2023-10-05 12:00:00', '2023-10-05 12:05:00'),
(9, 18, NULL, 10, 10, 'Card', '2023-10-06 13:15:00', '2023-10-06 13:20:00'),
(9, 19, 14202310, 8, NULL, 'Cash', '2023-10-06 14:30:00', '2023-10-06 14:35:00'),
(10, 7, NULL, 10, NULL, 'Cash', '2023-10-06 10:45:00', '2023-10-06 10:50:00'), 
(10, 20, NULL, 6, NULL, 'Cash', '2023-10-06 14:45:00', '2023-10-06 14:50:00')
ON CONFLICT DO NOTHING;



-- INSERT INTO bill_items (bill_id, item_id, quantity)
-- VALUES 
-- (1, 'MD1', 2),
-- (1, 'MD15', 1),
-- (1, 'S3', 2),
-- (1, 'L1', 1),

-- (2, 'MD2', 1),
-- (2, 'MD5', 2),
-- (2, 'MD16', 1),
-- (2, 'S5', 2),
-- (2, 'L2', 1),
-- (2, 'HC2', 2),

-- (3, 'MD19', 1),
-- (3, 'MD2', 1),
-- (3, 'MD4', 1),
-- (3, 'S6', 2),
-- (3, 'L3', 1),
-- (3, 'HC3', 2),

-- (4, 'MD23', 1),
-- (4, 'MD9', 1),
-- (4, 'L2', 2),
-- (4, 'C3', 1),
-- (4, 'HC4', 2),

-- (5, 'MD23', 1),
-- (5, 'S1', 1),
-- (5, 'S8', 2),
-- (5, 'L5', 1),
-- (5, 'HC5', 2),

-- (6, 'MD23', 1),
-- (6, 'MD21', 1),
-- (6, 'C1', 1),
-- (6, 'C2', 2),

-- (7, 'MD23', 1),
-- (7, 'S1', 1),
-- (7, 'S4', 1),
-- (7, 'C3', 1),
-- (7, 'C4', 2),

-- (8, 'MD23', 1),
-- (8, 'L2', 1),
-- (8, 'C3', 1),
-- (8, 'L5', 1),
-- (8, 'C4', 2),
-- (8, 'M1', 1),
-- (8, 'M2', 2),

-- (9, 'MD23', 1),
-- (9, 'M1', 1),
-- (9, 'M4', 1),
-- (9, 'M2', 1),
-- (9, 'M5', 2),
-- (9, 'M6', 1),
-- (9, 'HD1', 2),

-- (10, 'SK3', 1),
-- (10, 'SK6', 1),
-- (10, 'CP1', 1),
-- (10, 'CP2', 1),
-- (10, 'CP3', 2),
-- (10, 'CP4', 1),
-- (10, 'CP5', 2),

-- (11, 'MD1', 2),
-- (11, 'MD15', 1),
-- (11, 'S3', 2),
-- (11, 'L1', 1),

-- (12, 'MD2', 1),
-- (12, 'MD5', 2),
-- (12, 'MD16', 1),
-- (12, 'S5', 2),
-- (12, 'L2', 1),
-- (12, 'HC2', 2),

-- (13, 'MD19', 1),
-- (13, 'MD2', 1),
-- (13, 'MD4', 1),
-- (13, 'S6', 2),
-- (13, 'L3', 1),
-- (13, 'HC3', 2),

-- (14, 'MD23', 1),
-- (14, 'MD9', 1),
-- (14, 'L2', 2),
-- (14, 'C3', 1),
-- (14, 'HC4', 2),

-- (15, 'MD23', 1),
-- (15, 'S1', 1),
-- (15, 'S8', 2),
-- (15, 'L5', 1),
-- (15, 'HC5', 2),

-- (16, 'MD23', 1),
-- (16, 'MD21', 1),
-- (16, 'C1', 1),
-- (16, 'C2', 2),

-- (17, 'MD23', 1),
-- (17, 'MD41', 1),
-- (17, 'S4', 1),
-- (17, 'C3', 1),
-- (17, 'C4', 2),

-- (18, 'MD23', 1),
-- (18, 'MD32', 1),
-- (18, 'MD33', 1),
-- (18, 'L5', 1),
-- (18, 'C4', 2),
-- (18, 'M1', 1),
-- (18, 'M2', 2),

-- (19, 'MD23', 1),
-- (19, 'M1', 1),
-- (19, 'M4', 1),
-- (19, 'MD29', 1),
-- (19, 'M5', 2),
-- (19, 'M6', 1),
-- (19, 'HD1', 2),

-- (20, 'MD42', 1),
-- (20, 'SK6', 1),
-- (20, 'CP1', 1),
-- (20, 'CP2', 1),
-- (20, 'CP3', 2),
-- (20, 'CP4', 1),
-- (20, 'CP5', 2),

-- (21, 'MD1', 2),
-- (21, 'MD15', 1),
-- (21, 'S3', 2),
-- (21, 'S1', 1),

-- (22, 'MD2', 1),
-- (22, 'MD5', 2),
-- (22, 'MD16', 1),
-- (22, 'S5', 2),
-- (22, 'SK2', 1),
-- (22, 'HC2', 2),

-- (23, 'MD9', 1),
-- (23, 'MD21', 1),
-- (23, 'M6', 1),
-- (23, 'SK6', 2),
-- (23, 'L9', 1),
-- (23, 'HC5', 2),

-- (24, 'MD23', 1),
-- (24, 'HD2', 1),
-- (24, 'MD2', 2),
-- (24, 'M3', 1),
-- (24, 'HC1', 2),

-- (25, 'MD2', 1),
-- (25, 'MD21', 1),
-- (25, 'MD8', 2),
-- (25, 'L5', 1),
-- (25, 'HC5', 2),

-- (26, 'MD23', 1),
-- (26, 'MD21', 1),
-- (26, 'C1', 1),
-- (26, 'C2', 2),

-- (27, 'MD23', 1),
-- (27, 'MD11', 1),
-- (27, 'MD4', 1),
-- (27, 'C3', 1),
-- (27, 'C4', 2),

-- (28, 'MD23', 1),
-- (28, 'MD22', 1),
-- (28, 'M3', 1),
-- (28, 'CP5', 1),
-- (28, 'SK4', 2),
-- (28, 'M1', 1),
-- (28, 'MD2', 2),

-- (29, 'MD23', 1),
-- (29, 'M1', 1),
-- (29, 'M4', 1),
-- (29, 'MD2', 1),
-- (29, 'M5', 2),
-- (29, 'CP1', 1),
-- (29, 'HD1', 2),

-- (30, 'MD3', 1),
-- (30, 'MD6', 1),
-- (30, 'MD11', 1),
-- (30, 'MD22', 1),
-- (30, 'CP3', 2),
-- (30, 'CP4', 1),
-- (30, 'CP5', 2)
-- ON CONFLICT DO NOTHING;

-- kitchen
-- INSERT INTO kitchen (table_id, item_id, quantity, time_submitted, time_ended) VALUES	
	
-- (6, 'SK3', 4, '2023-10-03 18:45:00', '2023-10-03 18:46:00'),
-- (6, 'CP2', 3, '2023-10-03 18:45:00', '2023-10-03 18:46:00'),
-- (5, 'S3', 5, '2023-10-03 20:00:00', '2023-10-03 20:46:00'), 
-- (5, 'MD15', 2, '2023-10-03 14:45:00', '2023-10-03 14:46:00'),
-- (1, 'MD1', 1, '2023-09-28 22:45:00', '2023-09-28 23:00:00'),
-- (1, 'MD15', 2, '2023-09-28 22:45:00', '2023-09-28 23:00:00'),
-- (1, 'S3', 1, '2023-09-28 22:45:00', '2023-09-28 23:00:00'), 
-- (1, 'L1', 1, '2023-09-28 22:45:00', '2023-09-28 23:00:00'),
-- (5, 'MD2', 1, '2023-09-28 19:00:00', '2023-09-28 19:15:00'),
-- (5, 'MD5', 1, '2023-09-28 19:00:00', '2023-09-28 19:15:00'),
-- (5, 'MD16', 1, '2023-09-28 19:00:00', '2023-09-28 19:15:00'), 
-- (5, 'S5', 1, '2023-09-28 19:00:00', '2023-09-28 19:15:00'),
-- (5, 'L2', 2, '2023-09-28 19:00:00', '2023-09-28 19:15:00'),
-- (5, 'HC2', 1, '2023-09-28 19:00:00', '2023-09-28 19:15:00'),
-- (2, 'MD19', 2, '2023-09-29 22:45:00', '2023-09-29 23:00:00'), 
-- (2, 'MD2', 1, '2023-09-29 22:45:00', '2023-09-29 23:00:00'),
-- (2, 'MD4', 2, '2023-09-29 22:45:00', '2023-09-29 23:00:00'),
-- (2, 'S6', 2, '2023-09-29 22:45:00', '2023-09-29 23:00:00'),
-- (2, 'L3', 1, '2023-09-29 22:45:00', '2023-09-29 23:00:00'), 
-- (2, 'HC3', 1, '2023-09-29 22:45:00', '2023-09-29 23:00:00')
-- ON CONFLICT DO NOTHING;

-- INSERT INTO kitchen (table_id, item_id, quantity, time_submitted) VALUES	
-- (10, 'MD23', 1, '2023-10-06 10:45:00'),
-- (10, 'MD2', 1, '2023-10-06 10:45:00'),
-- (6, 'MD22', 1, '2023-10-06 14:45:00'), 
-- (6, 'CP5', 2, '2023-10-06 14:45:00')
-- ON CONFLICT DO NOTHING;
