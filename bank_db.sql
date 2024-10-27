-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: mysql-2554cf05-pasindusathsara60-database-project.k.aivencloud.com    Database: bank_db
-- ------------------------------------------------------
-- Server version	8.0.30

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '1f659c9d-8091-11ef-a96e-066b5551d71f:1-631';

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Account` (
  `Account_ID` int NOT NULL AUTO_INCREMENT,
  `Branch_ID` int DEFAULT NULL,
  `Customer_ID` int DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Plan` varchar(255) DEFAULT NULL,
  `OpeningDate` date DEFAULT NULL,
  `Balance` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`Account_ID`),
  KEY `Branch_ID` (`Branch_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`),
  CONSTRAINT `account_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `Customer` (`Customer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account`
--

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
INSERT INTO `Account` VALUES (1,1,1,'Savings','Bank','2010-01-01',1000000098.38),(2,2,2,'Checking',NULL,'2011-02-01',2914.62),(3,3,3,'Savings','Children','2012-03-20',1500.00),(4,4,4,'Savings','Teen','2013-04-10',2500.00),(5,5,5,'Checking',NULL,'2014-05-05',5000.00),(6,6,6,'Savings','Senior','2015-06-01',8600.00),(7,7,7,'Savings','Adult','2016-07-01',7000.00),(8,8,8,'Checking',NULL,'2017-08-15',4500.00),(9,9,9,'Savings','Children','2018-09-10',1200.00),(10,10,10,'Savings','Teen','2019-10-01',2300.00),(11,1,11,'Checking',NULL,'2020-11-05',5300.00),(12,2,12,'Savings','Senior','2021-12-01',9100.00),(13,3,13,'Savings','Adult','2010-01-01',6800.00),(14,4,14,'Checking',NULL,'2011-02-15',4700.00),(15,5,15,'Savings','Children','2012-03-10',1300.00),(16,6,16,'Savings','Teen','2013-04-01',2400.00),(17,7,17,'Checking',NULL,'2014-05-05',3100.00),(18,8,18,'Savings','Senior','2015-06-01',8700.00),(19,9,19,'Savings','Adult','2016-07-01',7200.00),(20,10,20,'Checking',NULL,'2017-08-15',4950.00),(21,1,21,'Savings','Children','2018-09-10',1400.00),(22,2,22,'Savings','Teen','2019-10-01',2600.00),(23,3,23,'Checking',NULL,'2020-11-05',5500.00),(24,4,24,'Savings','Senior','2021-12-01',8500.00),(25,5,25,'Savings','Adult','2022-01-01',8400.00),(26,1,1,'Checking',NULL,'2010-01-01',1000000041.00),(27,4,2,'Savings','Senior','2011-03-01',9300.00),(28,5,3,'Savings','Children','2012-04-20',1800.00),(29,6,4,'Savings','Teen','2013-05-10',2700.00),(30,7,5,'Savings','Adult','2014-06-05',7400.00),(31,8,6,'Savings','Senior','2015-07-01',8600.00),(32,9,7,'Savings','Children','2016-08-01',2100.00),(33,10,8,'Savings','Teen','2017-09-15',3500.00),(34,1,9,'Savings','Adult','2018-10-10',8100.00),(35,2,10,'Savings','Senior','2019-11-01',9100.00),(36,3,11,'Savings','Children','2020-12-15',1600.00),(37,4,12,'Savings','Teen','2021-01-01',3300.00),(38,5,13,'Savings','Adult','2022-02-05',7800.00),(39,6,14,'Savings','Senior','2023-03-01',9200.00),(40,7,15,'Savings','Children','2010-04-10',1300.00),(41,8,16,'Savings','Teen','2011-05-01',2900.00),(42,9,17,'Savings','Adult','2012-06-15',8400.00),(43,10,18,'Savings','Senior','2013-07-01',9000.00),(44,1,19,'Checking',NULL,'2014-08-10',5200.00),(45,2,20,'Checking',NULL,'2015-09-05',6350.00),(46,3,21,'Checking',NULL,'2016-10-01',4500.00),(47,4,22,'Checking',NULL,'2017-11-15',4800.00),(48,5,23,'Checking',NULL,'2018-12-01',6900.00),(49,6,24,'Checking',NULL,'2019-01-10',7200.00),(50,7,25,'Checking',NULL,'2020-02-05',5490.00),(51,9,9,'Savings','teen','2024-10-03',5000.00),(52,9,9,'Savings','teen','2024-10-03',5000.00),(53,9,9,'Savings','teen','2024-10-03',5000.00),(54,9,9,'Savings','teen','2024-10-03',5000.00),(55,9,9,'Savings','teen','2024-10-03',5000.00),(56,9,9,'Savings','teen','2024-10-03',5000.00),(57,9,9,'Savings','teen','2024-10-03',5000.00),(58,9,9,'Savings','teen','2024-10-03',5000.00),(59,9,9,'Savings','teen','2024-10-03',5000.00),(60,9,9,'Savings','teen','2024-10-03',5000.00),(61,9,9,'Savings','teen','2024-10-03',5000.00),(62,9,9,'Savings','teen','2024-10-03',5000.00),(63,9,9,'Savings','teen','2024-10-03',5000.00),(64,9,9,'Savings','Teen','2024-10-03',5000.00),(65,9,2,'Checking','Senior','2024-10-04',3956.00),(66,9,26,'Savings','Children','2024-10-10',5000.00);
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Branch`
--

