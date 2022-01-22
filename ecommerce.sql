-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `line1` varchar(60) NOT NULL,
  `line2` varchar(60) DEFAULT NULL,
  `city` varchar(40) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `phone` varchar(12) NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `addresses_fk_customers` (`customer_id`),
  CONSTRAINT `addresses_fk_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (4,3,'19270 NW Cornell Rd.','','Beaverton','OR','97006','503-654-1291'),(5,4,'186 Vermont St.','Apt. 2','San Francisco','CA','94110','415-292-6651'),(6,4,'1374 46th Ave.','','San Francisco','CA','94129','415-292-6651'),(7,5,'6982 Palm Ave.','','Fresno','CA','93711','559-431-2398'),(8,6,'23 Mountain View St.','','Denver','CO','80208','303-912-3852'),(9,7,'7361 N. 41st St.','Apt. B','New York','NY','10012','212-335-2093'),(10,7,'3829 Broadway Ave.','Suite 2','New York','NY','10012','212-239-1208'),(11,8,'2381 Buena Vista St.','','Los Angeles','CA','90023','213-772-5033'),(12,8,'291 W. Hollywood Blvd.','','Los Angeles','CA','90024','213-391-2938'),(32,17,'12376',NULL,'Chandigarh','CH','123123','1231231231');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'fashion',NULL),(2,'jewelery',NULL),(3,'Drums',NULL),(4,'electronics',NULL),(12,'Jewellery','10.png'),(13,'asdasd','5.png'),(14,'Sport','13.jpg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cred`
--

DROP TABLE IF EXISTS `cred`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cred` (
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `root_access` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cred`
--

