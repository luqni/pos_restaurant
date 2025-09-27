-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: restaurantdb
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table "Table_Availability"
--

DROP TABLE IF EXISTS "Table_Availability";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "Table_Availability" (
  "availability_id" int NOT NULL SERIAL,
  "table_id" int DEFAULT NULL,
  "reservation_date" date DEFAULT NULL,
  "reservation_time" time DEFAULT NULL,
  "status" varchar(20) DEFAULT NULL,
  PRIMARY KEY ("availability_id"),
  KEY "table_id" ("table_id"),
  CONSTRAINT "Table_Availability_ibfk_1" FOREIGN KEY ("table_id") REFERENCES "restaurant_tables" ("table_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "Table_Availability"
--

LOCK TABLES "Table_Availability" WRITE;
/*!40000 ALTER TABLE "Table_Availability" DISABLE KEYS */;
/*!40000 ALTER TABLE "Table_Availability" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "accounts"
--

DROP TABLE IF EXISTS "accounts";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "accounts" (
  "account_id" int NOT NULL SERIAL,
  "email" varchar(255) DEFAULT NULL,
  "register_date" date DEFAULT NULL,
  "phone_number" varchar(255) DEFAULT NULL,
  "password" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("account_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "accounts"
--

LOCK TABLES "accounts" WRITE;
/*!40000 ALTER TABLE "accounts" DISABLE KEYS */;
INSERT INTO "accounts" VALUES (1,'john@gmail.com','2023-08-31','+1234567890','password123'),(2,'susan@gmail.com','2023-08-30','+1987654321','susanpassword'),(3,'james@gmail.com','2023-08-29','+18887776666','jamespass'),(4,'alice@gmail.com','2023-08-28','+15555555555','alicepassword'),(5,'mike@gmail.com','2023-08-27','+14444444444','mikepass'),(6,'lisa@gmail.com','2023-08-26','+13333333333','lisapassword'),(7,'robert@gmail.com','2023-08-25','+12222222222','robertpass'),(8,'emily@gmail.com','2023-08-24','+16666666666','emilypassword'),(9,'david@gmail.com','2023-08-23','+1993219999','davidp321ass'),(10,'ddwd@gmail.com','2023-08-23','+1999999329999','davidpa2ss'),(11,'dadsvawvid@gmail.com','2023-08-23','+12234132199','david4pass'),(12,'davdavid@gmail.com','2023-08-23','+123239999','davidp13ass'),(13,'davvdasid@gmail.com','2023-08-23','+1995324319999','david2pass'),(14,'321david@gmail.com','2023-08-23','+1942199999','davidpa52ss'),(15,'32avid@gmail.com','2023-08-23','+1942193429999','da2332ss'),(16,'321da543vid@gmail.com','2023-08-23','+1942132199999','dav43a52ss'),(17,'3211234avid@gmail.com','2023-08-23','+194213599999','32533pa52ss'),(18,'321543avid@gmail.com','2023-08-23','+1942154399999','754dpa52ss'),(19,'rbsjsd@gmail.com','2023-08-23','+131351241239','41f2s'),(20,'ol435143ivia@gmail.com','2023-08-22','+18888888888','oliviapass4215word'),(21,'robber@gmail.com','2023-09-01','+1234567890','password123'),(22,'jean@gmail.com','2023-09-02','+2345678901','password456'),(23,'emily@gmail.com','2023-09-03','+3456789012','password789'),(24,'robert@gmail.com','2023-09-04','+4567890123','passwordabc'),(25,'zoe@gmail.com','2023-09-05','+5678901234','passworddef'),(26,'lisa@gmail.com','2023-09-06','+6789012345','passwordghi'),(27,'taylor@gmail.com','2023-09-07','+7890123456','passwordjkl'),(28,'stephan@gmail.com','2023-09-08','+8901234567','passwordmno'),(29,'bruce@gmail.com','2023-09-09','+9012345678','passwordpqr'),(30,'jackie@gmail.com','2023-09-10','+0123456789','passwordstu');
/*!40000 ALTER TABLE "accounts" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "bill_items"
--

DROP TABLE IF EXISTS "bill_items";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "bill_items" (
  "bill_item_id" int NOT NULL SERIAL,
  "bill_id" int DEFAULT NULL,
  "item_id" varchar(6) DEFAULT NULL,
  "quantity" int DEFAULT NULL,
  PRIMARY KEY ("bill_item_id"),
  KEY "bill_id" ("bill_id"),
  KEY "item_id" ("item_id"),
  CONSTRAINT "bill_items_ibfk_1" FOREIGN KEY ("bill_id") REFERENCES "bills" ("bill_id"),
  CONSTRAINT "bill_items_ibfk_2" FOREIGN KEY ("item_id") REFERENCES "menu" ("item_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "bill_items"
--

LOCK TABLES "bill_items" WRITE;
/*!40000 ALTER TABLE "bill_items" DISABLE KEYS */;
/*!40000 ALTER TABLE "bill_items" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "bills"
--

DROP TABLE IF EXISTS "bills";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "bills" (
  "bill_id" int NOT NULL SERIAL,
  "staff_id" int DEFAULT NULL,
  "member_id" int DEFAULT NULL,
  "reservation_id" int DEFAULT NULL,
  "table_id" int DEFAULT NULL,
  "card_id" int DEFAULT NULL,
  "payment_method" varchar(255) DEFAULT NULL,
  "bill_time" datetime DEFAULT NULL,
  "payment_time" datetime DEFAULT NULL,
  PRIMARY KEY ("bill_id"),
  KEY "staff_id" ("staff_id"),
  KEY "member_id" ("member_id"),
  KEY "reservation_id" ("reservation_id"),
  KEY "table_id" ("table_id"),
  KEY "card_id" ("card_id"),
  CONSTRAINT "bills_ibfk_1" FOREIGN KEY ("staff_id") REFERENCES "staffs" ("staff_id"),
  CONSTRAINT "bills_ibfk_2" FOREIGN KEY ("member_id") REFERENCES "memberships" ("member_id"),
  CONSTRAINT "bills_ibfk_3" FOREIGN KEY ("reservation_id") REFERENCES "reservations" ("reservation_id"),
  CONSTRAINT "bills_ibfk_4" FOREIGN KEY ("table_id") REFERENCES "restaurant_tables" ("table_id"),
  CONSTRAINT "bills_ibfk_5" FOREIGN KEY ("card_id") REFERENCES "card_payments" ("card_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "bills"
--

LOCK TABLES "bills" WRITE;
/*!40000 ALTER TABLE "bills" DISABLE KEYS */;
INSERT INTO "bills" VALUES (1,1,1,2220231,1,1,'Card','2023-09-28 22:45:00','2023-09-28 22:50:00'),(2,1,5,NULL,5,NULL,'Cash','2023-09-28 19:00:00','2023-09-28 19:05:00'),(3,1,2,2220232,2,2,'Card','2023-09-29 22:45:00','2023-09-29 22:50:00'),(4,2,3,1920233,3,NULL,'Cash','2023-09-30 20:15:00','2023-09-30 20:20:00'),(5,2,4,2020234,4,3,'Card','2023-09-30 20:30:00','2023-09-30 20:35:00'),(6,2,8,NULL,6,NULL,'Cash','2023-09-30 20:15:00','2023-09-30 20:20:00'),(7,3,5,1920235,5,NULL,'Cash','2023-10-01 20:15:00','2023-10-01 20:20:00'),(8,3,6,NULL,7,NULL,'Cash','2023-10-01 19:00:00','2023-10-01 19:05:00'),(9,3,18,NULL,2,NULL,'Cash','2023-10-01 18:30:00','2023-10-01 18:35:00'),(10,4,7,NULL,9,NULL,'Cash','2023-10-02 19:30:00','2023-10-02 19:35:00'),(11,4,17,NULL,8,NULL,'Cash','2023-10-02 20:00:00','2023-10-02 20:05:00'),(12,4,8,NULL,10,4,'Card','2023-10-02 19:00:00','2023-10-02 19:05:00'),(13,5,9,1820237,6,5,'Card','2023-10-03 18:45:00','2023-10-03 18:50:00'),(14,5,16,NULL,9,NULL,'Cash','2023-10-03 19:45:00','2023-10-03 19:50:00'),(15,5,10,NULL,5,NULL,'Cash','2023-10-03 20:00:00','2023-10-03 20:05:00'),(16,6,11,NULL,4,6,'Card','2023-10-03 20:15:00','2023-10-03 20:20:00'),(17,6,8,NULL,10,NULL,'Cash','2023-10-03 20:30:00','2023-10-03 20:35:00'),(18,6,12,NULL,3,7,'Card','2023-10-04 19:30:00','2023-10-04 19:35:00'),(19,7,13,NULL,2,NULL,'Cash','2023-10-04 19:15:00','2023-10-04 19:20:00'),(20,7,14,1920239,1,NULL,'Cash','2023-10-05 20:30:00','2023-10-05 20:35:00'),(21,7,1,NULL,6,NULL,'Cash','2023-10-05 14:00:00','2023-10-05 14:05:00'),(22,8,15,NULL,8,8,'Card','2023-10-05 20:45:00','2023-10-05 20:50:00'),(23,8,16,NULL,7,NULL,'Cash','2023-10-05 20:00:00','2023-10-05 20:05:00'),(24,8,2,NULL,9,NULL,'Cash','2023-10-05 19:30:00','2023-10-05 19:35:00'),(25,8,9,NULL,4,NULL,'Cash','2023-10-05 20:15:00','2023-10-05 20:20:00'),(26,9,17,NULL,9,9,'Card','2023-10-05 12:00:00','2023-10-05 12:05:00'),(27,9,18,NULL,10,10,'Card','2023-10-06 13:15:00','2023-10-06 13:20:00'),(28,9,19,14202310,8,NULL,'Cash','2023-10-06 14:30:00','2023-10-06 14:35:00'),(29,10,7,NULL,10,NULL,'Cash','2023-10-06 10:45:00','2023-10-06 10:50:00'),(30,10,20,NULL,6,NULL,'Cash','2023-10-06 14:45:00','2023-10-06 14:50:00');
/*!40000 ALTER TABLE "bills" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "card_payments"
--

DROP TABLE IF EXISTS "card_payments";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "card_payments" (
  "card_id" int NOT NULL SERIAL,
  "account_holder_name" varchar(255) NOT NULL,
  "card_number" varchar(16) NOT NULL,
  "expiry_date" varchar(7) NOT NULL,
  "security_code" varchar(3) NOT NULL,
  PRIMARY KEY ("card_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "card_payments"
--

LOCK TABLES "card_payments" WRITE;
/*!40000 ALTER TABLE "card_payments" DISABLE KEYS */;
INSERT INTO "card_payments" VALUES (1,'John Smith','1234567890123456','10/15','123'),(2,'Susan Johnson','2345678901234567','10/24','456'),(3,'James Brown','3456789012345678','09/30','789'),(4,'Alice Davis','4567890123456789','09/28','321'),(5,'Mike Wilson','5678901234567890','09/29','654'),(6,'Robert Miller','7890123456789012','10/19','123'),(7,'Abbel TuTuTu','1234123412341234','10/25','654'),(8,'Abignail Downey','2345234523452345','10/24','987'),(9,'Jamie Mustafa','3456345634563456','09/23','123'),(10,'Luke Gun Slinger','4567456745674567','09/22','456');
/*!40000 ALTER TABLE "card_payments" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "kitchen"
--

DROP TABLE IF EXISTS "kitchen";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "kitchen" (
  "kitchen_id" int NOT NULL SERIAL,
  "table_id" int DEFAULT NULL,
  "item_id" varchar(6) DEFAULT NULL,
  "quantity" int DEFAULT NULL,
  "time_submitted" datetime DEFAULT NULL,
  "time_ended" datetime DEFAULT NULL,
  PRIMARY KEY ("kitchen_id"),
  KEY "table_id" ("table_id"),
  KEY "item_id" ("item_id"),
  CONSTRAINT "kitchen_ibfk_1" FOREIGN KEY ("table_id") REFERENCES "restaurant_tables" ("table_id"),
  CONSTRAINT "kitchen_ibfk_2" FOREIGN KEY ("item_id") REFERENCES "menu" ("item_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "kitchen"
--

LOCK TABLES "kitchen" WRITE;
/*!40000 ALTER TABLE "kitchen" DISABLE KEYS */;
/*!40000 ALTER TABLE "kitchen" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "memberships"
--

DROP TABLE IF EXISTS "memberships";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "memberships" (
  "member_id" int NOT NULL SERIAL,
  "member_name" varchar(255) DEFAULT NULL,
  "points" int DEFAULT NULL,
  "account_id" int DEFAULT NULL,
  PRIMARY KEY ("member_id"),
  KEY "account_id" ("account_id"),
  CONSTRAINT "memberships_ibfk_1" FOREIGN KEY ("account_id") REFERENCES "accounts" ("account_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "memberships"
--

LOCK TABLES "memberships" WRITE;
/*!40000 ALTER TABLE "memberships" DISABLE KEYS */;
INSERT INTO "memberships" VALUES (1,'Abbel TuTuTu',100,11),(2,'Abignail Downey ',200,12),(3,'Jamie Mustafa',300,13),(4,'Luke Gun Slinger',400,14),(5,'Johny Rings',500,15),(6,'Wee Tuu Low',600,16),(7,'Sum Ting Wong',700,17),(8,'Ho Lee Fuk',800,18),(9,'Bang Ding Ow',900,19),(10,'Rocky Rocket',1000,20),(11,'Robber Hellington',250,21),(12,'Jean Ng',300,22),(13,'Emily Davis',400,23),(14,'Robert Wilson',550,24),(15,'Zoe Chong',650,25),(16,'Lisa Chia',750,26),(17,'Taylor Swift',900,27),(18,'Stephan Curry',1050,28),(19,'Bruce Lee',1200,29),(20,'Jackie Chan',1350,30);
/*!40000 ALTER TABLE "memberships" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "menu"
--

DROP TABLE IF EXISTS "menu";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "menu" (
  "item_id" varchar(6) NOT NULL,
  "item_name" varchar(255) DEFAULT NULL,
  "item_type" varchar(255) DEFAULT NULL,
  "item_category" varchar(255) DEFAULT NULL,
  "item_price" decimal(10,2) DEFAULT NULL,
  "item_description" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("item_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "menu"
--

LOCK TABLES "menu" WRITE;
/*!40000 ALTER TABLE "menu" DISABLE KEYS */;
INSERT INTO "menu" VALUES ('AS1','Beef Bulgogi','Asian Food','Main Dishes',42.00,'Hidangan Korea dengan daging sapi manis gurih'),('AS2','Chicken Teriyaki','Asian Food','Main Dishes',35.00,'Ayam panggang saus teriyaki khas Jepang'),('AS3','Ramen Ayam','Asian Food','Main Dishes',30.00,'Mie kuah Jepang dengan ayam halal'),('AS4','Tom Yum Goong','Asian Food','Main Dishes',38.00,'Sup pedas asam khas Thailand dengan udang'),('AS5','Pad Thai','Asian Food','Main Dishes',32.00,'Mie goreng khas Thailand'),('AS6','Dimsum Halal','Asian Food','Main Dishes',28.00,'Aneka dimsum halal ayam dan udang'),('DR1','Teh Tarik','Drinks','Drinks',10.00,'Teh susu tarik khas Asia'),('DR2','Es Teh Manis','Drinks','Drinks',5.00,'Teh manis dingin'),('DR3','Es Jeruk','Drinks','Drinks',6.00,'Jeruk peras segar'),('DR4','Jus Alpukat','Drinks','Drinks',18.00,'Jus alpukat kental dengan coklat'),('DR5','Air Mineral','Drinks','Drinks',3.00,'Air mineral dingin'),('DS1','Es Cendol','Dessert','Side Snacks',15.00,'Minuman segar khas Indonesia'),('DS2','Klepon','Dessert','Side Snacks',12.00,'Kue tradisional isi gula merah'),('DS3','Baklava','Dessert','Side Snacks',18.00,'Kue manis khas Timur Tengah'),('DS4','Kue Lumpur','Dessert','Side Snacks',12.00,'Kue tradisional manis dan lembut'),('ID1','Nasi Goreng Spesial','Indonesian Food','Main Dishes',28.00,'Nasi goreng dengan telur, ayam, dan sate'),('ID2','Sate Ayam','Indonesian Food','Main Dishes',32.00,'Tusuk sate ayam dengan bumbu kacang'),('ID3','Sop Buntut','Indonesian Food','Main Dishes',45.00,'Sup buntut sapi khas Indonesia'),('ID4','Ayam Penyet','Indonesian Food','Main Dishes',30.00,'Ayam goreng sambal terasi'),('ID5','Rendang Daging','Indonesian Food','Main Dishes',48.00,'Rendang sapi khas Minang'),('ID6','Ikan Bakar Jimbaran','Indonesian Food','Main Dishes',42.00,'Ikan bakar bumbu khas Bali'),('ME1','Nasi Mandhi Ayam','Middle Eastern','Main Dishes',40.00,'Nasi berbumbu khas Yaman dengan ayam'),('ME2','Nasi Biryani Kambing','Middle Eastern','Main Dishes',55.00,'Nasi biryani dengan kambing'),('ME3','Shawarma Daging','Middle Eastern','Main Dishes',32.00,'Shawarma daging sapi dengan saus tahini'),('ME4','Chicken Kebab','Middle Eastern','Main Dishes',35.00,'Kebab ayam panggang dengan roti pita'),('ME5','Lamb Kebab','Middle Eastern','Main Dishes',45.00,'Kebab daging kambing panggang'),('ME6','Hummus & Falafel','Middle Eastern','Main Dishes',28.00,'Hummus dengan falafel goreng'),('SD1','Kentang Goreng','Side Dishes','Side Snacks',12.00,'Kentang goreng renyah'),('SD2','Tahu Isi','Side Dishes','Side Snacks',10.00,'Tahu goreng isi sayuran pedas'),('SD3','Bakwan Jagung','Side Dishes','Side Snacks',10.00,'Bakwan jagung renyah'),('SD4','Hummus dengan Pita','Side Dishes','Side Snacks',18.00,'Roti pita dengan hummus');
/*!40000 ALTER TABLE "menu" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "reservations"
--

DROP TABLE IF EXISTS "reservations";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "reservations" (
  "reservation_id" int NOT NULL SERIAL,
  "customer_name" varchar(255) DEFAULT NULL,
  "table_id" int DEFAULT NULL,
  "reservation_time" time DEFAULT NULL,
  "reservation_date" date DEFAULT NULL,
  "head_count" int DEFAULT NULL,
  "special_request" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("reservation_id"),
  KEY "table_id" ("table_id"),
  CONSTRAINT "reservations_ibfk_1" FOREIGN KEY ("table_id") REFERENCES "restaurant_tables" ("table_id")
)f8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "reservations"
--

LOCK TABLES "reservations" WRITE;
/*!40000 ALTER TABLE "reservations" DISABLE KEYS */;
INSERT INTO "reservations" VALUES (1111111,'Default',9,'19:15:00','2023-10-05',2,'Description'),(1820237,'Jean Ng',7,'18:30:00','2023-10-03',2,'Allergies: peanuts'),(1920233,'Jamie Mustafa',3,'19:30:00','2023-09-30',2,'Vegan options needed'),(1920235,'Johny Rings',5,'19:45:00','2023-10-01',2,'Quiet corner, please'),(1920239,'Taylor Swift',9,'19:15:00','2023-10-05',2,'Surprise dessert for anniversary'),(2020234,'Luke Gun Slinger',4,'20:00:00','2023-09-30',3,'Birthday celebration'),(2220231,'Abbel Tu Far Behind',1,'22:00:34','2023-09-28',1,'Prepare Panadol for me'),(2220232,'Abignaile Lin Downney Jr',2,'22:00:34','2023-09-29',1,'Default Special Request'),(14202310,'Bruce Lee',10,'14:45:00','2023-10-06',3,'Window seat, if available');
/*!40000 ALTER TABLE "reservations" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "restaurant_tables"
--

DROP TABLE IF EXISTS "restaurant_tables";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "restaurant_tables" (
  "table_id" int NOT NULL SERIAL,
  "capacity" int DEFAULT NULL,
  "is_available" tinyint(1) DEFAULT NULL,
  PRIMARY KEY ("table_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "restaurant_tables"
--

LOCK TABLES "restaurant_tables" WRITE;
/*!40000 ALTER TABLE "restaurant_tables" DISABLE KEYS */;
INSERT INTO "restaurant_tables" VALUES (1,4,1),(2,4,1),(3,4,1),(4,6,1),(5,6,1),(6,6,1),(7,6,1),(8,8,1),(9,8,1),(10,8,1);
/*!40000 ALTER TABLE "restaurant_tables" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "staffs"
--

DROP TABLE IF EXISTS "staffs";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "staffs" (
  "staff_id" int NOT NULL SERIAL,
  "staff_name" varchar(255) DEFAULT NULL,
  "role" varchar(255) DEFAULT NULL,
  "account_id" int DEFAULT NULL,
  PRIMARY KEY ("staff_id"),
  KEY "account_id" ("account_id"),
  CONSTRAINT "staffs_ibfk_1" FOREIGN KEY ("account_id") REFERENCES "accounts" ("account_id")
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "staffs"
--

LOCK TABLES "staffs" WRITE;
/*!40000 ALTER TABLE "staffs" DISABLE KEYS */;
INSERT INTO "staffs" VALUES (1,'John Smith','Waiter',1),(2,'Susan Johnson','Waiter',2),(3,'James Brown','Waiter',3),(4,'Alice Davis','Waiter',4),(5,'Mike Wilson','Waiter',5),(6,'Lisa Martinez','Chef',6),(7,'Robert Miller','Manager',7),(8,'Emily Moore','Manager',8),(9,'David Taylor','Chef',9),(10,'Olivia Anderson','Chef',10);
/*!40000 ALTER TABLE "staffs" ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-27 18:41:51
