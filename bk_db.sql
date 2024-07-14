-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bookmaker
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTEcouponR_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cashout_check`
--

DROP TABLE IF EXISTS `cashout_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashout_check` (
  `IDcocheck` int NOT NULL,
  `IDuser` int DEFAULT NULL,
  `CoDate` date DEFAULT NULL,
  `CoAmount` int DEFAULT NULL,
  PRIMARY KEY (`IDcocheck`),
  KEY `f2` (`IDuser`),
  CONSTRAINT `f2` FOREIGN KEY (`IDuser`) REFERENCES `users` (`IDuser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashout_check`
--

LOCK TABLES `cashout_check` WRITE;
/*!40000 ALTER TABLE `cashout_check` DISABLE KEYS */;
INSERT INTO `cashout_check` VALUES (1,1,'2022-04-16',700),(2,2,'2022-04-18',100),(3,3,'2022-04-20',150),(4,2,'2022-04-21',500),(5,4,'2022-04-24',2140),(6,1,'2022-04-28',600),(7,1,'2022-04-29',100),(8,6,'2022-05-02',1400),(9,6,'2022-04-22',200),(10,1,'2022-04-27',500),(11,1,'2022-04-28',300),(12,8,'2022-05-03',1000),(13,12,'2022-05-10',5000),(14,14,'2022-05-29',1000);
/*!40000 ALTER TABLE `cashout_check` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cashout_check_BEFORE_INSERT` BEFORE INSERT ON `cashout_check` FOR EACH ROW BEGIN
declare OgrCO condition for sqlstate '45000';
if new.CoAmount > (select Balance from users where IDuser=new.IDuser) or (new.CoAmount<10)  then
signal OgrCO set message_text='Нельзя вывести такую сумму!';
end if;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cashout_check_AFTER_INSERT` AFTER INSERT ON `cashout_check` FOR EACH ROW BEGIN
update users set Balance = (select userbalance from showusersbalance where IDuser=new.IDuser)
where IDuser=new.IDuser; 
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cashout_check_AFTER_UPDATE` AFTER UPDATE ON `cashout_check` FOR EACH ROW BEGIN
update users set Balance = (select userbalance from showusersbalance where IDuser=new.IDuser)
where IDuser=new.IDuser; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `IDcoupon` int NOT NULL,
  `IDuser` int DEFAULT NULL,
  `BetDate` date DEFAULT NULL,
  `BetAmount` int DEFAULT NULL,
  `BetRate` float DEFAULT NULL,
  `BetStatus` char(10) DEFAULT NULL,
  PRIMARY KEY (`IDcoupon`),
  KEY `f5` (`IDuser`),
  CONSTRAINT `f5` FOREIGN KEY (`IDuser`) REFERENCES `users` (`IDuser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (1,2,'2022-04-18',600,7.3,'Проигран'),(2,1,'2022-04-15',600,1.34,'Выигран'),(3,3,'2022-04-17',300,4.22,'Проигран'),(4,6,'2022-04-20',400,2.71,'Проигран'),(5,1,'2022-04-22',100,2.01,'Выигран'),(6,7,'2022-04-18',1000,1.75,'Проигран'),(7,8,'2022-04-17',750,5.33,'Выигран'),(8,2,'2022-04-19',150,4.94,'Проигран'),(9,6,'2022-04-20',100,29.63,'Проигран'),(10,2,'2022-04-26',300,4.05,'Проигран'),(11,1,'2022-04-26',800,1.73,'Выигран'),(12,3,'2022-04-29',100,NULL,NULL),(13,1,'2022-04-28',600,4.15,'Проигран'),(14,1,'2022-04-30',200,7.87,'Выигран'),(15,6,'2022-04-30',700,2.63,'Проигран'),(16,12,'2022-05-09',1000,1.97,'Проигран'),(17,12,'2022-05-07',500,11.15,'Выигран'),(18,NULL,'2022-05-17',300,NULL,NULL),(19,14,'2022-05-17',400,1.9,'Проигран'),(20,14,'2022-05-19',200,5.33,'Выигран'),(21,6,'2022-05-21',600,6.95,'Проигран'),(22,6,'2022-05-22',200,2.44,'Выигран');
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `coupon_BEFORE_INSERT` BEFORE INSERT ON `coupon` FOR EACH ROW BEGIN
declare OgrAmount condition for sqlstate '45000';
if (new.BetAmount > (select Balance from users where IDuser=new.Iduser) or new.BetAmount<10)  then
signal OgrAmount set message_text='Нельзя ставить такую сумму!';
end if;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `coupon_AFTER_INSERT` AFTER INSERT ON `coupon` FOR EACH ROW BEGIN
update users set Statistics = (select stat from show_statistics where IDuser=new.IDuser) 
where IDuser=new.IDuser;
update users set Balance = (select userbalance from showusersbalance where IDuser=new.IDuser)
where IDuser=new.IDuser; 
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `coupon_AFTER_UPDATE` AFTER UPDATE ON `coupon` FOR EACH ROW BEGIN
update users set Statistics = (select stat from show_statistics where IDuser=new.IDuser) 
where IDuser=new.IDuser;
update users set Balance = (select userbalance from showusersbalance where IDuser=new.IDuser)
where IDuser=new.IDuser; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `max_loss`
--

DROP TABLE IF EXISTS `max_loss`;
/*!50001 DROP VIEW IF EXISTS `max_loss`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `max_loss` AS SELECT 
 1 AS `UserName`,
 1 AS `MaxLoss`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `max_wins`
--

DROP TABLE IF EXISTS `max_wins`;
/*!50001 DROP VIEW IF EXISTS `max_wins`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `max_wins` AS SELECT 
 1 AS `UserName`,
 1 AS `BetAmount`,
 1 AS `BetRate`,
 1 AS `MaxWin`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `outcome`
--

DROP TABLE IF EXISTS `outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outcome` (
  `IDevent` int NOT NULL,
  `NumOut` int NOT NULL,
  `OutName` char(40) DEFAULT NULL,
  `OutStatus` char(10) DEFAULT NULL,
  PRIMARY KEY (`IDevent`,`NumOut`),
  CONSTRAINT `f3` FOREIGN KEY (`IDevent`) REFERENCES `sportevent` (`IDevent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outcome`
--

LOCK TABLES `outcome` WRITE;
/*!40000 ALTER TABLE `outcome` DISABLE KEYS */;
INSERT INTO `outcome` VALUES (1,1,'Победа Ливерпуля','Выигран'),(1,2,'Победа Вильяреала','Проигран'),(2,1,'Победа России','Выигран'),(2,2,'Победа Норвегии','Проигран'),(2,3,'Победа Германии','Проигран'),(3,1,'Победа Трактора','Выигран'),(3,2,'Победа Металлурга','Проигран'),(4,1,'Победа России','Выигран'),(4,2,'Победа Японии','Проигран'),(5,1,'Победа Манчестера','Выигран'),(5,2,'Победа Реала','Проигран'),(5,3,'Голов больше, чем 2.5','Проигран'),(6,1,'Победа Хэмильтон','Выигран'),(6,2,'Победа Шумахер','Проигран'),(6,3,'Произойдёт авария','Выигран'),(7,1,'Победа России','Выигран'),(7,2,'Победа Канады','Проигран'),(8,1,'Победа Барселоны','Выигран'),(8,2,'Победа Атлетико','Проигран'),(9,1,'Победа России','Проигран'),(9,2,'Победа Испании','Выигран'),(10,1,'Победа ЦСКА','Выигран'),(10,2,'Победа Химок','Проигран'),(11,1,'Победа США','Выигран'),(11,2,'Поеда Канады','Проигран'),(12,1,'Победа Питтсбурга','Проигран'),(12,2,'Победа Тампа Бей','Выигран'),(13,1,'Победа Большунова','Проигран'),(13,2,'Победа Сундбю','Проигран'),(13,3,'Победа Устюгова','Выигран'),(13,4,'Победа Пеллегрини','Проигран'),(14,1,'Победа Джоковича','Выигран'),(14,2,'Победа Надаля','Проигран'),(15,1,'Победа России','Проигран'),(15,2,'Победа Швеции','Выигран'),(16,1,'Победа Реала','Проигран'),(16,2,'Победа Ливерпуля','Выигран'),(17,1,'Победа Нигерии','Проигран'),(17,2,'Победа США','Выигран'),(17,3,'Победа ЮАР','Проигран');
/*!40000 ALTER TABLE `outcome` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `outcome_AFTER_INSERT` AFTER INSERT ON `outcome` FOR EACH ROW BEGIN

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `outcome_AFTER_UPDATE` AFTER UPDATE ON `outcome` FOR EACH ROW BEGIN
update outfromcoup set OutCoupStatus = (select new.OutStatus 
where IDevent=new.IDevent and NumOut=new.NumOut) where IDevent=new.IDevent and NumOut=new.NumOut;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `outfromcoup`
--

DROP TABLE IF EXISTS `outfromcoup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outfromcoup` (
  `IDcoupon` int NOT NULL,
  `IDevent` int NOT NULL,
  `NumOut` int NOT NULL,
  `CoupRate` float DEFAULT NULL,
  `OutCoupStatus` char(10) DEFAULT NULL,
  PRIMARY KEY (`IDcoupon`,`IDevent`,`NumOut`),
  KEY `f7` (`IDevent`,`NumOut`),
  CONSTRAINT `f6` FOREIGN KEY (`IDcoupon`) REFERENCES `coupon` (`IDcoupon`),
  CONSTRAINT `f7` FOREIGN KEY (`IDevent`, `NumOut`) REFERENCES `outcome` (`IDevent`, `NumOut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outfromcoup`
--

LOCK TABLES `outfromcoup` WRITE;
/*!40000 ALTER TABLE `outfromcoup` DISABLE KEYS */;
INSERT INTO `outfromcoup` VALUES (1,1,1,1.34,'Выигран'),(1,2,1,2.01,'Выигран'),(1,2,2,2.71,'Проигран'),(2,1,1,1.34,'Выигран'),(3,2,3,4.22,'Проигран'),(4,2,2,2.71,'Проигран'),(5,2,1,2.01,'Выигран'),(6,5,2,1.75,'Проигран'),(7,4,1,2.4,'Выигран'),(7,5,1,2.22,'Выигран'),(8,6,1,2.33,'Выигран'),(8,6,2,2.12,'Проигран'),(9,5,3,1.54,'Проигран'),(9,6,1,2.33,'Выигран'),(9,6,2,2.12,'Проигран'),(9,6,3,1.59,'Выигран'),(9,7,2,2.45,'Проигран'),(10,8,1,1.73,'Выигран'),(10,8,2,2.34,'Проигран'),(11,8,1,1.73,'Выигран'),(13,9,1,2.22,'Проигран'),(13,9,2,1.87,'Выигран'),(14,10,1,1.86,'Выигран'),(14,11,1,4.23,'Выигран'),(15,10,2,2.14,'Проигран'),(15,11,2,1.23,'Проигран'),(16,12,1,1.97,'Проигран'),(17,13,3,2.45,'Выигран'),(17,14,1,4.55,'Выигран'),(19,15,1,1.9,'Проигран'),(20,15,2,1.93,'Выигран'),(20,16,2,2.76,'Выигран'),(21,17,1,2.31,'Проигран'),(21,17,3,3.01,'Проигран'),(22,17,2,2.44,'Выигран');
/*!40000 ALTER TABLE `outfromcoup` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `outfromcoup_AFTER_INSERT` AFTER INSERT ON `outfromcoup` FOR EACH ROW BEGIN

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `outfromcoup_AFTER_UPDATE` AFTER UPDATE ON `outfromcoup` FOR EACH ROW BEGIN
call bookmaker.rate_coup();
update coupon set BetStatus = (select win_or_loss(new.IDcoupon)) where IDcoupon=new.IDcoupon;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `rate_in_coup`
--

DROP TABLE IF EXISTS `rate_in_coup`;
/*!50001 DROP VIEW IF EXISTS `rate_in_coup`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rate_in_coup` AS SELECT 
 1 AS `IDcoupon`,
 1 AS `rateincoup`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ratereg`
--

DROP TABLE IF EXISTS `ratereg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratereg` (
  `IDevent` int NOT NULL,
  `NumOut` int NOT NULL,
  `ChangeDate` date NOT NULL,
  `rate` float DEFAULT NULL,
  PRIMARY KEY (`IDevent`,`NumOut`,`ChangeDate`),
  CONSTRAINT `f4` FOREIGN KEY (`IDevent`, `NumOut`) REFERENCES `outcome` (`IDevent`, `NumOut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratereg`
--

LOCK TABLES `ratereg` WRITE;
/*!40000 ALTER TABLE `ratereg` DISABLE KEYS */;
INSERT INTO `ratereg` VALUES (1,1,'2022-04-13',1.34),(1,1,'2022-04-17',1.2),(1,1,'2022-04-19',1.4),(1,2,'2022-04-13',2.54),(1,2,'2022-04-17',3.5),(1,2,'2022-04-19',2.3),(2,1,'2022-04-14',2.01),(2,2,'2022-04-14',1.78),(2,2,'2022-04-16',2.71),(2,3,'2022-04-14',4.22),(4,1,'2022-04-12',2.12),(4,1,'2022-04-15',2.4),(4,1,'2022-04-20',2.7),(4,2,'2022-04-12',1.98),(4,2,'2022-04-15',1.55),(4,2,'2022-04-20',1.4),(5,1,'2022-04-13',2.22),(5,1,'2022-04-18',2.4),(5,2,'2022-04-13',2),(5,2,'2022-04-18',1.75),(5,3,'2022-04-18',1.54),(6,1,'2022-04-17',2.33),(6,1,'2022-04-22',2.5),(6,2,'2022-04-17',2.12),(6,2,'2022-04-22',1.98),(6,3,'2022-04-19',1.59),(7,1,'2022-04-17',1.8),(7,1,'2022-04-21',2),(7,2,'2022-04-17',2.45),(7,2,'2022-04-21',2.13),(8,1,'2022-04-23',1.73),(8,1,'2022-04-29',1.56),(8,2,'2022-04-23',2.34),(8,2,'2022-04-29',2.78),(9,1,'2022-04-25',2.22),(9,1,'2022-04-29',2.03),(9,2,'2022-04-25',1.87),(9,2,'2022-04-29',1.95),(10,1,'2022-04-25',1.78),(10,1,'2022-04-29',1.86),(10,2,'2022-04-25',2.25),(10,2,'2022-04-29',2.14),(11,1,'2022-04-28',3.12),(11,1,'2022-04-30',4.23),(11,2,'2022-04-28',1.45),(11,2,'2022-04-30',1.23),(12,1,'2022-04-30',1.86),(12,1,'2022-05-02',1.97),(12,1,'2022-05-10',2.14),(12,2,'2022-04-30',2.33),(12,2,'2022-05-02',2.04),(12,2,'2022-05-10',1.9),(13,1,'2022-05-04',2.12),(13,1,'2022-05-08',2.67),(13,2,'2022-05-04',2.22),(13,2,'2022-05-08',1.78),(13,3,'2022-05-04',2.45),(13,3,'2022-05-08',2.57),(13,4,'2022-05-04',2.5),(13,4,'2022-05-08',2.88),(14,1,'2022-05-05',4.55),(14,1,'2022-05-09',5.43),(14,2,'2022-05-05',1.34),(14,2,'2022-05-09',1.23),(15,1,'2022-05-12',1.76),(15,1,'2022-05-14',1.9),(15,1,'2022-05-18',2.12),(15,2,'2022-05-12',2.34),(15,2,'2022-05-14',2.19),(15,2,'2022-05-18',1.93),(16,1,'2022-05-10',1.55),(16,1,'2022-05-22',1.23),(16,2,'2022-05-10',2.76),(16,2,'2022-05-22',4.24),(17,1,'2022-05-20',2.31),(17,1,'2022-05-24',2.12),(17,2,'2022-05-20',2.44),(17,2,'2022-05-24',3.67),(17,3,'2022-05-20',3.01),(17,3,'2022-05-24',2.89);
/*!40000 ALTER TABLE `ratereg` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ratereg_BEFORE_INSERT` BEFORE INSERT ON `ratereg` FOR EACH ROW BEGIN
declare OgrKoef condition for sqlstate '45000';
if new.rate<=1 then
signal OgrKoef set message_text='Коеффициент должен быть больше 1!';
end if;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ratereg_AFTER_INSERT` AFTER INSERT ON `ratereg` FOR EACH ROW BEGIN
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `replenishment_check`
--

DROP TABLE IF EXISTS `replenishment_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replenishment_check` (
  `IDrepcheck` int NOT NULL,
  `IDuser` int DEFAULT NULL,
  `RepDate` date DEFAULT NULL,
  `RepAmount` int DEFAULT NULL,
  PRIMARY KEY (`IDrepcheck`),
  KEY `f1` (`IDuser`),
  CONSTRAINT `f1` FOREIGN KEY (`IDuser`) REFERENCES `users` (`IDuser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replenishment_check`
--

LOCK TABLES `replenishment_check` WRITE;
/*!40000 ALTER TABLE `replenishment_check` DISABLE KEYS */;
INSERT INTO `replenishment_check` VALUES (1,1,'2022-04-02',1000),(2,2,'2022-04-03',1500),(3,2,'2022-04-06',200),(4,3,'2022-04-07',400),(5,1,'2022-04-09',240),(6,4,'2022-04-11',2100),(7,1,'2022-04-12',1200),(8,4,'2022-04-15',140),(9,6,'2022-04-18',2100),(10,7,'2022-04-19',1000),(11,8,'2022-04-19',800),(12,6,'2022-04-19',200),(13,6,'2022-04-19',200),(14,6,'2022-04-20',500),(15,5,'2022-04-27',100),(16,3,'2022-04-28',400),(17,12,'2022-05-08',1800),(18,14,'2022-05-15',800),(19,6,'2022-05-19',1000);
/*!40000 ALTER TABLE `replenishment_check` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `replenishment_check_BEFORE_INSERT` BEFORE INSERT ON `replenishment_check` FOR EACH ROW BEGIN
declare OgrREP condition for sqlstate '45000';
if new.RepAmount < 10  then
signal OgrREP set message_text='Нельзя пополнять счёт меньше, чем на 10 рублей!';
end if;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `replenishment_check_AFTER_INSERT` AFTER INSERT ON `replenishment_check` FOR EACH ROW BEGIN
update users set Balance = (select userbalance from showusersbalance where IDuser=new.IDuser)
where IDuser=new.IDuser; 
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `replenishment_check_AFTER_UPDATE` AFTER UPDATE ON `replenishment_check` FOR EACH ROW BEGIN
update users set Balance = (select userbalance from showusersbalance where IDuser=new.IDuser)
where IDuser=new.IDuser; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `show_balance`
--

DROP TABLE IF EXISTS `show_balance`;
/*!50001 DROP VIEW IF EXISTS `show_balance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `show_balance` AS SELECT 
 1 AS `IDuser`,
 1 AS `RepItog`,
 1 AS `CoItog`,
 1 AS `itog`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `show_finresult`
--

DROP TABLE IF EXISTS `show_finresult`;
/*!50001 DROP VIEW IF EXISTS `show_finresult`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `show_finresult` AS SELECT 
 1 AS `IDevent`,
 1 AS `result`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `show_statistics`
--

DROP TABLE IF EXISTS `show_statistics`;
/*!50001 DROP VIEW IF EXISTS `show_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `show_statistics` AS SELECT 
 1 AS `IDuser`,
 1 AS `allbets`,
 1 AS `round(allwonbets, 2)`,
 1 AS `stat`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `showusersbalance`
--

DROP TABLE IF EXISTS `showusersbalance`;
/*!50001 DROP VIEW IF EXISTS `showusersbalance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `showusersbalance` AS SELECT 
 1 AS `IDuser`,
 1 AS `itog`,
 1 AS `stata`,
 1 AS `userbalance`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sportevent`
--

DROP TABLE IF EXISTS `sportevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sportevent` (
  `IDevent` int NOT NULL,
  `EvName` char(40) DEFAULT NULL,
  `EvDate` date DEFAULT NULL,
  `FinResult` float DEFAULT NULL,
  PRIMARY KEY (`IDevent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sportevent`
--

LOCK TABLES `sportevent` WRITE;
/*!40000 ALTER TABLE `sportevent` DISABLE KEYS */;
INSERT INTO `sportevent` VALUES (1,'Ливерпуль : Вильяреал','2022-04-29',-604),(2,'Биатлон, Гонка преследования','2022-04-28',899),(3,'Хоккей, Трактор - Металлург','2022-04-21',NULL),(4,'Волейбол, Россия - Япония','2022-04-20',-1998.75),(5,'Футбол, Манчестер - Реал','2022-04-22',-978.75),(6,'Формула 1. Гран-При Монако','2022-01-05',210),(7,'Хоккей. Россия - Канада.','2022-04-05',20),(8,'Футбол, Барселона - Атлетико','2022-05-03',-1084),(9,'Теннис. Россия - Испания','2022-04-08',600),(10,'Баскетбол. ЦСКА - Химки','2022-05-01',-437),(11,'Керлинг. США - Канада','2022-05-02',-437),(12,'Хоккей. Кубок Стэнли. Питсбург:Тампа бей','2022-05-09',1000),(13,'Лыжные гонки. Кубок мира','2022-05-10',-2787.5),(14,'Теннис. Уимблдон. Джокович:Надаль','2022-05-11',-2787.5),(15,'Хоккей. Россия - Швеция','2022-05-28',-133),(16,'Футбол. Реал - Ливерпуль','2022-05-29',-533),(17,'Легкая атлетика. Бег','2022-05-30',112);
/*!40000 ALTER TABLE `sportevent` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sportevent_AFTER_INSERT` AFTER INSERT ON `sportevent` FOR EACH ROW BEGIN

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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sportevent_AFTER_UPDATE` AFTER UPDATE ON `sportevent` FOR EACH ROW BEGIN

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `IDuser` int NOT NULL,
  `UserName` char(30) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Statistics` int DEFAULT NULL,
  `Balance` int DEFAULT NULL,
  PRIMARY KEY (`IDuser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Ivan Labutkin','1988-12-13',1663,1903),(2,'Sergey Petrov','1992-10-09',-1050,50),(3,'Dmitriy Ivanov','1998-05-28',-400,250),(4,'Andrey Mikhailov','2001-02-01',NULL,100),(5,'Mikhail Andreev','1968-09-24',NULL,100),(6,'Anton Muhin','2002-10-18',-1512,888),(7,'Sergey Antonov','1970-02-11',-1000,0),(8,'Yuriy Voronin','1998-10-30',3248,3048),(9,'Maxim Vorobyev','1988-11-20',NULL,NULL),(10,'Maxim Vorobyev','1988-11-20',NULL,NULL),(11,'Sergey Sergeev','2004-04-03',NULL,NULL),(12,'Alexey Okunev','1982-09-12',4075,875),(13,'Boris Nikolaev','1987-09-02',NULL,NULL),(14,'Gennadiy Sergeev','1999-02-10',466,266);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_BEFORE_INSERT` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
declare CheckBd condition for sqlstate '45000';
if SUBDATE(current_date(), INTERVAL 18 Year)<new.BirthDate then
signal CheckBD set message_text='Возраст пользователя должен быть больше 18 лет!';
end if;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_AFTER_UPDATE` AFTER UPDATE ON `users` FOR EACH ROW BEGIN

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'bookmaker'
--

--
-- Dumping routines for database 'bookmaker'
--
/*!50003 DROP FUNCTION IF EXISTS `income_by_coupon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `income_by_coupon`(IDcoup int) RETURNS float
    READS SQL DATA
BEGIN
declare inc float;
declare count_ int;
set count_= (select count(IDevent) from outfromcoup where IDcoupon=IDcoup group by IDcoupon);
set inc = ROUND((select (BetAmount * (if(BetStatus is null, null, if(BetStatus = 'Проигран', 1, (-1)*BetRate)))) / count_ from coupon where IDcoupon=IDcoup), 2);
RETURN inc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `rate_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `rate_date`(sp_event int, outcom int, DateRate date) RETURNS float
    READS SQL DATA
BEGIN
declare DateMy date;
declare ratedate float;
set DateMy = (select ChangeDate from ratereg where sp_event = IDevent and outcom = NumOut and ChangeDate<=DateRate order by ChangeDate desc limit 1); 
set ratedate = (select rate from ratereg where ChangeDate = DateMy and sp_event = IDevent and outcom = NumOut);
RETURN ratedate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `win_or_loss` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `win_or_loss`(IDcoup int) RETURNS char(10) CHARSET utf8mb4
    READS SQL DATA
BEGIN
declare wol char(10);
if ((select count(IDcoupon) from outfromcoup where IDcoupon=IDcoup and OutCoupStatus is not null) < 
(select count(IDcoupon) from outfromcoup where IDcoupon=IDcoup)) then
set wol = null;
elseif (select count(IDcoupon) from outfromcoup where IDcoupon=IDcoup)=
(select count(IDcoupon) from outfromcoup where IDcoupon=IDcoup and OutCoupStatus='Выигран') then set wol = 'Выигран';
else set wol = 'Проигран';
end if;
RETURN wol;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_cashout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_cashout`(in par1 int, in par2 date, in par3 int)
BEGIN
declare ID int;
select max(IDcocheck) into ID from cashout_check;
insert into cashout_check values(ID + 1, par1, par2, par3);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_coupon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_coupon`(per1 char(30), per2 date, per3 int)
BEGIN
declare ID int;
select max(IDcoupon) into ID from coupon;
insert into coupon values(ID+1, (select IDuser from users where UserName = per1), per2, per3, null, null);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_event`(in par1 char(40), in par2 date)
BEGIN
declare ID int;
select max(IDevent) into ID from sportevent;
insert into sportevent values(ID + 1, par1, par2, null);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_outcome` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_outcome`(par1 int, par2 char(40))
BEGIN
declare ID int;
select max(NumOut) into ID from outcome where IDevent=par1;
insert into outcome values(par1, if(ID is null, 1, ID + 1), par2, null);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_outfromcoup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_outfromcoup`(per1 int, per2 int, per3 int)
BEGIN
declare DateBet date;
declare rate_ float;
declare rate2 float;
set rate2 = (select BetRate from coupon where IDcoupon=per1);
select BetDate into DateBet from coupon where IDcoupon=per1;
set rate_=rate_date(per2, per3, Datebet);
insert into outfromcoup values(per1, per2, per3, rate_, null);
update coupon set BetRate = if(rate2 is null, rate_, round(rate2*rate_, 2)) where IDcoupon=per1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_rate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_rate`(in par1 int, par2 int, par3 date, par4 float)
BEGIN
insert into ratereg values(par1, par2, par3, par4);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_replenishment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_replenishment`(in par1 int, in par2 date, in par3 int)
BEGIN
declare ID int;
select max(IDrepcheck) into ID from replenishment_check;
insert into replenishment_check values(ID + 1, par1, par2, par3);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user`(in par1 char(30), in par2 date)
BEGIN
declare ID int;
select max(IDuser) into ID from users;
insert into users values(ID + 1, par1, par2, null, null);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rate_coup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rate_coup`()
BEGIN
declare per1 int;
declare per2 float;
declare done int;
declare cur1 cursor for select IDcoupon, rateincoup from rate_in_coup;
declare exit handler for not found set done=1;
open cur1;
set done=0;
while done=0 do
fetch cur1 into per1, per2;
update coupon set BetRate = per2 where IDcoupon = per1;
end while;
close cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_rates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_rates`()
BEGIN
declare done int;
declare per1 int;
declare per2 int;
declare per3 float;
declare cur1 cursor for select IDevent, NumOut, rate_date(IDevent, NumOut, BetDate) from outfromcoup join coupon on coupon.IDcoupon=outfromcoup.IDcoupon;
declare exit handler for not found set done=1;
open cur1;
set done=0;
while done=0 do
fetch cur1 into per1, per2, per3;
update outfromcoup set CoupRate = per3 where per1=IDevent and per2=NumOut;
end while;
close cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpBetStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpBetStatus`()
BEGIN
declare done int;
declare per1 int;
declare per2 char(10);
declare cur1 cursor for select coupon.IDcoupon, if(OutCoupStatus is not null, win_or_loss(coupon.IDcoupon), null) from coupon join outfromcoup on coupon.IDcoupon=outfromcoup.IDcoupon;
declare exit handler for not found set done=1;
open cur1;
set done=0;
while done=0 do
fetch cur1 into per1, per2;
update coupon set BetStatus = per2 where IDcoupon=per1;
end while;
close cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpStat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpStat`()
BEGIN
declare done int;
declare per1 int;
declare per2 int;
declare cur1 cursor for select IDuser, stat from show_statistics;
declare exit handler for not found set done=1;
open cur1;
set done=0;
while done=0 do
fetch cur1 into per1, per2;
update users set Statistics= per2 where IDuser=per1;
end while;
close cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpStatus`()
BEGIN
declare done int;
declare per1 int;
declare per2 int;
declare per3 char(10);
declare cur1 cursor for select IDevent, NumOut, OutStatus from outcome; 
declare exit handler for not found set done=1;
open cur1;
set done=0;
while done=0 do
fetch cur1 into per1, per2, per3;
update outfromcoup set OutCoupStatus = per3 where IDevent=per1 and NumOut=per2;
end while;
close cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Up_Balance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Up_Balance`()
BEGIN
declare done int;
declare per1 int;
declare per2 int;
declare cur1 cursor for select IDuser, itog from show_balance;
declare exit handler for not found set done=1;
open cur1;
set done=0;
while done=0 do
fetch cur1 into per1, per2;
update users set Balance=per2 where IDuser=per1;
end while;
close cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `up_finresult` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `up_finresult`()
BEGIN
declare done int;
declare per1 int;
declare per2 float;
declare cur1 cursor for select IDevent, result from show_finresult; 
declare exit handler for not found set done=1;
open cur1;
set done=0;
while done=0 do
fetch cur1 into per1, per2;
update sportevent set FinResult = per2 where IDevent=per1;
end while;
close cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `max_loss`
--

/*!50001 DROP VIEW IF EXISTS `max_loss`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `max_loss` AS select `users`.`UserName` AS `UserName`,`coupon`.`BetAmount` AS `MaxLoss` from (`coupon` join `users` on((`coupon`.`IDuser` = `users`.`IDuser`))) where (`coupon`.`BetStatus` = 'Проигран') order by `coupon`.`BetAmount` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `max_wins`
--

/*!50001 DROP VIEW IF EXISTS `max_wins`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `max_wins` AS select `users`.`UserName` AS `UserName`,`coupon`.`BetAmount` AS `BetAmount`,`coupon`.`BetRate` AS `BetRate`,round((`coupon`.`BetAmount` * `coupon`.`BetRate`),2) AS `MaxWin` from (`coupon` join `users` on((`coupon`.`IDuser` = `users`.`IDuser`))) where (`coupon`.`BetStatus` = 'Выигран') order by `MaxWin` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rate_in_coup`
--

/*!50001 DROP VIEW IF EXISTS `rate_in_coup`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rate_in_coup` AS select `outfromcoup`.`IDcoupon` AS `IDcoupon`,round(exp(sum(log(`outfromcoup`.`CoupRate`))),2) AS `rateincoup` from `outfromcoup` group by `outfromcoup`.`IDcoupon` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_balance`
--

/*!50001 DROP VIEW IF EXISTS `show_balance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_balance` AS select `q1`.`IDuser` AS `IDuser`,`q1`.`RepItog` AS `RepItog`,`q2`.`CoItog` AS `CoItog`,(`q1`.`RepItog` - if((`q2`.`CoItog` is null),0,`q2`.`CoItog`)) AS `itog` from ((select `replenishment_check`.`IDuser` AS `IDuser`,sum(`replenishment_check`.`RepAmount`) AS `RepItog` from `replenishment_check` group by `replenishment_check`.`IDuser`) `q1` left join (select `cashout_check`.`IDuser` AS `IDuser`,sum(`cashout_check`.`CoAmount`) AS `CoItog` from `cashout_check` group by `cashout_check`.`IDuser`) `q2` on((`q1`.`IDuser` = `q2`.`IDuser`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_finresult`
--

/*!50001 DROP VIEW IF EXISTS `show_finresult`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_finresult` AS select `outfromcoup`.`IDevent` AS `IDevent`,sum(if((`income_by_coupon`(`outfromcoup`.`IDcoupon`) is null),0,`income_by_coupon`(`outfromcoup`.`IDcoupon`))) AS `result` from `outfromcoup` group by `outfromcoup`.`IDevent` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_statistics`
--

/*!50001 DROP VIEW IF EXISTS `show_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_statistics` AS select `q1`.`IDuser` AS `IDuser`,`q1`.`allbets` AS `allbets`,round(`q2`.`allwonbets`,2) AS `round(allwonbets, 2)`,round((if((`q2`.`allwonbets` is null),0,`q2`.`allwonbets`) - `q1`.`allbets`),2) AS `stat` from ((select `coupon`.`IDuser` AS `IDuser`,sum(`coupon`.`BetAmount`) AS `allbets` from `coupon` group by `coupon`.`IDuser`) `q1` left join (select `coupon`.`IDuser` AS `IDuser`,sum((`coupon`.`BetAmount` * `coupon`.`BetRate`)) AS `allwonbets` from `coupon` where (`coupon`.`BetStatus` = 'Выигран') group by `coupon`.`IDuser`) `q2` on((`q1`.`IDuser` = `q2`.`IDuser`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `showusersbalance`
--

/*!50001 DROP VIEW IF EXISTS `showusersbalance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `showusersbalance` AS select `q1`.`IDuser` AS `IDuser`,`q1`.`itog` AS `itog`,if((`q2`.`stat` is null),0,`q2`.`stat`) AS `stata`,(`q1`.`itog` + if((`q2`.`stat` is null),0,`q2`.`stat`)) AS `userbalance` from ((select `show_balance`.`IDuser` AS `IDuser`,`show_balance`.`itog` AS `itog` from `show_balance`) `q1` left join (select `show_statistics`.`IDuser` AS `IDuser`,`show_statistics`.`stat` AS `stat` from `show_statistics`) `q2` on((`q1`.`IDuser` = `q2`.`IDuser`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-26 20:19:57