LOCK TABLES `cred` WRITE;
/*!40000 ALTER TABLE `cred` DISABLE KEYS */;
INSERT INTO `cred` VALUES ('skandwal@gmail.com','root',1),('ssingh@gmail.com','noroot',0),('sk@gmail.com','pass',1);
/*!40000 ALTER TABLE `cred` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) NOT NULL,
  `password` varchar(60) NOT NULL,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(60) DEFAULT NULL,
  `shipping_address_id` int DEFAULT NULL,
  `billing_address_id` int DEFAULT NULL,
  `root_access` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email_address` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'allan.sherwood@yahoo.com','650215acec746f0e32bdfff387439eefc1358737','Allan','Sherwood',1,2,0),(2,'barryz@gmail.com','3f563468d42a448cb1e56924529f6e7bbe529cc7','Barry','Zimmer',3,3,0),(3,'christineb@solarone.com','ed19f5c0833094026a2f1e9e6f08a35d26037066','Christine','Brown',4,4,0),(4,'david.goldstein@hotmail.com','b444ac06613fc8d63795be9ad0beaf55011936ac','David','Goldstein',5,6,0),(5,'erinv@gmail.com','109f4b3c50d7b0df729d299bc6f8e9ef9066971f','Erin','Valentino',7,7,0),(6,'frankwilson@sbcglobal.net','3ebfa301dc59196f18593c45e519287a23297589','Frank Lee','Wilson',8,8,0),(7,'gary_hernandez@yahoo.com','1ff2b3704aede04eecb51e50ca698efd50a1379b','Gary','Hernandez',9,10,0),(8,'heatheresway@mac.com','911ddc3b8f9a13b5499b6bc4638a2b4f3f68bf23','Heather','Esway',11,12,0),(14,'skandwal@gmail.com','root@','Shubham','Kandwal',NULL,NULL,1),(15,'ssingh@gmail.com','noroot@','Shubham','Singh',NULL,NULL,0),(17,'riya@gmail.com','riya@123','Riya','Gupta',NULL,NULL,0);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `items_fk_products` (`product_id`),
  KEY `items_fk_orders` (`order_id`),
  CONSTRAINT `items_fk_orders` FOREIGN KEY (`order_id`) REFERENCES `orders_ecom` (`order_id`),
  CONSTRAINT `items_fk_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (32,13,1,109.95,1),(33,13,2,22.30,1),(34,16,1,699.00,1),(35,16,3,2517.00,1),(36,17,1,699.00,1),(37,17,2,1199.00,1);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `ship_amount` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL,
  `ship_date` datetime DEFAULT NULL,
  `ship_address_id` int NOT NULL,
  `card_type` varchar(50) NOT NULL,
  `card_number` char(16) NOT NULL,
  `card_expires` char(7) NOT NULL,
  `billing_address_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_fk_customers` (`customer_id`),
  CONSTRAINT `orders_fk_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2018-03-28 09:40:28',5.00,32.32,'2018-03-30 15:32:51',1,'Visa','4111111111111111','04/2020',2),(2,2,'2018-03-28 11:23:20',5.00,0.00,'2018-03-29 12:52:14',3,'Visa','4012888888881881','08/2019',3),(3,1,'2018-03-29 09:44:58',10.00,89.92,'2018-03-31 09:11:41',1,'Visa','4111111111111111','04/2017',2),(4,3,'2018-03-30 15:22:31',5.00,0.00,'2018-04-03 16:32:21',4,'American Express','378282246310005','04/2016',4),(5,4,'2018-03-31 05:43:11',5.00,0.00,'2018-04-02 14:21:12',5,'Visa','4111111111111111','04/2019',6),(6,5,'2018-03-31 18:37:22',5.00,0.00,NULL,7,'Discover','6011111111111117','04/2019',7),(7,6,'2018-04-01 23:11:12',15.00,0.00,'2018-04-03 10:21:35',8,'MasterCard','5555555555554444','04/2019',8),(8,7,'2018-04-02 11:26:38',5.00,0.00,NULL,9,'Visa','4012888888881881','04/2019',10),(9,4,'2018-04-03 12:22:31',5.00,0.00,NULL,5,'Visa','4111111111111111','04/2019',6);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_ecom`
--

DROP TABLE IF EXISTS `orders_ecom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_ecom` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_total` decimal(10,2) NOT NULL,
  `ship_address_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_ecom`
--

LOCK TABLES `orders_ecom` WRITE;
/*!40000 ALTER TABLE `orders_ecom` DISABLE KEYS */;
INSERT INTO `orders_ecom` VALUES (11,14,'2021-12-15 23:56:40',132.25,27),(12,14,'2021-12-16 00:00:34',132.25,28),(13,14,'2021-12-16 00:08:11',132.25,29),(14,15,'2021-12-16 02:37:49',3216.00,30),(15,15,'2021-12-16 02:39:48',3216.00,31),(16,15,'2021-12-16 02:40:23',3216.00,32),(17,17,'2021-12-16 02:51:51',1898.00,33);
/*!40000 ALTER TABLE `orders_ecom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `product_code` varchar(10) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `list_price` decimal(10,2) NOT NULL,
  `date_added` datetime DEFAULT CURRENT_TIMESTAMP,
  `image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_code` (`product_code`),
  KEY `products_fk_categories` (`category_id`),
  CONSTRAINT `products_fk_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,'strat','Fender Stratocaster','The Fender Stratocaster is the electric guitar design that changed the world. New features include a tinted neck, parchment pickguard and control knobs, and a \'70s-style logo. Includes select alder body, 21-fret maple neck with your choice of a rosewood or maple fretboard, 3 single-coil pickups, vintage-style tremolo, and die-cast tuning keys. This guitar features a thicker bridge block for increased sustain and a more stable point of contact with the strings. At this low price, why play anything but the real thing?\r\n\r\nFeatures:\r\n\r\n* New features:\r\n* Thicker bridge block\r\n* 3-ply parchment pick guard\r\n* Tinted neck',699.00,'2017-10-30 09:32:40','2.jpg'),(2,1,'les_paul','Gibson Les Paul','This Les Paul guitar offers a carved top and humbucking pickups. It has a simple yet elegant design. Cutting-yet-rich tone?the hallmark of the Les Paul?pours out of the 490R and 498T Alnico II magnet humbucker pickups, which are mounted on a carved maple top with a mahogany back. The faded finish models are equipped with BurstBucker Pro pickups and a mahogany top. This guitar includes a Gibson hardshell case (Faded and satin finish models come with a gig bag) and a limited lifetime warranty.\r\n\r\nFeatures:\r\n\r\n* Carved maple top and mahogany back (Mahogany top on faded finish models)\r\n* Mahogany neck, \'59 Rounded Les Paul\r\n* Rosewood fingerboard (Ebony on Alpine white)\r\n* Tune-O-Matic bridge with stopbar\r\n* Chrome or gold hardware\r\n* 490R and 498T Alnico 2 magnet humbucker pickups (BurstBucker Pro on faded finish models)\r\n* 2 volume and 2 tone knobs, 3-way switch',1199.00,'2017-12-05 16:33:13','1.jpg'),(3,2,'sg','Gibson SG','This Gibson SG electric guitar takes the best of the \'62 original and adds the longer and sturdier neck joint of the late \'60s models. All the classic features you\'d expect from a historic guitar. Hot humbuckers go from rich, sweet lightning to warm, tingling waves of sustain. A silky-fast rosewood fretboard plays like a dream. The original-style beveled mahogany body looks like a million bucks. Plus, Tune-O-Matic bridge and chrome hardware. Limited lifetime warranty. Includes hardshell case.\r\n\r\nFeatures:\r\n\r\n* Double-cutaway beveled mahogany body\r\n* Set mahogany neck with rounded \'50s profile\r\n* Bound rosewood fingerboard with trapezoid inlays\r\n* Tune-O-Matic bridge with stopbar tailpiece\r\n* Chrome hardware\r\n* 490R humbucker in the neck position\r\n* 498T humbucker in the bridge position\r\n* 2 volume knobs, 2 tone knobs, 3-way switch\r\n* 24-3/4\" scale',2517.00,'2018-02-04 11:04:31','6.jpg'),(4,2,'fg700s','Yamaha FG700S','The Yamaha FG700S solid top acoustic guitar has the ultimate combo for projection and pure tone. The expertly braced spruce top speaks clearly atop the rosewood body. It has a rosewood fingerboard, rosewood bridge, die-cast tuners, body and neck binding, and a tortoise pickguard.\r\n\r\nFeatures:\r\n\r\n* Solid Sitka spruce top\r\n* Rosewood back and sides\r\n* Rosewood fingerboard\r\n* Rosewood bridge\r\n* White/black body and neck binding\r\n* Die-cast tuners\r\n* Tortoise pickguard\r\n* Limited lifetime warranty',489.99,'2018-06-01 11:12:59','5.jpg'),(5,1,'washburn','Washburn D10S','The Washburn D10S acoustic guitar is superbly crafted with a solid spruce top and mahogany back and sides for exceptional tone. A mahogany neck and rosewood fingerboard make fretwork a breeze, while chrome Grover-style machines keep you perfectly tuned. The Washburn D10S comes with a limited lifetime warranty.\r\n\r\nFeatures:\r\n\r\n    * Spruce top\r\n    * Mahogany back, sides\r\n    * Mahogany neck Rosewood fingerboard\r\n    * Chrome Grover-style machines',299.00,'2018-07-30 13:58:35','15.jpg'),(6,1,'rodriguez','Rodriguez Caballero 11','Featuring a carefully chosen, solid Canadian cedar top and laminated bubinga back and sides, the Caballero 11 classical guitar is a beauty to behold and play. The headstock and fretboard are of Indian rosewood. Nickel-plated tuners and Silver-plated frets are installed to last a lifetime. The body binding and wood rosette are exquisite.\r\n\r\nThe Rodriguez Guitar is hand crafted and glued to create precise balances. From the invisible careful sanding, even inside the body, that ensures the finished instrument\'s purity of tone, to the beautifully unique rosette inlays around the soundhole and on the back of the neck, each guitar is a credit to its luthier and worthy of being handed down from one generation to another.\r\n\r\nThe tone, resonance and beauty of fine guitars are all dependent upon the wood from which they are made. The wood used in the construction of Rodriguez guitars is carefully chosen and aged to guarantee the highest quality. No wood is purchased before the tree has been cut down, and at least 2 years must elapse before the tree is turned into lumber. The wood has to be well cut from the log. The grain must be close and absolutely vertical. The shop is totally free from humidity.',415.00,'2018-07-30 14:12:41','16.jpg'),(7,4,'precision','Fender Precision','The Fender Precision bass guitar delivers the sound, look, and feel today\'s bass players demand. This bass features that classic P-Bass old-school design. Each Precision bass boasts contemporary features and refinements that make it an excellent value. Featuring an alder body and a split single-coil pickup, this classic electric bass guitar lives up to its Fender legacy.\r\n\r\nFeatures:\r\n\r\n* Body: Alder\r\n* Neck: Maple, modern C shape, tinted satin urethane finish\r\n* Fingerboard: Rosewood or maple (depending on color)\r\n* 9-1/2\" Radius (241 mm)\r\n* Frets: 20 Medium-jumbo frets\r\n* Pickups: 1 Standard Precision Bass split single-coil pickup (Mid)\r\n* Controls: Volume, Tone\r\n* Bridge: Standard vintage style with single groove saddles\r\n* Machine heads: Standard\r\n* Hardware: Chrome\r\n* Pickguard: 3-Ply Parchment\r\n* Scale Length: 34\" (864 mm)\r\n* Width at Nut: 1-5/8\" (41.3 mm)\r\n* Unique features: Knurled chrome P Bass knobs, Fender transition logo',799.99,'2018-06-01 11:29:35','10.jpg'),(8,4,'hofner','Hofner Icon','With authentic details inspired by the original, the Hofner Icon makes the legendary violin bass available to the rest of us. Don\'t get the idea that this a just a \"nowhere man\" look-alike. This quality instrument features a real spruce top and beautiful flamed maple back and sides. The semi-hollow body and set neck will give you the warm, round tone you expect from the violin bass.\r\n\r\nFeatures:\r\n\r\n* Authentic details inspired by the original\r\n* Spruce top\r\n* Flamed maple back and sides\r\n* Set neck\r\n* Rosewood fretboard\r\n* 30\" scale\r\n* 22 frets\r\n* Dot inlay',499.99,'2018-07-30 14:18:33','11.jpg'),(9,1,'ludwig','Ludwig 5-piece Drum Set with Cymbals','This product includes a Ludwig 5-piece drum set and a Zildjian starter cymbal pack.\r\n\r\nWith the Ludwig drum set, you get famous Ludwig quality. This set features a bass drum, two toms, a floor tom, and a snare?each with a wrapped finish. Drum hardware includes LA214FP bass pedal, snare stand, cymbal stand, hi-hat stand, and a throne.\r\n\r\nWith the Zildjian cymbal pack, you get a 14\" crash, 18\" crash/ride, and a pair of 13\" hi-hats. Sound grooves and round hammer strikes in a simple circular pattern on the top surface of these cymbals magnify the basic sound of the distinctive alloy.\r\n\r\nFeatures:\r\n\r\n* Famous Ludwig quality\r\n* Wrapped finishes\r\n* 22\" x 16\" kick drum\r\n* 12\" x 10\" and 13\" x 11\" toms\r\n* 16\" x 16\" floor tom\r\n* 14\" x 6-1/2\" snare drum kick pedal\r\n* Snare stand\r\n* Straight cymbal stand hi-hat stand\r\n* FREE throne',699.99,'2018-07-30 12:46:40','2.jpg'),(10,1,'tama','Tama 5-Piece Drum Set with Cymbals','The Tama 5-piece Drum Set is the most affordable Tama drum kit ever to incorporate so many high-end features.\r\n\r\nWith over 40 years of experience, Tama knows what drummers really want. Which is why, no matter how long you\'ve been playing the drums, no matter what budget you have to work with, Tama has the set you need, want, and can afford. Every aspect of the modern drum kit was exhaustively examined and reexamined and then improved before it was accepted as part of the Tama design. Which is why, if you start playing Tama now as a beginner, you\'ll still enjoy playing it when you\'ve achieved pro-status. That\'s how good these groundbreaking new drums are.\r\n\r\nOnly Tama comes with a complete set of genuine Meinl HCS cymbals. These high-quality brass cymbals are made in Germany and are sonically matched so they sound great together. They are even lathed for a more refined tonal character. The set includes 14\" hi-hats, 16\" crash cymbal, and a 20\" ride cymbal.\r\n\r\nFeatures:\r\n\r\n* 100% poplar 6-ply/7.5mm shells\r\n* Precise bearing edges\r\n* 100% glued finishes\r\n* Original small lugs\r\n* Drum heads\r\n* Accu-tune bass drum hoops\r\n* Spur brackets\r\n* Tom holder\r\n* Tom brackets',799.99,'2018-07-30 13:14:15','1.jpg'),(11,2,'asd','asd','asd',123.00,'2021-12-16 01:13:13','5.jpg'),(12,1,'123','XYZ','dsa',123.00,'2021-12-16 02:32:21','18.jpg'),(13,1,'T201','T-Shirt','Tshirt for men',145.00,'2021-12-16 02:57:21','19.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-23  2:55:48
