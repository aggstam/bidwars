CREATE DATABASE  IF NOT EXISTS `bidwars_v.2.0` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bidwars_v.2.0`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: bidwars_v.2.0
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` int NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `listing_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKq3pydhv7yalexshtxf00lttq0` (`listing_id`),
  KEY `FK7a01t1vhq8e9lj4k9ljatl0bo` (`user_id`),
  CONSTRAINT `FK7a01t1vhq8e9lj4k9ljatl0bo` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKq3pydhv7yalexshtxf00lttq0` FOREIGN KEY (`listing_id`) REFERENCES `listing` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
INSERT INTO `bid` VALUES (1,151,'2020-09-06 18:26:40.613000',3,1),(2,152,'2020-09-06 18:26:54.063000',3,1),(3,153,'2020-09-06 18:26:57.347000',3,1),(4,154,'2020-09-06 18:27:01.900000',3,1),(5,155,'2020-09-06 18:33:35.748000',3,1),(6,156,'2020-09-06 18:33:40.593000',3,1),(7,157,'2020-09-06 18:33:45.962000',3,1),(8,158,'2020-09-06 18:33:53.709000',3,1),(9,156,'2020-09-06 18:38:39.953000',3,1),(10,159,'2020-09-06 18:49:15.399000',3,1),(11,160,'2020-09-06 18:49:26.519000',3,1),(12,53531,'2020-09-06 18:50:57.908000',5,1),(13,4123850,'2020-09-06 18:50:57.908000',10,1),(14,53532,'2020-09-10 18:43:56.662000',5,1),(15,53533,'2020-09-10 18:44:55.258000',5,1),(16,161,'2020-09-11 16:02:47.891000',3,1),(17,300,'2020-09-11 16:50:35.199000',4,1),(18,17000,'2020-09-11 21:20:11.511000',8,1),(19,2000,'2020-10-09 18:25:21.734000',24,1),(20,251,'2020-10-10 17:07:14.687000',31,1),(21,252,'2020-10-10 18:46:40.603000',31,52),(22,17100,'2020-10-10 18:48:13.328000',8,52),(23,18000,'2020-10-10 19:06:09.967000',39,52),(24,15000,'2020-10-10 19:06:29.082000',38,52),(25,18001,'2020-10-12 22:37:39.809000',39,55),(26,7000,'2020-10-12 22:38:48.235000',29,55),(27,254,'2020-10-12 22:39:26.568000',31,56),(28,70,'2020-10-12 22:39:57.749000',28,57),(29,89,'2020-10-12 22:40:30.756000',18,57),(30,71,'2020-10-12 22:41:45.109000',28,58),(31,40,'2020-10-12 22:42:04.655000',22,58),(32,255,'2020-10-12 22:42:46.607000',31,59),(33,17102,'2020-10-12 22:43:01.553000',8,59),(34,40,'2020-10-12 22:43:21.063000',33,59),(35,300,'2020-10-12 22:43:52.744000',9,60),(36,260,'2020-10-12 22:44:05.824000',31,60),(37,18005,'2020-10-12 22:44:25.150000',39,60),(38,163,'2020-10-12 22:44:50.211000',3,61),(39,53536,'2020-10-12 22:45:02.403000',5,61),(40,255,'2020-10-12 22:45:15.775000',20,61),(41,20,'2020-10-12 22:45:48.012000',36,62),(42,7025,'2020-10-12 22:46:27.187000',29,63),(43,17115,'2020-10-12 22:46:51.525000',8,63),(44,28,'2020-10-12 22:47:22.199000',34,64),(45,263,'2020-10-12 22:47:33.801000',31,64),(46,303,'2020-10-12 22:47:46.999000',9,64),(47,168,'2020-10-12 22:48:15.015000',3,65),(48,75,'2020-10-12 22:48:24.964000',28,65),(49,125,'2020-10-12 22:48:34.772000',41,65),(50,17,'2020-10-12 22:49:05.437000',37,66),(51,404,'2020-10-12 22:49:24.349000',21,66),(52,15005,'2020-10-12 22:49:42.764000',38,66),(53,15008,'2020-10-12 22:50:05.381000',38,67),(54,265,'2020-10-12 22:50:16.234000',31,67),(55,17121,'2020-10-12 22:50:53.229000',8,68),(56,307,'2020-10-12 22:51:39.693000',9,68),(57,53541,'2020-10-12 22:52:10.697000',5,69),(58,195,'2020-10-12 22:52:26.607000',27,69),(59,77,'2020-10-12 22:52:51.364000',28,70),(60,174,'2020-10-12 22:53:06.419000',3,70),(61,7030,'2020-10-12 22:53:25.212000',29,70);
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (4);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing`
--

DROP TABLE IF EXISTS `listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `ending` datetime(6) NOT NULL,
  `image` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing`
--