DROP TABLE IF EXISTS `Branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Branch` (
  `Branch_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Manager_ID` int DEFAULT NULL,
  PRIMARY KEY (`Branch_ID`),
  KEY `Manager_ID` (`Manager_ID`),
  CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`Manager_ID`) REFERENCES `Manager` (`Manager_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Branch`
--

LOCK TABLES `Branch` WRITE;
/*!40000 ALTER TABLE `Branch` DISABLE KEYS */;
INSERT INTO `Branch` VALUES (1,'Head Office Branch','123 Main St, Cityville',1),(2,'Uptown Branch','456 Oak St, Cityville',1),(3,'Suburban Branch','789 Pine St, Suburbia',1),(4,'Eastside Branch','101 Maple Ave, Eastside',1),(5,'Westside Branch','202 Elm St, Westside',1),(6,'Northside Branch','303 Cedar Blvd, Northside',6),(7,'Southside Branch','404 Birch St, Southside',7),(8,'Central Branch','505 Spruce St, Central City',8),(9,'Lakeside Branch','606 Lake Dr, Lakeside',9),(10,'Riverside Branch','707 River Rd, Riverside',10),(11,'Head Office Branch','123 Main St, Cityville',1),(12,'Uptown Branch','456 Oak St, Cityville',1),(13,'Suburban Branch','789 Pine St, Suburbia',1),(14,'Eastside Branch','101 Maple Ave, Eastside',1),(15,'Westside Branch','202 Elm St, Westside',1),(16,'Northside Branch','303 Cedar Blvd, Northside',6),(17,'Southside Branch','404 Birch St, Southside',7),(18,'Central Branch','505 Spruce St, Central City',1),(19,'Lakeside Branch','606 Lake Dr, Lakeside',10),(20,'Riverside Branch','707 River Rd, Riverside',10);
/*!40000 ALTER TABLE `Branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `Customer_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `NIC` varchar(50) DEFAULT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'Bank','NIC123456789V','bankuser','$2b$10$AsK1J7KgiRO/51DS5mcHvu1conJhO94qO7wUhvSK86z6JbP6jVd4i','12 Green St, Cityville'),(2,'Bob Johnson','NIC987654321V','bobjohnson','$2b$10$Olqa.B.T7mddGNXxxTJ7AOnEIfWlhKq/WpEfgLbadMAz2cMHVCiyq','34 Blue St, Suburbia'),(3,'Charlie Brown','NIC456789123V','charliebrown','$2b$10$2M4XH7Wmg1IBzQtX.KnMmu6EZLKg.y5nJAztLhUNSVQbugXUxNMSi','56 Red St, Eastside'),(4,'Daisy Miller','NIC789123456V','daisymiller','$2b$10$e5Wa5eo8xDQ.K2R1JsJyWeUnWi6xaaqL3mXAKYJw5INhL8bzLpzGC','78 Yellow St, Westside'),(5,'Ethan Davis','NIC321654987V','ethandavis','$2b$10$JztY3azdZ2WGrmc0XIyigODT0vxMgwV/zVUp1oFqKTkasY0n6AOzu','90 Purple St, Northside'),(6,'Fiona Harris','NIC654987321V','fionaharris','$2b$10$e92M8kX15VowLqYJnYYGAu3d5Hfl0JiSizaGiOMWeMuQb3pj836ji','102 Orange St, Southside'),(7,'George Clark','NIC789456123V','georgeclark','$2b$10$YCoj2RlaZ5jgdv7EXBHt4uEsJDXn19lKTxervtvnMKrSLo.tjA8Eq','114 Pink St, Central City'),(8,'Hannah Moore','NIC123789456V','hannahmoore','$2b$10$3/PGKaXw2B2vV3BJFa0BPeKgocXk0iIJ5iiUOLyhJvGa91d/xOYIO','126 White St, Lakeside'),(9,'Ian Scott','NIC456123789V','ianscott','$2b$10$gV0ygUMMMPd4CSkwC30koOXx6jCAaok1G4FpoJFX/fLzGMLpNWklG','138 Black St, Riverside'),(10,'Jane King','NIC321987654V','janeking','$2b$10$GbK5etJJKDiTnM6vPdT1r.a/esgSI6gQR7X92zRSfYbgnTDiFkUWO','150 Grey St, Cityville'),(11,'Kyle Reed','NIC654321987V','kylereed','$2b$10$mDfkBF8AZFZw9wXP1FrQlOAv9kjS0gGnTu8dgrpLW6HTREIwFZ2zm','162 Maroon St, Suburbia'),(12,'Lara Young','NIC987123654V','larayoung','$2b$10$5z/9je1DMRWQ9sB7El5a0uPp2ZLjq71lIvYHyCNRPqNoS9Ree6Ih2','174 Cyan St, Eastside'),(13,'Mason Hall','NIC123654789V','masonhall','$2b$10$q5jelAifz76105/T66rNYuR69K2/7OZFZZk4GLm6g4Lc22/lO9AC2','186 Magenta St, Westside'),(14,'Nina Lee','NIC654789123V','ninalee','$2b$10$4BLQnVKvnl6s5Qw24WQt6.xL4giNaKqJ9M6W1zCmNXW6teyyVhhNS','198 Amber St, Northside'),(15,'Owen Adams','NIC789321456V','owenadams','$2b$10$Ivi7p.Nf0kaS6nl9ERr3e.UkoP7V4QZ8yMObhxRpIZraS7nP3CkXO','210 Teal St, Southside'),(16,'Paula Nelson','NIC321654123V','paulanelson','$2b$10$DT1IdLvoz.4Bioxvy4X0U.gpU36Z/o5e6c6xdnDkxq58n9Xy9qEuu','222 Indigo St, Central City'),(17,'Quinn Parker','NIC654987456V','quinnparker','$2b$10$qgUGmeFmyxXz8LIqLKbJaODFd6jvN2dutTI/dbKSIECDRQjiUnd66','234 Lavender St, Lakeside'),(18,'Rachel Evans','NIC789654321V','rachelevans','$2b$10$Nzpb95EgZSgCL1iMQTgRMO8Bekxn1kpsHm2uPSfnqwN/sjQtxczYy','246 Beige St, Riverside'),(19,'Sam Torres','NIC123456987V','samtorres','$2b$10$0pl4.KiioH/d2W4OknqOHOjBdTExfVOQ.T0/1snoZScdAGLklNPfm','258 Brown St, Cityville'),(20,'Tina Murphy','NIC456789654V','tinamurphy','$2b$10$mZGm8iLx2vB//7b9iRIer.kXUEPx4vGuS588qJqfM/2NMK5JPXAti','270 Peach St, Suburbia'),(21,'Ursula Black','NIC789321987V','ursulablack','$2b$10$gk5pOMXp/trsiRN6ZUSGPebAQgNQiyZSTKoUJxjIyX1IGK2wlWVta','282 Gold St, Eastside'),(22,'Victor White','NIC321987123V','victorwhite','$2b$10$cfGdSaB1zephIXNuTVmI7OeovVL.ovgpgm5gZm0owBQvIQr/ECnXK','294 Silver St, Westside'),(23,'Wendy Green','NIC654123456V','wendygreen','$2b$10$NZaLxvP26Hqgv9doR2MbZeW6OLzN/wa8JTl4PHecwaS.XXwEPFOo6','306 Bronze St, Northside'),(24,'Xander Price','NIC987654321V','xanderprice','$2b$10$abmmxIDr6g84mlmhpOXr/.Wtz9SAQUzG17Qcwwm/JJ/rRs9q2xlJu','318 Platinum St, Southside'),(25,'Yara Bell','NIC123987654V','yarabell','$2b$10$K89Y0vqjR9voSWAUrO9lkemF0JOYfm3esMhaIukyCwocENN0a7n3S','330 Ruby St, Central City'),(26,'Pasindu Sathsara','783450169V','hello','$2a$10$1XZJG5kJjtZLxvNlDxjUmOKdRpsr9JyDqBWjEUPZfnf3JRRoqj76G','241/1,Bembada,Yatalamatta,Galle'),(27,'Donald J. Trump','45125896v','donald','$2a$10$lBXKn7v4Z/Lu6HhZ3GVITe6dqRVhW6gHCo/oUWQsxQ/2/iu1xQ5bW','Butler, Penysilvania, USA');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `Employee_ID` int NOT NULL AUTO_INCREMENT,
  `Branch_ID` int DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  UNIQUE KEY `Username` (`Username`),
  KEY `Branch_ID` (`Branch_ID`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,1,'Robert Harris','robertharris','$2b$10$Sad7i0OunQDIY0PFG.MP9uu.Qk5Xd1DAEVbWIUd4D4ZtYsCdqV9Xa'),(2,2,'Laura Mitchell','lauramitchell','$2b$10$/J2gVay1blcLcD2491ewUuPFr8jDdxkkd9cta.CX8u.yE.P9hEqgq'),(3,3,'Kevin Adams','kevinadams','$2b$10$Hqfy019B2TUJjk0Ldk3wduD49XpJU5tNbAGzyQBJqUEFMnj1JH8xK'),(4,4,'Nancy Carter','nancycarter','$2b$10$fTmPu/nYuh5LqInGs7KfDObFP0IptoHGa7aVRUtwrjvndmFiWmfUS'),(5,5,'Brian Cooper','briancooper','$2b$10$oDhPtyE2MjiATL6vg7r8uOEcSR6.4MOh2Dg6APZrA2wuAjF26q5ma'),(6,6,'Emily Collins','emilycollins','$2b$10$FfXFXA6KU8IXjECyMm/k4eAgDa5Xp7QMPSeYDw1aTPDlZyrgw8Iou'),(7,7,'Eric James','ericjames','$2b$10$32NAZwSFyd.Lz1C7M5HfBeq7PLb0waoHGevuk7pOeflR1HahMVj1C'),(8,8,'Lisa Turner','lisaturner','$2b$10$ANuOL9BJGwVpLgQr.syFtOVc1fdMqIisx/nLwVdebEtg.zEtw88rK'),(9,9,'Franklin Lee','franklinlee','$2b$10$rNJcUwcFXpGeI2q019xtkO6X.kyZdggqytc5QFk6PDUgOkIrajWqi'),(10,10,'Anna Walker','annawalker','$2b$10$mBbGSe06.5U9CR/tST9C0uEBivESvXe2TiMnP92Voz1tqCZ2Ux9Ra'),(11,1,'Oliver Brooks','oliverbrooks','$2b$10$DAGf8/CcJTQdXz7fd3fOdObIULYpmAg7zogGPPsXoVsJoSE9ELl/2'),(12,2,'Sophia Morgan','sophiamorgan','$2b$10$gEf5ay17LrodH8di75hEH.aGpdyiX6/f6SXaDf.JcYoD7/BKXUyGa'),(13,3,'James Bailey','jamesbailey','$2b$10$7Al0tZ2/CnLVZ8TTUp7jzezYgY1xHv1kYQV9KkeXhX51sIEe1DZNG'),(14,4,'Mia Russell','miarussell','$2b$10$uBAV2j3E2PxiuGFn9.TxSuQNaobGO4C/0L9LpVTZImYyMu.o.yHM.'),(15,5,'Lucas Reed','lucasreed','$2b$10$odxvFXv3SGHDCjs2N321gu3LdgSjtOeul.dBDFOynwMLKgOmCAyV2'),(16,6,'Ava Bennett','avabennett','$2b$10$aXVSK1ISDfFTyVNL59aSQukjSGKZFOzqxMfeP.4j5s022/cE0Rw3a'),(17,7,'Henry Hughes','henryhughes','$2b$10$nXZz95k.T1sgqX5wy.KBMO6zis2XS1LV.vphFjmkVnSY.dlO2PxBC'),(18,8,'Isabella Foster','isabellafoster','$2b$10$360ZWmiG9aVJnd3OUdmnjusGQ.9wDgJezxlnNgpb9fn2Jg7g6Zt9y'),(19,9,'William Cook','williamcook','$2b$10$lYp1CgZddzPX51wNoDNZLOtkh2eA9s8lCzdKj8.8Nie581LZL14Ru'),(20,10,'Amelia Peterson','ameliapeterson','$2b$10$zKZcdlCBamc7HC4xlU/e8e7uBT5ShhwTzhbJUYl0C7XXeeG.J7nFS');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FD`
--

DROP TABLE IF EXISTS `FD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FD` (
  `FD_ID` int NOT NULL AUTO_INCREMENT,
  `Branch_ID` int DEFAULT NULL,
  `Account_ID` int DEFAULT NULL,
  `Period` int DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `InitialAmount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`FD_ID`),
  KEY `Branch_ID` (`Branch_ID`),
  KEY `Account_ID` (`Account_ID`),
  CONSTRAINT `fd_ibfk_1` FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`),
  CONSTRAINT `fd_ibfk_2` FOREIGN KEY (`Account_ID`) REFERENCES `Account` (`Account_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FD`
--

LOCK TABLES `FD` WRITE;
/*!40000 ALTER TABLE `FD` DISABLE KEYS */;
INSERT INTO `FD` VALUES (1,1,1,12,'2023-01-15',10000.00),(2,2,2,24,'2023-02-10',15000.00),(3,3,3,36,'2023-03-05',20000.00),(4,4,4,48,'2023-04-20',25000.00),(5,5,5,60,'2023-05-15',30000.00),(6,6,6,12,'2023-06-10',18000.00),(7,7,7,24,'2023-07-05',22000.00),(8,8,8,36,'2023-08-20',27000.00),(9,9,9,48,'2023-09-15',32000.00),(10,10,10,60,'2023-10-10',35000.00),(11,1,11,12,'2023-11-05',12000.00),(12,2,12,24,'2023-12-01',14000.00),(13,3,13,36,'2023-12-20',16000.00),(14,4,14,48,'2024-01-15',18000.00),(15,5,15,60,'2024-02-10',20000.00),(16,6,16,12,'2024-03-05',22000.00),(17,7,17,24,'2024-04-20',24000.00),(18,8,18,36,'2024-05-15',26000.00),(19,9,19,48,'2024-06-10',28000.00),(20,10,20,60,'2024-07-05',30000.00),(21,1,31,12,'2023-01-15',550000.00),(22,2,32,24,'2022-02-10',600000.00),(23,3,33,36,'2021-03-05',750000.00),(24,4,34,48,'2021-04-20',820000.00),(25,5,35,60,'2022-05-15',900000.00),(26,6,36,12,'2023-06-10',950000.00),(27,7,37,24,'2023-07-25',1000000.00),(28,8,38,36,'2022-08-20',1200000.00),(29,9,39,48,'2022-09-15',1300000.00),(30,10,40,60,'2021-10-10',1500000.00),(31,1,41,12,'2020-11-05',560000.00),(32,2,42,24,'2020-12-01',610000.00),(33,3,43,36,'2019-01-20',780000.00),(34,4,44,48,'2019-02-15',830000.00),(35,5,45,60,'2020-03-10',910000.00),(36,6,46,12,'2020-04-05',960000.00),(37,7,47,24,'2021-05-25',1010000.00),(38,8,48,36,'2021-06-30',1220000.00),(39,9,49,48,'2022-07-15',1320000.00),(40,10,50,60,'2023-08-01',1520000.00),(41,2,2,24,'2023-02-10',15000.00),(42,2,2,24,'2023-02-10',15000.00),(43,2,2,24,'2023-02-10',150000.00),(44,2,2,24,'2023-02-10',150000.00),(45,2,2,24,'2023-02-10',150000.00),(46,2,2,24,'2023-02-10',150000.00),(47,2,65,6,'2024-10-13',500.00),(48,2,65,6,'2024-10-13',500.00),(49,2,2,6,'2024-10-13',500.00);
/*!40000 ALTER TABLE `FD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Loan`
--

DROP TABLE IF EXISTS `Loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Loan` (
  `Loan_ID` int NOT NULL AUTO_INCREMENT,
  `Branch_ID` int DEFAULT NULL,
  `Customer_ID` int DEFAULT NULL,
  `LoanPeriod` int DEFAULT NULL,
  `InterestRate` decimal(5,2) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `LoanValue` decimal(15,2) DEFAULT NULL,
  `Application_ID` int DEFAULT NULL,
  PRIMARY KEY (`Loan_ID`),
  KEY `Branch_ID` (`Branch_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Application_ID` (`Application_ID`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`),
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `Customer` (`Customer_ID`),
  CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`Application_ID`) REFERENCES `LoanApplication` (`Application_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Loan`
--

LOCK TABLES `Loan` WRITE;
/*!40000 ALTER TABLE `Loan` DISABLE KEYS */;
INSERT INTO `Loan` VALUES (1,1,1,12,12.00,'2024-09-21',5000.00,1),(2,1,1,12,12.00,'2024-09-21',5000.00,1),(3,1,1,12,12.00,'2024-09-21',5000.00,1),(4,1,1,12,12.00,'2024-09-21',100000.00,1),(5,1,21,12,12.00,'2024-09-23',10000.00,24),(6,1,21,12,12.00,'2024-09-23',10000.00,25),(7,1,21,12,12.00,'2024-09-23',10000.00,26),(8,1,21,12,12.00,'2024-09-23',10000.00,29),(9,1,21,12,12.00,'2024-09-23',10000.00,30),(10,1,21,12,12.00,'2024-09-23',10000.00,31),(11,1,21,12,12.00,'2024-09-23',10000.00,32),(12,1,21,12,12.00,'2024-09-23',10000.00,33),(13,1,21,12,12.00,'2024-09-23',10000.00,34),(14,1,21,12,12.00,'2024-09-23',10000.00,35),(15,1,21,12,12.00,'2024-09-23',10000.00,36),(16,1,21,12,12.00,'2024-09-23',10000.00,37),(17,1,21,12,12.00,'2024-09-23',10000.00,38),(18,1,21,12,12.00,'2024-09-23',10000.00,39),(19,1,21,12,12.00,'2024-09-23',10000.00,40),(20,1,21,12,12.00,'2024-09-23',10000.00,41),(21,1,21,12,12.00,'2024-09-23',10000.00,42),(22,1,1,12,12.00,'2024-09-23',1000.00,43),(23,1,1,12,12.00,'2024-09-23',1000.00,44),(24,1,1,12,12.00,'2024-09-23',1000.00,45),(25,1,1,12,12.00,'2024-09-23',1000.00,46),(26,1,1,12,12.00,'2024-09-23',1000.00,47),(27,1,1,12,12.00,'2024-09-23',1000.00,48),(28,NULL,NULL,NULL,NULL,'2024-09-25',NULL,11),(29,NULL,NULL,NULL,NULL,'2024-09-25',NULL,11),(30,NULL,NULL,NULL,NULL,'2024-09-25',NULL,22),(31,NULL,NULL,NULL,NULL,'2024-09-25',NULL,23),(32,NULL,NULL,NULL,NULL,'2024-09-25',NULL,24),(33,NULL,NULL,NULL,NULL,'2024-09-25',NULL,25),(34,NULL,NULL,NULL,NULL,'2024-09-25',NULL,26),(35,NULL,NULL,NULL,NULL,'2024-09-25',NULL,27),(36,NULL,NULL,NULL,NULL,'2024-09-25',NULL,28),(37,NULL,NULL,NULL,NULL,'2024-09-25',NULL,29),(38,NULL,NULL,NULL,NULL,'2024-09-25',NULL,49),(39,NULL,NULL,NULL,NULL,'2024-09-25',NULL,49),(40,NULL,NULL,NULL,NULL,'2024-09-25',NULL,49),(41,NULL,NULL,NULL,NULL,'2024-09-25',NULL,49),(42,NULL,NULL,NULL,NULL,'2024-09-25',NULL,36),(43,NULL,NULL,NULL,NULL,'2024-09-25',NULL,37),(44,NULL,NULL,NULL,NULL,'2024-09-25',NULL,35),(45,NULL,NULL,NULL,NULL,'2024-09-25',NULL,52),(46,NULL,NULL,NULL,NULL,'2024-09-25',NULL,52),(47,NULL,NULL,NULL,NULL,'2024-09-25',NULL,52),(48,NULL,NULL,NULL,NULL,'2024-09-25',NULL,52),(49,NULL,NULL,NULL,NULL,'2024-09-25',NULL,52),(50,NULL,NULL,NULL,NULL,'2024-09-25',NULL,52),(51,1,1,12,10.00,'2024-09-25',90000.00,52),(52,9,2,12,4.50,'2024-10-04',1000.00,53),(53,9,9,48,10.00,'2024-10-04',22000.00,9),(54,9,2,24,6.00,'2024-10-04',2500.00,54),(55,1,2,6,12.00,'2024-10-12',15000.00,56),(56,1,2,6,12.00,'2024-10-12',9000.00,57),(57,10,2,6,6.00,'2024-10-12',60000.00,58),(58,10,2,6,6.00,'2024-10-12',60000.00,59),(59,10,2,6,6.00,'2024-10-12',60000.00,60),(60,5,2,6,6.00,'2024-10-12',60000.00,61);
/*!40000 ALTER TABLE `Loan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `CreateLoanInstallmentsAfterInsert` AFTER INSERT ON `Loan` FOR EACH ROW BEGIN
    DECLARE monthlyInterestRate DECIMAL(10, 5);
    DECLARE numberOfPayments INT;
    DECLARE monthlyInstallment DECIMAL(15, 2);
    DECLARE i INT DEFAULT 1;
    DECLARE dueDate DATE;

    -- Calculate monthly interest rate
    SET monthlyInterestRate = NEW.InterestRate / 1200;

    -- Calculate number of payments (months)
    SET numberOfPayments = NEW.LoanPeriod;

    -- Calculate monthly installment using the amortizing loan formula
    SET monthlyInstallment = (NEW.LoanValue * monthlyInterestRate) / (1 - POW(1 + monthlyInterestRate, -numberOfPayments));

    -- Loop through the number of payments to create each installment
    WHILE i <= numberOfPayments DO
        -- Calculate the due date for each installment
        SET dueDate = DATE_ADD(NEW.Date, INTERVAL i MONTH);

        -- Insert the installment record into the LoanInstallments table
        INSERT INTO LoanInstallments (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value)
        VALUES (NEW.Loan_ID, NEW.Branch_ID, NULL, dueDate, ROUND(monthlyInstallment, 2));

        -- Increment loop counter
        SET i = i + 1;
    END WHILE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LoanApplication`
--

DROP TABLE IF EXISTS `LoanApplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LoanApplication` (
  `Application_ID` int NOT NULL AUTO_INCREMENT,
  `Branch_ID` int DEFAULT NULL,
  `Customer_ID` int DEFAULT NULL,
  `LoanPeriod` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `LoanValue` decimal(15,2) DEFAULT NULL,
  `Approved` tinyint DEFAULT NULL,
  `LoanType` enum('Online','Normal') DEFAULT NULL,
  PRIMARY KEY (`Application_ID`),
  KEY `Branch_ID` (`Branch_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  CONSTRAINT `loanapplication_ibfk_1` FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`),
  CONSTRAINT `loanapplication_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `Customer` (`Customer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoanApplication`
--

LOCK TABLES `LoanApplication` WRITE;
/*!40000 ALTER TABLE `LoanApplication` DISABLE KEYS */;
INSERT INTO `LoanApplication` VALUES (1,1,1,24,'2023-01-15',10000.00,0,'Normal'),(2,2,2,36,'2023-02-10',15000.00,0,'Online'),(3,3,3,12,'2023-03-05',5000.00,0,'Normal'),(4,4,4,48,'2023-04-20',25000.00,0,'Online'),(5,5,5,60,'2023-05-15',35000.00,0,'Online'),(6,6,6,24,'2023-06-10',20000.00,0,'Normal'),(7,7,7,36,'2023-07-05',18000.00,0,'Normal'),(8,8,8,12,'2023-08-20',8000.00,0,'Normal'),(9,9,9,48,'2023-09-15',22000.00,1,'Normal'),(10,10,10,60,'2023-10-10',27000.00,0,'Online'),(11,1,11,24,'2023-11-05',12000.00,1,'Online'),(12,2,12,36,'2023-12-01',14000.00,0,'Normal'),(13,3,13,12,'2023-12-20',7000.00,0,'Normal'),(14,4,14,48,'2024-01-15',30000.00,0,'Online'),(15,5,15,60,'2024-02-10',45000.00,0,'Online'),(16,6,16,24,'2024-03-05',16000.00,0,'Online'),(17,7,17,36,'2024-04-20',19000.00,0,'Online'),(18,8,18,12,'2024-05-15',9000.00,0,'Normal'),(19,9,19,48,'2024-06-10',24000.00,-1,'Online'),(20,10,20,60,'2024-07-05',30000.00,0,'Normal'),(22,1,21,12,'2023-10-01',10000.00,1,'Online'),(23,1,21,12,'2023-10-01',10000.00,1,'Online'),(24,1,21,12,'2023-10-01',10000.00,1,'Online'),(25,1,21,12,'2023-10-01',10000.00,1,'Online'),(26,1,21,12,'2023-10-01',10000.00,1,'Online'),(27,1,21,12,'2023-10-01',10000.00,1,'Online'),(28,1,21,12,'2023-10-01',10000.00,1,'Online'),(29,1,21,12,'2023-10-01',10000.00,1,'Online'),(30,1,21,12,'2023-10-01',10000.00,0,'Online'),(31,1,21,12,'2023-10-01',10000.00,0,'Online'),(32,1,21,12,'2023-10-01',10000.00,0,'Online'),(33,1,21,12,'2023-10-01',10000.00,0,'Online'),(34,1,21,12,'2023-10-01',10000.00,0,'Online'),(35,1,21,12,'2023-10-01',10000.00,1,'Online'),(36,1,21,12,'2023-10-01',10000.00,1,'Online'),(37,1,21,12,'2023-10-01',10000.00,1,'Online'),(38,1,21,12,'2023-10-01',10000.00,1,'Online'),(39,1,21,12,'2023-10-01',10000.00,1,'Online'),(40,1,21,12,'2023-10-01',10000.00,-1,'Online'),(41,1,21,12,'2023-10-01',10000.00,1,'Online'),(42,1,21,12,'2023-10-01',10000.00,1,'Online'),(43,1,1,12,'2023-10-01',1000.00,1,'Online'),(44,1,1,12,'2023-10-01',1000.00,1,'Online'),(45,1,1,12,'2023-10-01',1000.00,1,'Online'),(46,1,1,12,'2023-10-01',1000.00,1,'Online'),(47,1,1,12,'2023-10-01',1000.00,1,'Online'),(48,1,1,12,'2023-10-01',1000.00,1,'Online'),(49,1,1,12,'2024-09-25',100000.00,1,'Normal'),(50,10,10,12,'2024-09-25',20000.00,0,'Normal'),(51,20,20,12,'2024-09-25',80000.00,0,'Normal'),(52,1,1,12,'2024-09-25',90000.00,1,'Normal'),(53,9,2,12,'2024-10-04',1000.00,1,'Online'),(54,9,2,24,'2024-10-04',2500.00,1,'Online'),(55,9,2,24,'2024-10-09',125000.00,0,'Normal'),(56,1,2,6,'2024-10-13',15000.00,1,'Online'),(57,1,2,6,'2024-10-14',9000.00,1,'Online'),(58,10,2,6,'2024-10-13',60000.00,1,'Online'),(59,10,2,6,'2024-10-21',60000.00,1,'Online'),(60,10,2,6,'2024-10-22',60000.00,1,'Online'),(61,5,2,6,'2024-10-31',60000.00,1,'Online');
/*!40000 ALTER TABLE `LoanApplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LoanInstallments`
--

DROP TABLE IF EXISTS `LoanInstallments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LoanInstallments` (
  `Installment_ID` int NOT NULL AUTO_INCREMENT,
  `Loan_ID` int DEFAULT NULL,
  `Branch_ID` int DEFAULT NULL,
  `Transaction_ID` int DEFAULT NULL,
  `DueDate` date DEFAULT NULL,
  `Value` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`Installment_ID`),
  KEY `Loan_ID` (`Loan_ID`),
  KEY `Branch_ID` (`Branch_ID`),
  KEY `Transaction_ID` (`Transaction_ID`),
  CONSTRAINT `loaninstallments_ibfk_1` FOREIGN KEY (`Loan_ID`) REFERENCES `Loan` (`Loan_ID`),
  CONSTRAINT `loaninstallments_ibfk_2` FOREIGN KEY (`Branch_ID`) REFERENCES `Branch` (`Branch_ID`),
  CONSTRAINT `loaninstallments_ibfk_3` FOREIGN KEY (`Transaction_ID`) REFERENCES `Transaction` (`Transaction_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoanInstallments`
--

LOCK TABLES `LoanInstallments` WRITE;
/*!40000 ALTER TABLE `LoanInstallments` DISABLE KEYS */;
INSERT INTO `LoanInstallments` VALUES (1,3,1,NULL,'2024-09-21',444.24),(2,3,1,NULL,'2024-11-21',444.24),(3,3,1,NULL,'2024-12-21',444.24),(4,3,1,NULL,'2025-01-21',444.24),(5,3,1,NULL,'2025-02-21',444.24),(6,3,1,NULL,'2025-03-21',444.24),(7,3,1,NULL,'2025-04-21',444.24),(8,3,1,NULL,'2025-05-21',444.24),(9,3,1,NULL,'2025-06-21',444.24),(10,3,1,NULL,'2025-07-21',444.24),(11,3,1,NULL,'2025-08-21',444.24),(12,3,1,NULL,'2025-09-21',444.24),(13,4,1,NULL,'2024-10-21',8884.88),(14,4,1,NULL,'2024-11-21',8884.88),(15,4,1,NULL,'2024-12-21',8884.88),(16,4,1,NULL,'2025-01-21',8884.88),(17,4,1,NULL,'2025-02-21',8884.88),(18,4,1,NULL,'2025-03-21',8884.88),(19,4,1,NULL,'2025-04-21',8884.88),(20,4,1,NULL,'2025-05-21',8884.88),(21,4,1,NULL,'2025-06-21',8884.88),(22,4,1,NULL,'2025-07-21',8884.88),(23,4,1,NULL,'2025-08-21',8884.88),(24,4,1,NULL,'2025-09-21',8884.88),(25,5,1,NULL,'2024-10-23',888.49),(26,5,1,NULL,'2024-11-23',888.49),(27,5,1,NULL,'2024-12-23',888.49),(28,5,1,NULL,'2025-01-23',888.49),(29,5,1,NULL,'2025-02-23',888.49),(30,5,1,NULL,'2025-03-23',888.49),(31,5,1,NULL,'2025-04-23',888.49),(32,5,1,NULL,'2025-05-23',888.49),(33,5,1,NULL,'2025-06-23',888.49),(34,5,1,NULL,'2025-07-23',888.49),(35,5,1,NULL,'2025-08-23',888.49),(36,5,1,NULL,'2025-09-23',888.49),(37,6,1,NULL,'2024-10-23',888.49),(38,6,1,NULL,'2024-11-23',888.49),(39,6,1,NULL,'2024-12-23',888.49),(40,6,1,NULL,'2025-01-23',888.49),(41,6,1,NULL,'2025-02-23',888.49),(42,6,1,NULL,'2025-03-23',888.49),(43,6,1,NULL,'2025-04-23',888.49),(44,6,1,NULL,'2025-05-23',888.49),(45,6,1,NULL,'2025-06-23',888.49),(46,6,1,NULL,'2025-07-23',888.49),(47,6,1,NULL,'2025-08-23',888.49),(48,6,1,NULL,'2025-09-23',888.49),(49,7,1,NULL,'2024-10-23',888.49),(50,7,1,NULL,'2024-11-23',888.49),(51,7,1,NULL,'2024-12-23',888.49),(52,7,1,NULL,'2025-01-23',888.49),(53,7,1,NULL,'2025-02-23',888.49),(54,7,1,NULL,'2025-03-23',888.49),(55,7,1,NULL,'2025-04-23',888.49),(56,7,1,NULL,'2025-05-23',888.49),(57,7,1,NULL,'2025-06-23',888.49),(58,7,1,NULL,'2025-07-23',888.49),(59,7,1,NULL,'2025-08-23',888.49),(60,7,1,NULL,'2025-09-23',888.49),(61,8,1,NULL,'2024-10-23',888.49),(62,8,1,NULL,'2024-11-23',888.49),(63,8,1,NULL,'2024-12-23',888.49),(64,8,1,NULL,'2025-01-23',888.49),(65,8,1,NULL,'2025-02-23',888.49),(66,8,1,NULL,'2025-03-23',888.49),(67,8,1,NULL,'2025-04-23',888.49),(68,8,1,NULL,'2025-05-23',888.49),(69,8,1,NULL,'2025-06-23',888.49),(70,8,1,NULL,'2025-07-23',888.49),(71,8,1,NULL,'2025-08-23',888.49),(72,8,1,NULL,'2025-09-23',888.49),(73,9,1,NULL,'2024-10-23',888.49),(74,9,1,NULL,'2024-11-23',888.49),(75,9,1,NULL,'2024-12-23',888.49),(76,9,1,NULL,'2025-01-23',888.49),(77,9,1,NULL,'2025-02-23',888.49),(78,9,1,NULL,'2025-03-23',888.49),(79,9,1,NULL,'2025-04-23',888.49),(80,9,1,NULL,'2025-05-23',888.49),(81,9,1,NULL,'2025-06-23',888.49),(82,9,1,NULL,'2025-07-23',888.49),(83,9,1,NULL,'2025-08-23',888.49),(84,9,1,NULL,'2025-09-23',888.49),(85,10,1,NULL,'2024-10-23',888.49),(86,10,1,NULL,'2024-11-23',888.49),(87,10,1,NULL,'2024-12-23',888.49),(88,10,1,NULL,'2025-01-23',888.49),(89,10,1,NULL,'2025-02-23',888.49),(90,10,1,NULL,'2025-03-23',888.49),(91,10,1,NULL,'2025-04-23',888.49),(92,10,1,NULL,'2025-05-23',888.49),(93,10,1,NULL,'2025-06-23',888.49),(94,10,1,NULL,'2025-07-23',888.49),(95,10,1,NULL,'2025-08-23',888.49),(96,10,1,NULL,'2025-09-23',888.49),(97,11,1,NULL,'2024-10-23',888.49),(98,11,1,NULL,'2024-11-23',888.49),(99,11,1,NULL,'2024-12-23',888.49),(100,11,1,NULL,'2025-01-23',888.49),(101,11,1,NULL,'2025-02-23',888.49),(102,11,1,NULL,'2025-03-23',888.49),(103,11,1,NULL,'2025-04-23',888.49),(104,11,1,NULL,'2025-05-23',888.49),(105,11,1,NULL,'2025-06-23',888.49),(106,11,1,NULL,'2025-07-23',888.49),(107,11,1,NULL,'2025-08-23',888.49),(108,11,1,NULL,'2025-09-23',888.49),(109,12,1,NULL,'2024-10-23',888.49),(110,12,1,NULL,'2024-11-23',888.49),(111,12,1,NULL,'2024-12-23',888.49),(112,12,1,NULL,'2025-01-23',888.49),(113,12,1,NULL,'2025-02-23',888.49),(114,12,1,NULL,'2025-03-23',888.49),(115,12,1,NULL,'2025-04-23',888.49),(116,12,1,NULL,'2025-05-23',888.49),(117,12,1,NULL,'2025-06-23',888.49),(118,12,1,NULL,'2025-07-23',888.49),(119,12,1,NULL,'2025-08-23',888.49),(120,12,1,NULL,'2025-09-23',888.49),(121,13,1,NULL,'2024-10-23',888.49),(122,13,1,NULL,'2024-11-23',888.49),(123,13,1,NULL,'2024-12-23',888.49),(124,13,1,NULL,'2025-01-23',888.49),(125,13,1,NULL,'2025-02-23',888.49),(126,13,1,NULL,'2025-03-23',888.49),(127,13,1,NULL,'2025-04-23',888.49),(128,13,1,NULL,'2025-05-23',888.49),(129,13,1,NULL,'2025-06-23',888.49),(130,13,1,NULL,'2025-07-23',888.49),(131,13,1,NULL,'2025-08-23',888.49),(132,13,1,NULL,'2025-09-23',888.49),(133,14,1,NULL,'2024-10-23',888.49),(134,14,1,NULL,'2024-11-23',888.49),(135,14,1,NULL,'2024-12-23',888.49),(136,14,1,NULL,'2025-01-23',888.49),(137,14,1,NULL,'2025-02-23',888.49),(138,14,1,NULL,'2025-03-23',888.49),(139,14,1,NULL,'2025-04-23',888.49),(140,14,1,NULL,'2025-05-23',888.49),(141,14,1,NULL,'2025-06-23',888.49),(142,14,1,NULL,'2025-07-23',888.49),(143,14,1,NULL,'2025-08-23',888.49),(144,14,1,NULL,'2025-09-23',888.49),(145,15,1,NULL,'2024-10-23',888.49),(146,15,1,NULL,'2024-11-23',888.49),(147,15,1,NULL,'2024-12-23',888.49),(148,15,1,NULL,'2025-01-23',888.49),(149,15,1,NULL,'2025-02-23',888.49),(150,15,1,NULL,'2025-03-23',888.49),(151,15,1,NULL,'2025-04-23',888.49),(152,15,1,NULL,'2025-05-23',888.49),(153,15,1,NULL,'2025-06-23',888.49),(154,15,1,NULL,'2025-07-23',888.49),(155,15,1,NULL,'2025-08-23',888.49),(156,15,1,NULL,'2025-09-23',888.49),(157,16,1,NULL,'2024-10-23',888.49),(158,16,1,NULL,'2024-11-23',888.49),(159,16,1,NULL,'2024-12-23',888.49),(160,16,1,NULL,'2025-01-23',888.49),(161,16,1,NULL,'2025-02-23',888.49),(162,16,1,NULL,'2025-03-23',888.49),(163,16,1,NULL,'2025-04-23',888.49),(164,16,1,NULL,'2025-05-23',888.49),(165,16,1,NULL,'2025-06-23',888.49),(166,16,1,NULL,'2025-07-23',888.49),(167,16,1,NULL,'2025-08-23',888.49),(168,16,1,NULL,'2025-09-23',888.49),(169,17,1,NULL,'2024-10-23',888.49),(170,17,1,NULL,'2024-11-23',888.49),(171,17,1,NULL,'2024-12-23',888.49),(172,17,1,NULL,'2025-01-23',888.49),(173,17,1,NULL,'2025-02-23',888.49),(174,17,1,NULL,'2025-03-23',888.49),(175,17,1,NULL,'2025-04-23',888.49),(176,17,1,NULL,'2025-05-23',888.49),(177,17,1,NULL,'2025-06-23',888.49),(178,17,1,NULL,'2025-07-23',888.49),(179,17,1,NULL,'2025-08-23',888.49),(180,17,1,NULL,'2025-09-23',888.49),(181,18,1,NULL,'2024-10-23',888.49),(182,18,1,NULL,'2024-11-23',888.49),(183,18,1,NULL,'2024-12-23',888.49),(184,18,1,NULL,'2025-01-23',888.49),(185,18,1,NULL,'2025-02-23',888.49),(186,18,1,NULL,'2025-03-23',888.49),(187,18,1,NULL,'2025-04-23',888.49),(188,18,1,NULL,'2025-05-23',888.49),(189,18,1,NULL,'2025-06-23',888.49),(190,18,1,NULL,'2025-07-23',888.49),(191,18,1,NULL,'2025-08-23',888.49),(192,18,1,NULL,'2025-09-23',888.49),(193,19,1,NULL,'2024-10-23',888.49),(194,19,1,NULL,'2024-11-23',888.49),(195,19,1,NULL,'2024-12-23',888.49),(196,19,1,NULL,'2025-01-23',888.49),(197,19,1,NULL,'2025-02-23',888.49),(198,19,1,NULL,'2025-03-23',888.49),(199,19,1,NULL,'2025-04-23',888.49),(200,19,1,NULL,'2025-05-23',888.49),(201,19,1,NULL,'2025-06-23',888.49),(202,19,1,NULL,'2025-07-23',888.49),(203,19,1,NULL,'2025-08-23',888.49),(204,19,1,NULL,'2025-09-23',888.49),(205,20,1,NULL,'2024-10-23',888.49),(206,20,1,NULL,'2024-11-23',888.49),(207,20,1,NULL,'2024-12-23',888.49),(208,20,1,NULL,'2025-01-23',888.49),(209,20,1,NULL,'2025-02-23',888.49),(210,20,1,NULL,'2025-03-23',888.49),(211,20,1,NULL,'2025-04-23',888.49),(212,20,1,NULL,'2025-05-23',888.49),(213,20,1,NULL,'2025-06-23',888.49),(214,20,1,NULL,'2025-07-23',888.49),(215,20,1,NULL,'2025-08-23',888.49),(216,20,1,NULL,'2025-09-23',888.49),(217,21,1,NULL,'2024-10-23',888.49),(218,21,1,NULL,'2024-11-23',888.49),(219,21,1,NULL,'2024-12-23',888.49),(220,21,1,NULL,'2025-01-23',888.49),(221,21,1,NULL,'2025-02-23',888.49),(222,21,1,NULL,'2025-03-23',888.49),(223,21,1,NULL,'2025-04-23',888.49),(224,21,1,NULL,'2025-05-23',888.49),(225,21,1,NULL,'2025-06-23',888.49),(226,21,1,NULL,'2025-07-23',888.49),(227,21,1,NULL,'2025-08-23',888.49),(228,21,1,NULL,'2025-09-23',888.49),(229,22,1,NULL,'2024-10-23',88.85),(230,22,1,NULL,'2024-11-23',88.85),(231,22,1,NULL,'2024-12-23',88.85),(232,22,1,NULL,'2025-01-23',88.85),(233,22,1,NULL,'2025-02-23',88.85),(234,22,1,NULL,'2025-03-23',88.85),(235,22,1,NULL,'2025-04-23',88.85),(236,22,1,NULL,'2025-05-23',88.85),(237,22,1,NULL,'2025-06-23',88.85),(238,22,1,NULL,'2025-07-23',88.85),(239,22,1,NULL,'2025-08-23',88.85),(240,22,1,NULL,'2025-09-23',88.85),(241,23,1,NULL,'2024-10-23',88.85),(242,23,1,NULL,'2024-11-23',88.85),(243,23,1,NULL,'2024-12-23',88.85),(244,23,1,NULL,'2025-01-23',88.85),(245,23,1,NULL,'2025-02-23',88.85),(246,23,1,NULL,'2025-03-23',88.85),(247,23,1,NULL,'2025-04-23',88.85),(248,23,1,NULL,'2025-05-23',88.85),(249,23,1,NULL,'2025-06-23',88.85),(250,23,1,NULL,'2025-07-23',88.85),(251,23,1,NULL,'2025-08-23',88.85),(252,23,1,NULL,'2025-09-23',88.85),(253,24,1,NULL,'2024-10-23',88.85),(254,24,1,NULL,'2024-11-23',88.85),(255,24,1,NULL,'2024-12-23',88.85),(256,24,1,NULL,'2025-01-23',88.85),(257,24,1,NULL,'2025-02-23',88.85),(258,24,1,NULL,'2025-03-23',88.85),(259,24,1,NULL,'2025-04-23',88.85),(260,24,1,NULL,'2025-05-23',88.85),(261,24,1,NULL,'2025-06-23',88.85),(262,24,1,NULL,'2025-07-23',88.85),(263,24,1,NULL,'2025-08-23',88.85),(264,24,1,NULL,'2025-09-23',88.85),(265,25,1,NULL,'2024-10-23',88.85),(266,25,1,NULL,'2024-11-23',88.85),(267,25,1,NULL,'2024-12-23',88.85),(268,25,1,NULL,'2025-01-23',88.85),(269,25,1,NULL,'2025-02-23',88.85),(270,25,1,NULL,'2025-03-23',88.85),(271,25,1,NULL,'2025-04-23',88.85),(272,25,1,NULL,'2025-05-23',88.85),(273,25,1,NULL,'2025-06-23',88.85),(274,25,1,NULL,'2025-07-23',88.85),(275,25,1,NULL,'2025-08-23',88.85),(276,25,1,NULL,'2025-09-23',88.85),(277,26,1,NULL,'2024-10-23',88.85),(278,26,1,NULL,'2024-11-23',88.85),(279,26,1,NULL,'2024-12-23',88.85),(280,26,1,NULL,'2025-01-23',88.85),(281,26,1,NULL,'2025-02-23',88.85),(282,26,1,NULL,'2025-03-23',88.85),(283,26,1,NULL,'2025-04-23',88.85),(284,26,1,NULL,'2025-05-23',88.85),(285,26,1,NULL,'2025-06-23',88.85),(286,26,1,NULL,'2025-07-23',88.85),(287,26,1,NULL,'2025-08-23',88.85),(288,26,1,NULL,'2025-09-23',88.85),(289,27,1,NULL,'2024-10-23',88.85),(290,27,1,NULL,'2024-11-23',88.85),(291,27,1,NULL,'2024-12-23',88.85),(292,27,1,NULL,'2025-01-23',88.85),(293,27,1,NULL,'2025-02-23',88.85),(294,27,1,NULL,'2025-03-23',88.85),(295,27,1,NULL,'2025-04-23',88.85),(296,27,1,NULL,'2025-05-23',88.85),(297,27,1,NULL,'2025-06-23',88.85),(298,27,1,NULL,'2025-07-23',88.85),(299,27,1,NULL,'2025-08-23',88.85),(300,27,1,NULL,'2025-09-23',88.85),(301,51,1,NULL,'2024-10-25',7912.43),(302,51,1,NULL,'2024-11-25',7912.43),(303,51,1,NULL,'2024-12-25',7912.43),(304,51,1,NULL,'2025-01-25',7912.43),(305,51,1,NULL,'2025-02-25',7912.43),(306,51,1,NULL,'2025-03-25',7912.43),(307,51,1,NULL,'2025-04-25',7912.43),(308,51,1,NULL,'2025-05-25',7912.43),(309,51,1,NULL,'2025-06-25',7912.43),(310,51,1,NULL,'2025-07-25',7912.43),(311,51,1,NULL,'2025-08-25',7912.43),(312,51,1,NULL,'2025-09-25',7912.43),(313,52,9,6,'2024-11-04',85.38),(314,52,9,8,'2024-12-04',85.38),(315,52,9,11,'2024-09-04',85.38),(316,52,9,13,'2025-02-04',85.38),(317,52,9,14,'2025-03-04',85.38),(318,52,9,41,'2025-04-04',85.38),(319,52,9,NULL,'2025-05-04',85.38),(320,52,9,NULL,'2025-06-04',85.38),(321,52,9,NULL,'2025-07-04',85.38),(322,52,9,NULL,'2025-08-04',85.38),(323,52,9,NULL,'2025-09-04',85.38),(324,52,9,NULL,'2025-10-04',85.38),(325,53,9,NULL,'2024-11-04',557.98),(326,53,9,NULL,'2024-12-04',557.98),(327,53,9,NULL,'2025-01-04',557.98),(328,53,9,NULL,'2025-02-04',557.98),(329,53,9,NULL,'2025-03-04',557.98),(330,53,9,NULL,'2025-04-04',557.98),(331,53,9,NULL,'2025-05-04',557.98),(332,53,9,NULL,'2025-06-04',557.98),(333,53,9,NULL,'2025-07-04',557.98),(334,53,9,NULL,'2025-08-04',557.98),(335,53,9,NULL,'2025-09-04',557.98),(336,53,9,NULL,'2025-10-04',557.98),(337,53,9,NULL,'2025-11-04',557.98),(338,53,9,NULL,'2025-12-04',557.98),(339,53,9,NULL,'2026-01-04',557.98),(340,53,9,NULL,'2026-02-04',557.98),(341,53,9,NULL,'2026-03-04',557.98),(342,53,9,NULL,'2026-04-04',557.98),(343,53,9,NULL,'2026-05-04',557.98),(344,53,9,NULL,'2026-06-04',557.98),(345,53,9,NULL,'2026-07-04',557.98),(346,53,9,NULL,'2026-08-04',557.98),(347,53,9,NULL,'2026-09-04',557.98),(348,53,9,NULL,'2026-10-04',557.98),(349,53,9,NULL,'2026-11-04',557.98),(350,53,9,NULL,'2026-12-04',557.98),(351,53,9,NULL,'2027-01-04',557.98),(352,53,9,NULL,'2027-02-04',557.98),(353,53,9,NULL,'2027-03-04',557.98),(354,53,9,NULL,'2027-04-04',557.98),(355,53,9,NULL,'2027-05-04',557.98),(356,53,9,NULL,'2027-06-04',557.98),(357,53,9,NULL,'2027-07-04',557.98),(358,53,9,NULL,'2027-08-04',557.98),(359,53,9,NULL,'2027-09-04',557.98),(360,53,9,NULL,'2027-10-04',557.98),(361,53,9,NULL,'2027-11-04',557.98),(362,53,9,NULL,'2027-12-04',557.98),(363,53,9,NULL,'2028-01-04',557.98),(364,53,9,NULL,'2028-02-04',557.98),(365,53,9,NULL,'2028-03-04',557.98),(366,53,9,NULL,'2028-04-04',557.98),(367,53,9,NULL,'2028-05-04',557.98),(368,53,9,NULL,'2028-06-04',557.98),(369,53,9,NULL,'2028-07-04',557.98),(370,53,9,NULL,'2028-08-04',557.98),(371,53,9,NULL,'2028-09-04',557.98),(372,53,9,NULL,'2028-10-04',557.98),(373,54,9,9,'2024-11-04',110.80),(374,54,9,10,'2024-12-04',110.80),(375,54,9,12,'2025-01-04',110.80),(376,54,9,15,'2025-02-04',110.80),(377,54,9,NULL,'2025-03-04',110.80),(378,54,9,NULL,'2025-04-04',110.80),(379,54,9,NULL,'2025-05-04',110.80),(380,54,9,NULL,'2025-06-04',110.80),(381,54,9,NULL,'2025-07-04',110.80),(382,54,9,NULL,'2025-08-04',110.80),(383,54,9,NULL,'2025-09-04',110.80),(384,54,9,NULL,'2025-10-04',110.80),(385,54,9,NULL,'2025-11-04',110.80),(386,54,9,NULL,'2025-12-04',110.80),(387,54,9,NULL,'2026-01-04',110.80),(388,54,9,NULL,'2026-02-04',110.80),(389,54,9,NULL,'2026-03-04',110.80),(390,54,9,NULL,'2026-04-04',110.80),(391,54,9,NULL,'2026-05-04',110.80),(392,54,9,NULL,'2026-06-04',110.80),(393,54,9,NULL,'2026-07-04',110.80),(394,54,9,NULL,'2026-08-04',110.80),(395,54,9,NULL,'2026-09-04',110.80),(396,54,9,NULL,'2026-10-04',110.80),(397,1,1,NULL,'2024-02-01',8583.49),(398,1,1,NULL,'2024-03-01',8583.49),(399,1,1,NULL,'2024-04-01',8583.49),(400,1,1,NULL,'2024-05-01',8583.49),(401,1,1,NULL,'2024-06-01',8583.49),(402,1,1,NULL,'2024-07-01',8583.49),(403,1,1,NULL,'2024-08-01',8583.49),(404,1,1,NULL,'2024-09-01',8583.49),(405,1,1,NULL,'2024-10-01',8583.49),(406,1,1,NULL,'2024-11-01',8583.49),(407,1,1,NULL,'2024-12-01',8583.49),(408,1,1,NULL,'2025-01-01',8583.49),(409,55,1,NULL,'2024-11-12',2588.23),(410,55,1,NULL,'2024-12-12',2588.23),(411,55,1,NULL,'2025-01-12',2588.23),(412,55,1,NULL,'2025-02-12',2588.23),(413,55,1,NULL,'2025-03-12',2588.23),(414,55,1,NULL,'2025-04-12',2588.23),(415,1,1,NULL,'2024-02-01',8583.49),(416,1,1,NULL,'2024-03-01',8583.49),(417,1,1,NULL,'2024-04-01',8583.49),(418,1,1,NULL,'2024-05-01',8583.49),(419,1,1,NULL,'2024-06-01',8583.49),(420,1,1,NULL,'2024-07-01',8583.49),(421,1,1,NULL,'2024-08-01',8583.49),(422,1,1,NULL,'2024-09-01',8583.49),(423,1,1,NULL,'2024-10-01',8583.49),(424,1,1,NULL,'2024-11-01',8583.49),(425,1,1,NULL,'2024-12-01',8583.49),(426,1,1,NULL,'2025-01-01',8583.49),(427,57,10,NULL,'2024-11-12',10175.73),(428,57,10,NULL,'2024-12-12',10175.73),(429,57,10,NULL,'2025-01-12',10175.73),(430,57,10,NULL,'2025-02-12',10175.73),(431,57,10,NULL,'2025-03-12',10175.73),(432,57,10,NULL,'2025-04-12',10175.73),(433,59,10,NULL,'2024-11-12',10175.73),(434,59,10,NULL,'2024-12-12',10175.73),(435,59,10,NULL,'2025-01-12',10175.73),(436,59,10,NULL,'2025-02-12',10175.73),(437,59,10,NULL,'2025-03-12',10175.73),(438,59,10,NULL,'2025-04-12',10175.73),(439,60,5,NULL,'2024-11-12',10175.73),(440,60,5,NULL,'2024-12-12',10175.73),(441,60,5,NULL,'2025-01-12',10175.73),(442,60,5,NULL,'2025-02-12',10175.73),(443,60,5,NULL,'2025-03-12',10175.73),(444,60,5,NULL,'2025-04-12',10175.73),(445,60,5,NULL,'2024-11-12',10175.73),(446,60,5,NULL,'2024-12-12',10175.73),(447,60,5,NULL,'2025-01-12',10175.73),(448,60,5,NULL,'2025-02-12',10175.73),(449,60,5,NULL,'2025-03-12',10175.73),(450,60,5,NULL,'2025-04-12',10175.73);
/*!40000 ALTER TABLE `LoanInstallments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manager`
--

DROP TABLE IF EXISTS `Manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Manager` (
  `Manager_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`Manager_ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manager`
--

LOCK TABLES `Manager` WRITE;
/*!40000 ALTER TABLE `Manager` DISABLE KEYS */;
INSERT INTO `Manager` VALUES (1,'John Smith','johnsmith','$2b$10$TrbrjxFzBinObPhzJ2C9cOrjQOC1rTFo/YibzYQRk6b7wDEkY/5zW'),(2,'Jane Doe','janedoe','$2b$10$q2H7YixFE2yl8i3LbxgBFOXnCnr82nkPW5RQdNZiWKzpeXoFCewfG'),(3,'Michael Johnson','michaeljohnson','$2b$10$z0/DwKjkW3.c.WeEy8lWR.E3CkBkwxinev5O68fq1Tri3Kszcp3T6'),(4,'Emily Davis','emilydavis','$2b$10$HZwgonixSxtuBi9kpe2HK.YfiL0/gVxeKUz1gY3mJzom33.VeZrk2'),(5,'Christopher Brown','christopherbrown','$2b$10$2JNGrUv5T5Pq/YYhZdCCYOrTFEQX9CeiQ.PbEsG4Y2UgExbL8FeIa'),(6,'Jessica Wilson','jessicawilson','$2b$10$WF7RxiX2O08dnwYvjYSVfeJ..H9RWYh4o2usRePgHcHDX5fZCvwSK'),(7,'Daniel Martinez','danielmartinez','$2b$10$lx27u9U6Rl9oNsX2eGZH0eFm0/eZthmrGkU1YATZY71JST3jw4NzC'),(8,'Sarah Miller','sarahmiller','$2b$10$.FLvC/kcaXDRBnYCB1JGZewCuDFS76E94GpmItaAHkqH2Ma9HE5LG'),(9,'David Garcia','davidgarcia','$2b$10$xxWmM7rJ4PxDp.pZdA0H5.e4UJ1wboNQjWiyV2CTcR80Gv9zCyWOO'),(10,'Sophia Anderson','sophiaanderson','$2b$10$3ZAympTpWwWaW8j7zLcPteyOth3zrPHazhXu1YW4lSdQeanp.1q2i');
/*!40000 ALTER TABLE `Manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Online_loan_to_FD`
--

DROP TABLE IF EXISTS `Online_loan_to_FD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Online_loan_to_FD` (
  `Application_ID` int NOT NULL,
  `FD_ID` int NOT NULL,
  PRIMARY KEY (`Application_ID`,`FD_ID`),
  KEY `Application_ID` (`Application_ID`),
  KEY `FD_ID` (`FD_ID`),
  CONSTRAINT `online_loan_to_fd_ibfk_1` FOREIGN KEY (`Application_ID`) REFERENCES `LoanApplication` (`Application_ID`),
  CONSTRAINT `online_loan_to_fd_ibfk_2` FOREIGN KEY (`FD_ID`) REFERENCES `FD` (`FD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Online_loan_to_FD`
--

LOCK TABLES `Online_loan_to_FD` WRITE;
/*!40000 ALTER TABLE `Online_loan_to_FD` DISABLE KEYS */;
INSERT INTO `Online_loan_to_FD` VALUES (42,21),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(53,2),(54,2),(56,2),(57,41),(58,43),(59,44),(60,45),(61,46);
/*!40000 ALTER TABLE `Online_loan_to_FD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction` (
  `Transaction_ID` int NOT NULL AUTO_INCREMENT,
  `FromAccount` int DEFAULT NULL,
  `ToAccount` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Value` decimal(15,2) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `FromAccount` (`FromAccount`),
  KEY `ToAccount` (`ToAccount`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`FromAccount`) REFERENCES `Account` (`Account_ID`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`ToAccount`) REFERENCES `Account` (`Account_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES (3,9,24,'2024-10-03',1000.00,'debit'),(4,64,NULL,'2024-10-03',61.06,'Interest Payment'),(5,2,5,'2024-10-04',500.00,'test'),(6,2,1,'2024-10-04',52.00,'Loan Payment'),(7,65,2,'2024-10-04',250.00,'credit'),(8,27,1,'2024-10-04',52.00,'Loan Payment'),(9,2,1,'2024-10-06',54.00,'Loan Payment'),(10,65,1,'2024-10-08',54.00,'Loan Payment'),(11,27,1,'2024-10-08',52.00,'Loan Payment'),(12,2,1,'2024-10-08',54.00,'Loan Payment'),(13,65,1,'2024-10-08',52.00,'Loan Payment'),(14,2,1,'2024-10-08',52.00,'Loan Payment'),(15,27,1,'2024-10-08',110.80,'Loan Payment'),(16,2,45,'2024-10-09',50.00,'Test'),(17,27,26,'2024-10-09',41.00,'255'),(18,66,NULL,'2024-10-10',61.50,'Interest Payment'),(19,27,1,'2024-10-15',9.00,'jij'),(20,2,1,'2024-10-15',1.00,'test'),(21,2,1,'2024-10-13',1.00,'Test'),(22,2,1,'2024-10-15',1.00,'Test'),(23,2,25,'2024-10-12',400.00,'test'),(24,65,25,'2024-10-12',50.00,'Test'),(25,65,25,'2024-10-12',50.00,'Test'),(26,2,50,'2024-10-12',20.00,'testing'),(27,2,2,'2024-10-15',50.00,'test'),(28,2,2,'2024-10-15',50.00,'test'),(29,2,5,'2024-10-15',250.00,'test'),(30,2,5,'2024-10-15',500.00,'test'),(31,27,30,'2024-10-15',50.00,'test 10'),(32,65,2,'2024-10-15',500.00,'test 11'),(33,2,6,'2024-10-15',300.00,'test 13'),(34,2,10,'2024-10-15',50.00,'test 14'),(35,65,2,'2024-10-15',50.00,'hhh'),(36,2,65,'2024-10-15',100.00,'test'),(37,2,20,'2024-10-15',50.00,'test'),(38,2,2,'2024-10-15',500.00,'test 10'),(39,27,2,'2024-10-15',50.00,'test'),(40,2,65,'2024-10-15',56.00,'test'),(41,2,1,'2024-10-15',85.38,'Loan Payment'),(42,24,2,'2024-10-15',500.00,'test'),(43,24,65,'2024-10-15',100.00,'test'),(44,24,65,'2024-10-15',100.00,'ll'),(45,24,65,'2024-10-15',50.00,'ll'),(46,24,50,'2024-10-15',50.00,'ll');
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `CheckTransactionCountBeforeInsert` BEFORE INSERT ON `Transaction` FOR EACH ROW BEGIN
    DECLARE transactionCount INT;

    -- Count the number of transactions for the current month
    SELECT COUNT(*)
    INTO transactionCount
    FROM Transaction
    WHERE FromAccount = NEW.FromAccount
      AND MONTH(Date) = MONTH(CURRENT_DATE())
      AND YEAR(Date) = YEAR(CURRENT_DATE());

    -- Raise an error if the transaction count exceeds 5
    IF transactionCount >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction limit for the current month exceeded';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `UpdateAccountBalancesAfterTransaction` AFTER INSERT ON `Transaction` FOR EACH ROW BEGIN
    -- Update the balance of the from account (debit the amount)
    IF NEW.FromAccount IS NOT NULL THEN
        UPDATE Account
        SET Balance = Balance - NEW.Value
        WHERE Account_ID = NEW.FromAccount;
    END IF;

    -- Update the balance of the to account (credit the amount)
    IF NEW.ToAccount IS NOT NULL THEN
        UPDATE Account
        SET Balance = Balance + NEW.Value
        WHERE Account_ID = NEW.ToAccount;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'bank_db'
--

--
-- Dumping routines for database 'bank_db'
--
/*!50003 DROP FUNCTION IF EXISTS `branchId_by_managerId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" FUNCTION "branchId_by_managerId"(managerId int) RETURNS int
    READS SQL DATA
    DETERMINISTIC
begin
    declare b_id int;
    select Branch_ID into b_id
    from Branch
    where Manager_ID = managerId;
    return b_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetBranchIDByManagerID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" FUNCTION "GetBranchIDByManagerID"(p_Manager_ID INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE branch_id INT;

    -- Retrieve Branch_ID based on Manager_ID
    SELECT Branch_ID INTO branch_id
    FROM Branch
    WHERE Manager_ID = p_Manager_ID
    LIMIT 1;

    -- Return the Branch_ID
    RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetTotalLoanValueByFD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" FUNCTION "GetTotalLoanValueByFD"(p_FD_ID INT) RETURNS decimal(15,2)
    DETERMINISTIC
BEGIN
    DECLARE totalLoanValue DECIMAL(15, 2);

    -- Calculate the total loan value
    SELECT SUM(l.LoanValue) INTO totalLoanValue
    FROM Loan l
    JOIN LoanApplication la ON l.Application_ID = la.Application_ID
    JOIN Online_loan_to_FD olf ON la.Application_ID = olf.Application_ID
    WHERE olf.FD_ID = p_FD_ID AND la.LoanType = 'Online';

    -- Return the total loan value, or 0 if no loans are found
    RETURN IFNULL(totalLoanValue, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateLoanInstallmentsSet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "CreateLoanInstallmentsSet"(
    IN p_Loan_ID INT,
    IN p_Branch_ID INT,
    IN p_Loan_Period INT,
    IN p_Interest_Rate DECIMAL(5, 2),
    IN p_Loan_Value DECIMAL(15, 2),
    IN p_Start_Date DATE
)
BEGIN
    DECLARE monthlyInterestRate DECIMAL(10, 5);
    DECLARE numberOfPayments INT;
    DECLARE monthlyInstallment DECIMAL(15, 2);
    DECLARE installmentValue DECIMAL(15, 2);
    DECLARE i INT DEFAULT 1;
    DECLARE dueDate DATE;

    -- Calculate monthly interest rate
    SET monthlyInterestRate = p_Interest_Rate / 1200;

    -- Calculate number of payments (months)
    SET numberOfPayments = p_Loan_Period;

    -- Calculate monthly installment using the amortizing loan formula
    SET monthlyInstallment = (p_Loan_Value * monthlyInterestRate) / (1 - POW(1 + monthlyInterestRate, -numberOfPayments));

    -- Loop through the number of payments to create each installment
    WHILE i <= numberOfPayments DO
        -- Calculate the due date for each installment
        SET dueDate = DATE_ADD(p_Start_Date, INTERVAL i MONTH);

        -- Insert the installment record into the LoanInstallments table
        INSERT INTO LoanInstallments (Loan_ID, Branch_ID, Transaction_ID, DueDate, Value)
        VALUES (p_Loan_ID, p_Branch_ID, NULL, dueDate, ROUND(monthlyInstallment, 2));

        -- Increment loop counter
        SET i = i + 1;
    END WHILE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateOnlineLoan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "CreateOnlineLoan"(
    IN p_Branch_ID INT,
    IN p_Customer_ID INT,
    IN p_LoanPeriod INT,
    IN p_InterestRate DECIMAL(5, 2),
    IN p_StartDate DATE,
    IN p_LoanValue DECIMAL(15, 2),
    IN p_FD_ID INT
)
BEGIN
    DECLARE existingLoans DECIMAL(15, 2) DEFAULT 0;
    DECLARE maxLoanValue DECIMAL(15, 2);
    DECLARE fdInitialAmount DECIMAL(15, 2);
    DECLARE loanApplicationId INT;
    DECLARE loanId INT;
    DECLARE applicationApproved INT DEFAULT 1;  -- Assuming the loan is approved

    -- Get the total loan value already taken against the specified FD using the function
    SET existingLoans = GetTotalLoanValueByFD(p_FD_ID);

    -- Get the fixed deposit details
    SELECT InitialAmount INTO fdInitialAmount
    FROM FD
    WHERE FD_ID = p_FD_ID;

    -- Calculate the maximum loan value allowed (60% of FD amount)
    SET maxLoanValue = fdInitialAmount * 0.6;

    -- Check if the requested loan value exceeds the allowed limit
    IF (existingLoans + p_LoanValue) > maxLoanValue THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Requested loan value exceeds the maximum allowed limit ';
    ELSE
        -- Insert loan application (assuming it's auto-approved)
        INSERT INTO LoanApplication (Branch_ID, Customer_ID, LoanPeriod, Date, LoanValue, Approved, LoanType)
        VALUES (p_Branch_ID, p_Customer_ID, p_LoanPeriod, p_StartDate, p_LoanValue, applicationApproved, 'Online');
        SET loanApplicationId = LAST_INSERT_ID();

        -- Update loan application approval status
        UPDATE LoanApplication
        SET Approved = 1  -- Assuming the loan is approved after validation
        WHERE Application_ID = loanApplicationId;

        -- Create the loan entry
        INSERT INTO Loan (Branch_ID, Customer_ID, LoanPeriod, InterestRate, Date, LoanValue, Application_ID)
        VALUES (p_Branch_ID, p_Customer_ID, p_LoanPeriod, p_InterestRate, CURDATE(), p_LoanValue, loanApplicationId);
        SET loanId = LAST_INSERT_ID();

        -- Link the loan application to the FD
        INSERT INTO Online_loan_to_FD (Application_ID, FD_ID)
        VALUES (loanApplicationId, p_FD_ID);
    END IF;

    -- Return the loan ID
    SELECT loanId AS Loan_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetBranchByManagerID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "GetBranchByManagerID"(IN p_Manager_ID INT)
BEGIN
    SELECT Branch_ID 
    FROM Branch 
    WHERE Manager_ID = p_Manager_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFDsByCustomerID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "GetFDsByCustomerID"(IN p_Customer_ID INT)
BEGIN
    SELECT fd.*
    FROM FD fd
    JOIN Account a ON fd.Account_ID = a.Account_ID
    WHERE a.Customer_ID = p_Customer_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-15 14:16:39
