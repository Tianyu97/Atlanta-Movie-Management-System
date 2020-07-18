CREATE DATABASE  IF NOT EXISTS `team26` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `team26`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: team26
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `username` varchar(45) NOT NULL COMMENT 'Admin cannot decline "approved" users',
  PRIMARY KEY (`username`),
  CONSTRAINT `admin_empoyee(fk3)` FOREIGN KEY (`username`) REFERENCES `employee` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('cool_class4400');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `compname` varchar(45) NOT NULL,
  PRIMARY KEY (`compname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('4400 Theater Company'),('AI Theater Company'),('Awesome Theater Company'),('EZ Theater Company');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creditcard`
--

DROP TABLE IF EXISTS `creditcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creditcard` (
  `credicardnum` char(16) NOT NULL,
  `ownedby` varchar(45) NOT NULL,
  PRIMARY KEY (`credicardnum`),
  KEY `creditcar_user(fk12)_idx` (`ownedby`),
  CONSTRAINT `creditcar_user(fk12)` FOREIGN KEY (`ownedby`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditcard`
--

LOCK TABLES `creditcard` WRITE;
/*!40000 ALTER TABLE `creditcard` DISABLE KEYS */;
INSERT INTO `creditcard` VALUES ('1111111111000000','calcultron'),('1111111100000000','calcultron2'),('1111111110000000','calcultron2'),('1111111111100000','calcwizard'),('2222222222000000','cool_class4400'),('2220000000000000','DNAhelix'),('2222222200000000','does2Much'),('2222222222222200','eeqmcsquare'),('2222222222200000','entropyRox'),('2222222222220000','entropyRox'),('1100000000000000','fullMetal'),('1111111111110000','georgep'),('1111111111111000','georgep'),('1111111111111100','georgep'),('1111111111111110','georgep'),('1111111111111111','georgep'),('2222222222222220','ilikemoney$$'),('2222222222222222','ilikemoney$$'),('9000000000000000','ilikemoney$$'),('1111110000000000','imready'),('1110000000000000','isthisthekrustykrab'),('1111000000000000','isthisthekrustykrab'),('1111100000000000','isthisthekrustykrab'),('1000000000000000','notFullMetal'),('2222222000000000','programerAAL'),('3333333333333300','RitzLover28'),('2222222220000000','thePiGuy3.14'),('2222222222222000','theScienceGuy');
/*!40000 ALTER TABLE `creditcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `username` varchar(45) NOT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `customer_user(fk1)` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('calcultron'),('calcultron2'),('calcwizard'),('clarinetbeast'),('cool_class4400'),('DNAhelix'),('does2Much'),('eeqmcsquare'),('entropyRox'),('fullMetal'),('georgep'),('ilikemoney$$'),('imready'),('isthisthekrustykrab'),('notFullMetal'),('programerAAL'),('RitzLover28'),('thePiGuy3.14'),('theScienceGuy');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `username` varchar(45) NOT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `employee_user(fk2)` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('calcultron'),('cool_class4400'),('entropyRox'),('fatherAI'),('georgep'),('ghcghc'),('imbatman'),('manager1'),('manager2'),('manager3'),('manager4'),('radioactivePoRa');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `username` varchar(45) NOT NULL,
  `zipcode` char(5) NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` enum('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TD','TX','UT','VT','VA','WA','WV','WI','WY') NOT NULL COMMENT '“AL”,”AK”,”AZ”,”AR”,”CA”,”CO”,”CT”,”DE”,”FL”,”GA”,”HI”,”ID”,”IL”,”IN”,”IA”,”KS”,”KY”,”LA”,”ME”,”MD,”MA”,”MI”,”MN”,”MS”,”MO”,”NE”,”NV”,”NH”,”NJ”,”NM”,”NY”,”NC”,”ND”,”OH”,”OK”,”OR”,”PA”,”RI”,”SC”,”SD”,”TN”,”TX”,”UT”,”VT”,”VA”,”WA”,”WV”,”WI”,”WY”',
  `work_in` varchar(45) NOT NULL COMMENT 'Manager works for the same company that owns the theater managed by the manage.',
  PRIMARY KEY (`username`),
  UNIQUE KEY `address` (`zipcode`,`street`,`city`,`state`),
  KEY `manager_company(fk11)_idx` (`work_in`),
  CONSTRAINT `manager_company(fk11)` FOREIGN KEY (`work_in`) REFERENCES `company` (`compname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manager_empoyee(fk4)` FOREIGN KEY (`username`) REFERENCES `employee` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES ('calcultron','30308','123 Peachtree St','Atlanta','GA','EZ Theater Company'),('entropyRox','94016','200 Cool Place','San Francisco','CA','4400 Theater Company'),('fatherAI','10001','456 Main St','New York','NY','EZ Theater Company'),('georgep','98105','10 Pearl Dr','Seattle','WA','4400 Theater Company'),('ghcghc','31415','100 Pi St','Pallet Town','KS','AI Theater Company'),('imbatman','78653','800 Color Dr','Austin','TX','Awesome Theater Company'),('manager1','30332','123 Ferst Drive','Atlanta','GA','4400 Theater Company'),('manager2','30332','456 Ferst Drive','Atlanta','GA','AI Theater Company'),('manager3','30332','789 Ferst Drive','Atlanta','GA','4400 Theater Company'),('manager4','30332','000 Ferst Drive','Atlanta','GA','4400 Theater Company'),('radioactivePoRa','94088','100 Blu St','Sunnyvale','CA','4400 Theater Company');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `moviename` varchar(45) NOT NULL,
  `releaseDate` date NOT NULL,
  `duration` int(11) NOT NULL,
  PRIMARY KEY (`moviename`,`releaseDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES ('4400 The Movie','2019-08-12',130),('Avengers: Endgame','2019-04-26',181),('Calculus Returns: A ML Story','2019-09-19',314),('George P Burdell\'s Life Story','1927-08-12',100),('Georgia Tech The Movie','1985-08-13',100),('How to Train Your Dragon','2010-03-21',98),('Spaceballs','1987-06-24',96),('Spider-Man: Into the Spider-Verse','2018-12-01',117),('The First Pokemon Movie','1998-07-19',75),('The King\'s Speech','2010-11-26',119);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movieplay`
--

DROP TABLE IF EXISTS `movieplay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movieplay` (
  `moviename` varchar(45) NOT NULL,
  `releasedate` date NOT NULL,
  `date` date NOT NULL COMMENT 'MoviePlay date comes after Movie''s release date',
  `compname` varchar(45) NOT NULL,
  `theatername` varchar(45) NOT NULL COMMENT 'MoviesPlay Per Day cannot exceed the theater capacity',
  PRIMARY KEY (`moviename`,`releasedate`,`date`,`compname`,`theatername`),
  KEY `movieplay_movie(fk6)_idx` (`moviename`,`releasedate`),
  KEY `movieplay_theater(fk7)_idx` (`compname`,`theatername`),
  CONSTRAINT `movieplay_date(fk6)` FOREIGN KEY (`moviename`, `releasedate`) REFERENCES `movie` (`moviename`, `releaseDate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `movieplay_theater(fk7)` FOREIGN KEY (`compname`, `theatername`) REFERENCES `theater` (`compname`, `theaname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movieplay`
--

LOCK TABLES `movieplay` WRITE;
/*!40000 ALTER TABLE `movieplay` DISABLE KEYS */;
INSERT INTO `movieplay` VALUES ('4400 The Movie','2019-08-12','2019-08-12','EZ Theater Company','Star Movies'),('4400 The Movie','2019-08-12','2019-09-12','4400 Theater Company','Cinema Star'),('4400 The Movie','2019-08-12','2019-10-12','Awesome Theater Company','ABC Theater'),('Calculus Returns: A ML Story','2019-09-19','2019-10-10','AI Theater Company','ML Movies'),('Calculus Returns: A ML Story','2019-09-19','2019-12-30','AI Theater Company','ML Movies'),('George P Burdell\'s Life Story','1927-08-12','2010-05-20','4400 Theater Company','Cinema Star'),('George P Burdell\'s Life Story','1927-08-12','2019-07-14','EZ Theater Company','Main Movies'),('George P Burdell\'s Life Story','1927-08-12','2019-10-22','EZ Theater Company','Main Movies'),('Georgia Tech The Movie','1985-08-13','1985-08-13','Awesome Theater Company','ABC Theater'),('Georgia Tech The Movie','1985-08-13','2019-09-30','4400 Theater Company','Cinema Star'),('How to Train Your Dragon','2010-03-21','2010-03-22','EZ Theater Company','Main Movies'),('How to Train Your Dragon','2010-03-21','2010-03-23','EZ Theater Company','Main Movies'),('How to Train Your Dragon','2010-03-21','2010-03-25','EZ Theater Company','Star Movies'),('How to Train Your Dragon','2010-03-21','2010-04-02','4400 Theater Company','Cinema Star'),('Spaceballs','1987-06-24','1999-06-24','EZ Theater Company','Main Movies'),('Spaceballs','1987-06-24','2000-02-02','4400 Theater Company','Cinema Star'),('Spaceballs','1987-06-24','2010-04-02','AI Theater Company','ML Movies'),('Spaceballs','1987-06-24','2023-01-23','AI Theater Company','ML Movies'),('Spider-Man: Into the Spider-Verse','2018-12-01','2019-09-30','AI Theater Company','ML Movies'),('The First Pokemon Movie','1998-07-19','2018-07-19','Awesome Theater Company','ABC Theater'),('The King\'s Speech','2010-11-26','2019-12-20','4400 Theater Company','Cinema Star'),('The King\'s Speech','2010-11-26','2019-12-20','EZ Theater Company','Main Movies');
/*!40000 ALTER TABLE `movieplay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderhistory`
--

DROP TABLE IF EXISTS `orderhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderhistory` (
  `creditcardnum` char(16) NOT NULL,
  `moviename` varchar(45) NOT NULL,
  `releasedate` date NOT NULL,
  `date` date NOT NULL,
  `compname` varchar(45) NOT NULL,
  `theaname` varchar(45) NOT NULL,
  PRIMARY KEY (`creditcardnum`,`moviename`,`releasedate`,`date`,`compname`,`theaname`),
  KEY `orderhistory_movieplay(fk14)_idx` (`moviename`,`releasedate`,`date`,`compname`,`theaname`),
  CONSTRAINT `orderhistory_credicard(fk13)` FOREIGN KEY (`creditcardnum`) REFERENCES `creditcard` (`credicardnum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderhistory`
--

LOCK TABLES `orderhistory` WRITE;
/*!40000 ALTER TABLE `orderhistory` DISABLE KEYS */;
INSERT INTO `orderhistory` VALUES ('1111111111111111','How to Train Your Dragon','2010-03-21','2010-03-22','EZ Theater Company','Main Movies'),('1111111111111111','How to Train Your Dragon','2010-03-21','2010-03-23','EZ Theater Company','Main Movies'),('1111111111111100','How to Train Your Dragon','2010-03-21','2010-03-25','EZ Theater Company','Star Movies'),('1111111111111111','How to Train Your Dragon','2010-03-21','2010-04-02','4400 Theater Company','Cinema Star');
/*!40000 ALTER TABLE `orderhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theater`
--

DROP TABLE IF EXISTS `theater`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theater` (
  `compname` varchar(45) NOT NULL,
  `theaname` varchar(45) NOT NULL,
  `zipcode` char(5) NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` enum('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TD','TX','UT','VT','VA','WA','WV','WI','WY') NOT NULL,
  `capacity` int(11) NOT NULL,
  `manageby` varchar(45) NOT NULL,
  PRIMARY KEY (`compname`,`theaname`),
  KEY `theater_manager(fk8)_idx` (`manageby`),
  CONSTRAINT `theater_company(fk5)` FOREIGN KEY (`compname`) REFERENCES `company` (`compname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `theater_manager(fk8)` FOREIGN KEY (`manageby`) REFERENCES `manager` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theater`
--

LOCK TABLES `theater` WRITE;
/*!40000 ALTER TABLE `theater` DISABLE KEYS */;
INSERT INTO `theater` VALUES ('4400 Theater Company','Cinema Star','94016','100 Cool Place','San Francisco','CA',4,'entropyRox'),('4400 Theater Company','Jonathan\'s Movies','98101','67 Pearl Dr','Seattle','WA',2,'georgep'),('4400 Theater Company','Star Movies','80301','4400 Rocks Ave','Boulder','CA',5,'radioactivePoRa'),('AI Theater Company','ML Movies','31415','314 Pi St','Pallet Town','KS',3,'ghcghc'),('Awesome Theater Company','ABC Theater','73301','880 Color Dr','Austin','TX',5,'imbatman'),('EZ Theater Company','Main Movies','10001','123 Main St','New York','NY',3,'fatherAI'),('EZ Theater Company','Star Movies','30332','745 GT St','Atlanta','GA',2,'calcultron');
/*!40000 ALTER TABLE `theater` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(45) NOT NULL,
  `status` enum('Pending','All','Declined','Approved') NOT NULL,
  `password` varchar(200) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('calcultron','Approved','77C9749B451AB8C713C48037DDFBB2C4','Dwight','Schrute'),('calcultron2','Approved','8792B8CF71D27DC96173B2AC79B96E0D','Jim','Halpert'),('calcwizard','Approved','0D777E9E30B918E9034AB610712C90CF','Issac','Newton'),('clarinetbeast','Declined','C8C605999F3D8352D7BB792CF3FDB25B','Squidward','Tentacles'),('cool_class4400','Approved','77C9749B451AB8C713C48037DDFBB2C4','A. TA','Washere'),('DNAhelix','Approved','CA94EFE2A58C27168EDF3D35102DBB6D','Rosalind','Franklin'),('does2Much','Approved','00CEDCF91BEFFA9EE69F6CFE23A4602D','Carl','Gauss'),('eeqmcsquare','Approved','7C5858F7FCF63EC268F42565BE3ABB95','Albert','Einstein'),('entropyRox','Approved','C8C605999F3D8352D7BB792CF3FDB25B','Claude','Shannon'),('fatherAI','Approved','0D777E9E30B918E9034AB610712C90CF','Alan','Turing'),('fullMetal','Approved','D009D70AE4164E8989725E828DB8C7C2','Edward','Elric'),('gdanger','Declined','3665A76E271ADA5A75368B99F774E404','Gary','Danger'),('georgep','Approved','BBB8AAE57C104CDA40C93843AD5E6DB8','George P.','Burdell'),('ghcghc','Approved','9F0863DD5F0256B0F586A7B523F8CFE8','Grace','Hopper'),('ilikemoney$$','Approved','7C5858F7FCF63EC268F42565BE3ABB95','Eugene','Krabs'),('imbatman','Approved','9F0863DD5F0256B0F586A7B523F8CFE8','Bruce','Wayne'),('imready','Approved','CA94EFE2A58C27168EDF3D35102DBB6D','Spongebob','Squarepants'),('isthisthekrustykrab','Approved','134FB0BF3BDD54EE9098F4CBC4351B9A','Patrick','Star'),('manager1','Approved','E58CCE4FAB03D2AEA056398750DEE16B','Manager','One'),('manager2','Approved','BA9485F02FC98CDBD2EDADB0AA8F6390','Manager','Two'),('manager3','Approved','6E4FB18B49AA3219BEF65195DAC7BE8C','Three','Three'),('manager4','Approved','D61DFEE83AA2A6F9E32F268D60E789F5','Four','Four'),('notFullMetal','Approved','D009D70AE4164E8989725E828DB8C7C2','Alphonse','Elric'),('programerAAL','Approved','BA9485F02FC98CDBD2EDADB0AA8F6390','Ada','Lovelace'),('radioactivePoRa','Approved','E5D4B739DB1226088177E6F8B70C3A6F','Marie','Curie'),('RitzLover28','Approved','8792B8CF71D27DC96173B2AC79B96E0D','Abby','Normal'),('smith_j','Pending','77C9749B451AB8C713C48037DDFBB2C4','John','Smith'),('texasStarKarate','Declined','7C5858F7FCF63EC268F42565BE3ABB95','Sandy','Cheeks'),('thePiGuy3.14','Approved','E11170B8CBD2D74102651CB967FA28E5','Archimedes','Syracuse'),('theScienceGuy','Approved','C8C605999F3D8352D7BB792CF3FDB25B','Bill','Nye');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `visitedby` varchar(45) NOT NULL,
  `visitto_compname` varchar(45) NOT NULL,
  `visitto_thename` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `visit_user(fk9)_idx` (`visitedby`),
  KEY `visito_theater(fk10)_idx` (`visitto_compname`,`visitto_thename`),
  CONSTRAINT `visit_user(fk9)` FOREIGN KEY (`visitedby`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `visito_theater(fk10)` FOREIGN KEY (`visitto_compname`, `visitto_thename`) REFERENCES `theater` (`compname`, `theaname`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
INSERT INTO `visit` VALUES (1,'2010-03-22','georgep','EZ Theater Company','Main Movies'),(2,'2010-03-22','calcwizard','EZ Theater Company','Main Movies'),(3,'2010-03-25','calcwizard','EZ Theater Company','Star Movies'),(4,'2010-03-25','imready','EZ Theater Company','Star Movies'),(5,'2010-03-20','calcwizard','AI Theater Company','ML Movies');
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'team26'
--

--
-- Dumping routines for database 'team26'
--
/*!50003 DROP PROCEDURE IF EXISTS `admin_approve_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_approve_user`(IN i_username VARCHAR(45))
BEGIN
    UPDATE user
    SET user.status = 'Approved'
    WHERE user.username = i_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_create_mov` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_create_mov`(IN i_movName VARCHAR(45), 
IN i_movDuration INT(11),
IN i_movReleaseDate DATE)
BEGIN
	INSERT INTO movie (moviename,duration,releaseDate)
	VALUES (i_movName,i_movDuration,i_movReleaseDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_create_theater` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_create_theater`(IN i_thName VARCHAR(45), 
IN i_comName VARCHAR(45), IN i_thStreet VARCHAR(45),
IN i_thCity VARCHAR(45), IN i_thState CHAR(2),
IN i_thZipcode CHAR(5), IN i_capacity INT(11),
IN i_managerUsername VARCHAR(45))
BEGIN
		IF i_comName = (select work_in from manager where manager.username = i_managerUsername)
		THEN
		INSERT INTO theater (theaname,compname,street,city,state,
		zipcode,capacity,manageby)
		VALUES (i_thName, i_comName,i_thStreet,i_thCity,i_thState,
		i_thZipcode,i_capacity,i_managerUsername);
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_decline_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_decline_user`(IN i_username VARCHAR(45))
BEGIN
 
    UPDATE user
    SET user.status = 'Declined'
    WHERE user.username = i_username AND
    user.status != 'Approved';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_filter_company` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_filter_company`(IN i_comName VARCHAR(50), IN i_minCity INT(10), 
IN i_maxCity INT(10), IN i_minTheater INT(10), IN i_maxTheater INT(10), 
IN i_minEmployee INT(10), IN i_maxEmployee INT(10), IN i_sortBy VARCHAR(20), 
IN i_sortDirection VARCHAR(10))
BEGIN
    DROP TABLE IF EXISTS AdFilterCom;
    
    IF i_comName = '' THEN SET i_comName = 'ALL'; END IF;
    IF i_minCity IS NULL THEN SET i_minCity = 0; END IF;
    IF i_maxCity IS NULL THEN SET i_maxCity = 100000; END IF;
    IF i_minTheater IS NULL THEN SET i_minTheater = 0; END IF;
    IF i_maxTheater IS NULL THEN SET i_maxTheater = 100000; END IF;
    IF i_minEmployee IS NULL THEN SET i_minEmployee = 0; END IF;
    IF i_maxEmployee IS NULL THEN SET i_maxEmployee = 100000; END IF;

    IF i_sortBy = '' THEN SET i_sortBy = 'comName'; END IF;
    IF i_sortDirection = '' THEN SET i_sortDirection = 'DESC'; END IF;
    CREATE TABLE AdFilterCom
    SELECT comName, numCityCover, numTheater, numEmployee
 FROM (
 SELECT theater.compname as comName, count(DISTINCT theater.city) AS numCityCover, 
 count(DISTINCT theater.theaname) as numTheater, count(DISTINCT username) as numEmployee
 FROM theater
 LEFT JOIN manager
 ON theater.compname = manager.work_in
 GROUP BY theater.compname ) AS TABLE1
 WHERE (numCityCover >= i_minCity) AND
  (numCityCover <= i_maxCity) AND
   (numTheater >= i_minTheater) AND
    (numTheater <= i_maxTheater) AND
     (numEmployee >= i_minEmployee) AND
      (numEmployee <= i_maxEmployee) AND 
         (comName = i_comName OR i_comName = "ALL");
    
 SET @a = CONCAT('
    ALTER TABLE AdFilterCom
 ORDER BY ', i_sortBy,' ', i_sortDirection);
    
    PREPARE stmt1 FROM @a;
 EXECUTE stmt1;
 DEALLOCATE PREPARE stmt1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_filter_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_filter_user`(in i_username varchar(50), in i_status char(10), 
i_sortBy char(20), in i_sortDirection char(10))
BEGIN
SET SQL_SAFE_UPDATES = 0;

 drop table if exists AdFilterUser;
    if i_sortBy = '' then set i_sortBy = "username"; end if;
    if i_sortDirection = '' then set i_sortDirection = "DESC"; end if;
    
    create table AdFilterUser
    select username, creditCardCount, status
    from (
    select user.username, count(credicardnum) as creditCardCount, status 
    from user
    left join creditcard 
    on user.username = creditcard.ownedby group by user.username) as table1
    where (username = i_username or i_username = '') and (status = i_status or i_status = "ALL");
    alter table AdFilterUser add userType varchar(20);

    update AdFilterUser set userType = "User" 
    where username in (select username from user);
    update AdFilterUser set userType = "Customer" 
    where username in (select username from customer);
    update AdFilterUser set userType = "Admin"
    where username in (select username from admin);
    update AdFilterUser set userType = "Manager" 
    where username in (select username from manager);
    update AdFilterUser set userType = "CustomerManager" 
    where username in (select username from manager where username in (select username from customer));
    update AdFilterUser set userType = "CustomerAdmin"
    where username in (select username from admin where username in (select username from customer));
  
   SET @b = CONCAT('
    ALTER TABLE AdFilterUser
 ORDER BY ', i_sortBy,' ', i_sortDirection);
    
    PREPARE stmt2 FROM @b;
 EXECUTE stmt2;
 DEALLOCATE PREPARE stmt2;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_view_comDetail_emp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_view_comDetail_emp`(IN i_comName VARCHAR(45))
BEGIN
	DROP TABLE IF EXISTS AdComDetailEmp;
    CREATE TABLE AdComDetailEmp
    SELECT user.firstname as empFirstname,user.lastname as empLastname
    FROM manager,user,company
    WHERE manager.work_in=company.compname 
    AND manager.username=user.username
    AND company.compname=i_comName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `admin_view_comDetail_th` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_view_comDetail_th`(IN i_comName VARCHAR(45))
BEGIN
	DROP TABLE IF EXISTS AdComDetailTh;
    CREATE TABLE AdComDetailTh
    SELECT theater.theaname AS thName, theater.manageby AS thManagerUsername,
    theater.city AS thCity, theater.state AS thState, theater.capacity AS thCapacity
    FROM theater
    WHERE theater.compname=i_comName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customer_add_creditcard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_add_creditcard`(IN i_username VARCHAR(45), IN i_creditCardNum CHAR(16))
BEGIN
 IF char_length(i_creditCardNum) >= 15 AND ((select count(*) from creditcard as t1 where t1.ownedby=i_username)<5) 
 THEN
  INSERT INTO creditcard (credicardnum,ownedby) VALUES (i_creditCardNum,i_username);
 END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customer_filter_mov` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_filter_mov`(IN i_movName VARCHAR(45), IN i_comName VARCHAR(45),
IN i_city VARCHAR(45), IN i_state CHAR(3), 
IN i_minMovPlayDate Date, IN i_maxMovPlayDate Date)
BEGIN
	DROP TABLE IF EXISTS CosFilterMovie;
    
    CREATE TABLE CosFilterMovie
    SELECT movieplay.moviename as MovName, movieplay.theatername AS thName,
    theater.street AS thStreet, theater.city AS thCity,
    theater.state AS thState, theater.zipcode AS thZipcode,
    theater.compname AS comName,
    movieplay.date AS movPlayDate, movieplay.releasedate AS movReleaseDate
    FROM movieplay,theater
    WHERE movieplay.theatername=theater.theaname AND movieplay.compname=theater.compname
    AND
    (movieplay.date >= i_minMovPlayDate OR i_minMovPlayDate IS NULL)AND 
    (movieplay.date <= i_maxMovPlayDate OR i_maxMovPlayDate IS NULL)
    AND (i_state = theater.state OR i_state = '' OR i_state = 'ALL')
    AND (i_city = theater.city OR i_city = 'ALL' OR i_city = '')
    AND (i_movName = movieplay.moviename OR i_movName = 'ALL'OR i_movName = '')
    AND (i_comName=theater.compname OR i_comName = 'ALL' OR i_comName = '');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customer_only_register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_only_register`(IN i_username VARCHAR(45), IN i_password VARCHAR(200), IN i_firstname VARCHAR(45), IN i_lastname VARCHAR(45))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
        INSERT INTO customer(username) VALUES (i_username);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customer_view_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_view_history`(IN i_cusUsername VARCHAR(45))
BEGIN
    DROP TABLE IF EXISTS CosViewHistory;
    CREATE TABLE CosViewHistory
    SELECT moviename as movName, theaname as thName, compname as comName, creditcardnum as creditCardNum, date as movPlayDate
    FROM creditcard, orderhistory
    WHERE  i_cusUsername = creditcard.ownedby AND creditcard.credicardnum = orderhistory.creditcardnum;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customer_view_mov` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_view_mov`(IN i_creditCardNum CHAR(16),
IN i_movName VARCHAR(45), IN i_movReleaseDate Date,
IN i_thName VARCHAR(45), IN i_comName VARCHAR(45),
IN i_movPlayDate Date)
BEGIN
  IF char_length(i_creditCardNum) >= 15 
 and
    (select count(*)
 from (orderhistory join creditcard on orderhistory.creditcardnum = creditcard.credicardnum)
 where date=i_movPlayDate and ownedby=(select c1.ownedby from creditcard c1 where c1.credicardnum = i_creditCardNum))<=2
  THEN
 INSERT INTO orderhistory (creditcardnum,moviename,releasedate,theaname,compname,date)
 VALUES (i_creditCardNum, i_movName,i_movReleaseDate,i_thName,i_comName,i_movPlayDate);
 END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_customer_add_creditcard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_customer_add_creditcard`(IN i_username VARCHAR(45), IN i_creditCardNum CHAR(16))
BEGIN
	IF char_length(i_creditCardNum) >= 15 
    THEN
		INSERT INTO creditcard (credicardnum,ownedby) VALUES (i_creditCardNum,i_username);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_customer_register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_customer_register`(IN i_username VARCHAR(45), IN i_password VARCHAR(200), IN i_firstname VARCHAR(45), IN i_lastname VARCHAR(45)
,i_comName VARCHAR(45),i_empStreet VARCHAR(100),i_empCity VARCHAR(45), i_empState CHAR(2),i_empZipcode CHAR(5))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
        INSERT INTO employee(username) VALUES (i_username);
        INSERT INTO customer(username) VALUES (i_username);
        INSERT INTO manager(username,work_in,street,city,state,zipcode) VALUES (i_username,i_comName,i_empStreet,i_empCity,i_empState,i_empZipcode);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_filter_th` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_filter_th`(IN i_manUsername VARCHAR(45),IN i_movName VARCHAR(45), 
IN i_minMovDuration INT(11), IN i_maxMovDuration INT(11),
IN i_minReleaseDate Date, IN i_maxReleaseDate Date,
IN i_minMovPlayDate Date, IN i_maxMovPlayDate Date,
IN i_includedNotPlay boolean)
BEGIN
	DROP TABLE IF EXISTS TEMP;
	CREATE TABLE TEMP AS (SELECT * FROM movie,theater);
    DROP TABLE IF EXISTS ManFilterTh;
    CREATE TABLE ManFilterTh
	SELECT TEMP.moviename AS movName, duration AS movDuration, TEMP.releasedate AS movReleaseDate, date AS movPlayDate
	FROM TEMP
	LEFT JOIN movieplay 
		ON movieplay.theatername = temp.theaname and movieplay.compname = temp.compname and movieplay.moviename = temp.moviename
	WHERE
		((i_includedNotPlay IS NULL OR i_includedNotPlay = 0) AND
        (i_manUsername = '' OR i_manUsername = manageby) AND
        (i_movName = '' OR TEMP.moviename LIKE CONCAT("%",i_movName,"%")) AND
		(i_minMovDuration IS NULL OR duration >= i_minMovDuration) AND
		(i_maxMovDuration IS NULL OR duration <= i_maxMovDuration) AND
        (i_minReleaseDate IS NULL OR TEMP.releasedate >= i_minReleaseDate) AND
        (i_maxReleaseDate IS NULL OR TEMP.releasedate <= i_maxReleaseDate) AND
        (i_minMovPlayDate IS NULL OR date >= i_minMovPlayDate OR date IS NULL) AND
        (i_maxMovPlayDate IS NULL OR date <= i_maxMovPlayDate OR date IS NULL) ) OR
        ((i_includedNotPlay = 1) AND
        (i_manUsername = '' OR i_manUsername = manageby) AND
        (i_movName = '' OR TEMP.moviename LIKE CONCAT("%",i_movName,"%")) AND
		(i_minMovDuration IS NULL OR duration >= i_minMovDuration) AND
		(i_maxMovDuration IS NULL OR duration <= i_maxMovDuration) AND
        (i_minReleaseDate IS NULL OR TEMP.releasedate >= i_minReleaseDate) AND
        (i_maxReleaseDate IS NULL OR TEMP.releasedate <= i_maxReleaseDate) AND
        (date IS NULL));
	DROP TABLE TEMP;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_only_register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_only_register`(IN i_username VARCHAR(45), IN i_password VARCHAR(200), IN i_firstname VARCHAR(45), IN i_lastname VARCHAR(45)
,i_comName VARCHAR(45),i_empStreet VARCHAR(100),i_empCity VARCHAR(45), i_empState CHAR(2),i_empZipcode CHAR(5))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
        INSERT INTO employee(username) VALUES (i_username);
        INSERT INTO manager(username,work_in,street,city,state,zipcode) VALUES (i_username,i_comName,i_empStreet,i_empCity,i_empState,i_empZipcode);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `manager_schedule_mov` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_schedule_mov`(IN i_manUsername VARCHAR(45), 
IN i_movName VARCHAR(45), IN i_movReleaseDate DATE, in i_movPlayDate DATE)
BEGIN
	IF i_movReleaseDate <= i_movPlayDate
    THEN
		INSERT INTO movieplay (moviename, releasedate, date, compname, theatername)
		VALUES (i_movName, i_movReleaseDate, i_movPlayDate, 
		(SELECT theater.compname
		FROM theater
		WHERE theater.manageby = i_manUsername),
		(SELECT theater.theaname
		FROM theater
		WHERE theater.manageby = i_manUsername));
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_filter_th` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_filter_th`(IN i_thName VARCHAR(45), IN i_comName VARCHAR(45), IN i_city VARCHAR(45), IN i_state VARCHAR(3))
BEGIN
    DROP TABLE IF EXISTS UserFilterTh;
    IF i_thName = '' THEN SET i_thName = 'ALL'; END IF;
    IF i_comName = '' THEN SET i_comName = 'ALL'; END IF;
    IF i_city = '' THEN SET i_city = 'ALL'; END IF;
    IF i_state = '' THEN SET i_state = 'ALL'; END IF;
    
    CREATE TABLE UserFilterTh
	SELECT theaname as thName, street as thStreet, city as thCity, state as thState, zipcode as thZipcode, compname as comName
    FROM Theater
    WHERE 
		(theaname = i_thName OR i_thName = "ALL") AND
        (compname = i_comName OR i_comName = "ALL") AND
        (city = i_city OR i_city = "ALL") AND
        (state = i_state OR i_state = "ALL");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_filter_visitHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_filter_visitHistory`(IN i_username VARCHAR(50), IN i_minVisitDate DATE, IN i_maxVisitDate DATE)
BEGIN
    DROP TABLE IF EXISTS UserVisitHistory;
    CREATE TABLE UserVisitHistory
	SELECT theaname as thName, street as thStreet, city as thCity, state as thState, zipcode as thZipcode, compname as comName, date as visitDate
    FROM visit
		JOIN
        theater
        on (visit.visitto_thename = theater.theaname AND visit.visitto_compname = theater.compname)
	WHERE
		(visitedby = i_username) AND
        (i_minVisitDate IS NULL OR date >= i_minVisitDate) AND
        (i_maxVisitDate IS NULL OR date <= i_maxVisitDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_login`(IN i_username VARCHAR(45), IN i_password VARCHAR(200))
BEGIN
    DROP TABLE IF EXISTS UserLogin;
    CREATE TABLE UserLogin
    SELECT username as username, status as status,
    (
    case
    when username in (select username from customer) then '1' else '0'
    end
    ) as iscustomer,
    (
    case
    when username in (select username from admin) then '1' else '0'
    end
    ) as isadmin,
    (
 case
    when username in (select username from manager) then '1' else '0'
    end
    ) as ismanager
    FROM user
 WHERE user.username = i_username AND password = i_password;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_visit_th` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_visit_th`(IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_visitDate DATE, IN i_username VARCHAR(50))
BEGIN
    INSERT INTO visit(id,visitto_thename,visitto_compname,date, visitedby)
    VALUES ((select max(id)+1 from visit as a1),i_thName, i_comName, i_visitDate, i_username);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-29 22:35:41