LOCK TABLES `listing` WRITE;
/*!40000 ALTER TABLE `listing` DISABLE KEYS */;
INSERT INTO `listing` VALUES (3,'Vases','A beautifull vase made in 1746 at Firenze, Italy.','2020-10-20 09:49:00.000000','vase.jpg','Blue Vase',174),(4,'Vases','A dreadfull black vase made in dark ages.','2020-08-23 22:49:21.674000','vase_1.jpg','Black Vase',300),(5,'Faberges','Original Russian Faberge egg created at 1536.','2020-10-31 15:49:21.000000','faberge_0.jpg','Faberge Egg',53541),(6,'Paintings','The Starry Night is an oil on canvas painting by Dutch Post-Impressionist painter Vincent van Gogh, ainted in June 1889.','2020-12-02 19:49:21.674000','painting_0.jpg','Starry Night',123550),(7,'Paintings','Another landscape painting by non other than the one and only great late Bob Ross.','2020-12-10 11:49:21.674000','painting_1.jpg','Snowy Landscape',145750),(8,'Watches','An exceptional Vacheron Constantin 6747 Patrimony 18K Gold 34.50mm manual watch, including the full set.','2020-12-06 08:49:21.674000','watch_0.jpg','Vacheron Constantin 6747 Patrimony',17121),(9,'Chairs','Berkeley Leather Vintage Style Armchair','2020-10-15 12:54:00.000000','chair_0.jpg','Berkeley armchair',307),(10,'Chairs','Best chair in existence. No description required in describe how magnificent it is...','2020-09-05 19:49:21.674000','chair_1.jpg','The Chair',4123850),(16,'Technology','Gaming Laptop','2021-06-09 18:04:00.000000','6t8Zh249QiFmVnkQdCCtHK.jpg','Lenovo Laptop',1050),(17,'Watches','Luxury watches for him','2021-06-09 18:06:00.000000','8a1c1a8a-ecf1-4fd1-ae97-84fb7eca7618.jpg','Kinyued Watch',100),(18,'Women\'s Fashion','Green Dress for her.','2020-12-31 18:10:00.000000','61E0jSM4zsL.__AC_SY445_QL70_ML2_.jpg','Channel Dress',89),(19,'Women\'s Fashion','Apparel for her. ','2021-01-14 18:14:00.000000','61HmC4xCymL._AC_UX342_.jpg','Stylish Dress',49),(20,'Women\'s Fashion','Apparel for her.','2021-03-11 18:15:00.000000','61hYNSzMuoL._AC_UL1001_.jpg','Evening Dress',255),(21,'Women\'s Fashion','Shoes for her.','2021-01-19 18:19:00.000000','61xC2AVh+GL._AC_UY395_.jpg','Tom Ford High Heels',404),(22,'Women\'s Fashion','Rare golden Earrings.','2020-12-26 18:20:00.000000','71rHAJO+pmL._UY395_.jpg','Earrings',40),(23,'Paintings','Mona Lisa painting','2021-01-21 18:22:00.000000','1200px-Mona_Lisa,_by_Leonardo_da_Vinci,_from_C2RMF_retouched.jpg','Mona Lisa',70000),(24,'Motorcycles','Vrum vrum bike','2021-03-04 18:23:00.000000','2020-Honda-Super-Cub-C125-1024x599.jpg','Honda Motorcycle',2000),(25,'Paintings','Sunset above the lake.','2021-02-25 18:24:00.000000','4343-modern-landscape-painting.jpg','Sunset',12999),(26,'Women\'s Fashion','Shoes for her.','2020-12-31 18:27:00.000000','7197-ktef4L._AC_UX395_.jpg','Summer Short Heels',69),(27,'Paintings','Banksy painting','2021-01-27 22:29:00.000000','020115-26020115-26-eb10-600x600.jpg','Hope - Banksy',195),(28,'Women\'s Fashion','Luxury earrings for her.','2020-11-15 18:31:00.000000','839260953-1-600x600.jpg','Silver Earrings',77),(29,'Motorcycles','350 HP Honda Motorbike','2020-12-01 18:33:00.000000','2000000001.jpg','Honda s750 Motorbike',7030),(30,'Technology','Gaming Laptop','2020-12-09 18:34:00.000000','a388f7be-7299-46cd-8dbf-4ed8d95e9da3.jpg','Asus Laptop',1200),(31,'Watches','Luxury watch for him.','2020-11-11 18:35:00.000000','b452416da0229f0cb3225108b6dd122433cda922_l.jpg','Curren Watch',265),(32,'Motorcycles','400 HP Motorcycle','2020-12-11 18:37:00.000000','download.jpg','KTM Motorcycle',9999),(33,'Men\'s Fashion','Fashion for him.','2020-11-27 18:38:00.000000','images.jpg','Polo T-Shirt',40),(34,'Men\'s Fashion','Fashion for him.','2020-11-27 18:39:00.000000','ironman_burgundy_t_shirt_mens-min_1.jpg','Ironman T-Shirt',28),(35,'Watches','Luxury style for him.','2020-12-07 18:40:00.000000','NIBOSI-Relogio-Masculino-Men-Watches-Luxury-Famous-Top-Brand-Men-s-Fashion-Casual-Dress-Watch-Military-2.jpg','NIBOSI Watch',419),(36,'Women\'s Fashion','Fashion for her.','2020-12-24 18:42:00.000000','product-jpeg-500x500.jpg','Unique Gold Earrings',20),(37,'Books','The use of useless knowledge','2020-12-11 18:46:00.000000','31RPYV2oIhL._SR600,315_PIWhiteStrip,BottomLeft,0,35_SCLZZZZZZZ_.jpg','Knowledge is power',17),(38,'Cars','Electric blue Skoda Fabia','2020-12-31 18:47:00.000000','2022-skoda-fabia-rendered-with-scala-styling-will-use-mqb-a0-platform-1_77761_389904_type12380.jpg','Skoda Fabia',15008),(39,'Cars','Citroen C3 2020 Edition','2020-11-30 18:48:00.000000','fun-car-citroen-c3.png','Citroen C3',18005),(40,'Cars','The best car.','2021-01-19 18:49:00.000000','Supernatural-impala-1001x565p.jpg','Godlike Impala',47999),(41,'Books','Advances in Bioinformatics, Multimedia, and Electronics Circuits and Signals','2020-11-30 18:52:00.000000','614kM5iDxBL.jpg','Science Book',125);
/*!40000 ALTER TABLE `listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `history` tinyint(1) NOT NULL DEFAULT '0',
  `management` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `age` int NOT NULL,
  `gender` varchar(255) NOT NULL,
  `likedCategories` mediumtext,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_jreodf78a7pl5qidfh43axdfb` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'12345678','aggelos',1,1,'Aggelos','Aggelos',20,'Male','Watches','aggelosstam13@gmail.com'),(48,'testtest1','testtest1',0,0,'testtest1','testtest1',20,'Female','','testtest1@gmail.com'),(49,'testtest2','testtest2',1,0,'testtest2','testtest2',20,'Male','','testtest2@gmail.com'),(50,'testtest3','testtest3',0,1,'testtest3','testtest3',20,'Female','','testtest3@gmail.com'),(51,'12345678','giwrgos',1,1,'Giwrgos','Giwrgos',20,'Male','','georgios.mourtzounis@gmail.com'),(52,'testtest4','testtest4',0,0,'testtest4','testtest4',32,'Female','Watches,Motorcycles,Cars','testtest4@gmail.com'),(53,'tteeeeeee','tteeeeeee',0,0,'tteeeeeee','tteeeeeee',50,'Other','Technology','tteeeeeee@gmail.com'),(54,'12345678','Patroklos',0,0,'Patroklos','Evaggeliou',22,'Male','Watches,Technology,Men\'s Fashion,Cars','patroklos@test.com'),(55,'12345678','Nikolaos',0,0,'Nikolaos','Tragos',20,'Male','Technology,Motorcycles,Cars','nikolaos@test.com'),(56,'12345678','Manolis',0,0,'Manolis','Pontikakis',18,'Male','Watches,Technology,Men\'s Fashion,Books','manolis@test.com'),(57,'12345678','Matina',0,0,'Matina','Mantarinaki',19,'Female','Paintings,Women\'s Fashion,Books','matina@test.com'),(58,'12345678','Florentia',0,0,'Florentia','Birbili',24,'Female','Paintings,Chairs,Women\'s Fashion,Books','florentia@test.com'),(59,'12345678','Adonis',0,0,'Adonis','Georgopoulos',27,'Male','Watches,Chairs,Books','adonis@test.com'),(60,'12345678','Paulos',0,0,'Paulos','Pollakis',32,'Male','Watches,Chairs,Motorcycles,Books,Cars','paulos@test.com'),(61,'12345678','Marialena',0,0,'Marialena','Lelopoulou',30,'Female','Vases,Faberges,Women\'s Fashion,Books','marialena@test.com'),(62,'12345678','Dimitra',0,0,'Dimitra','Papadopoulou',29,'Female','Vases,Faberges,Women\'s Fashion','dimitra@test.com'),(63,'12345678','Leonidas',0,0,'Leonidas','Triakosios',36,'Male','Watches,Technology,Motorcycles,Cars','leonidas@test.com'),(64,'12345678','Theocharis',0,0,'Theocharis','Taksiarchos',41,'Male','Watches,Chairs,Men\'s Fashion','theocharis@test.com'),(65,'12345678','Margarita',0,0,'Margarita','Margarw',43,'Female','Vases,Paintings,Women\'s Fashion,Books','margarita@test.com'),(66,'12345678','Apostolia',0,0,'Apostolia','Zoisemas',39,'Female','Paintings,Chairs,Women\'s Fashion,Books','apostolia@test.com'),(67,'12345678','Georgios',0,0,'Georgios','Mazwnakis',45,'Male','Watches,Cars','georgios@test.com'),(68,'12345678','Dimosthenis',0,0,'Dimosthenis','Politis',52,'Male','Paintings,Watches,Chairs,Books','dimosthenis@test.com'),(69,'12345678','Pinelopi',0,0,'Eleni','Louka',54,'Female','Vases,Faberges,Paintings','eleni@test.com'),(70,'12345678','Melina',0,0,'Melina','Nikolopoulou',49,'Female','Women\'s Fashion','melina@test.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bidwars_v.2.0'
--

--
-- Dumping routines for database 'bidwars_v.2.0'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-13 22:10:11
