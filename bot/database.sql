-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: bot3
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `apply`
--

DROP TABLE IF EXISTS `apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apply` (
  `id_apply` int NOT NULL,
  `id_excur` int DEFAULT NULL,
  `date_app` date DEFAULT NULL,
  `time_app` time DEFAULT NULL,
  `amount_app` text,
  `infa` text,
  `comment` text,
  `id_guide` int DEFAULT NULL,
  `id_promik` int DEFAULT NULL,
  PRIMARY KEY (`id_apply`),
  KEY `f1_idx` (`id_excur`),
  KEY `f2_idx` (`id_guide`),
  KEY `f3_idx` (`id_promik`),
  CONSTRAINT `f1` FOREIGN KEY (`id_excur`) REFERENCES `excurtion` (`id_excur`) ON DELETE SET NULL,
  CONSTRAINT `f2` FOREIGN KEY (`id_guide`) REFERENCES `guide` (`id_guide`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `f3` FOREIGN KEY (`id_promik`) REFERENCES `promik` (`id_promik`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apply`
--

LOCK TABLES `apply` WRITE;
/*!40000 ALTER TABLE `apply` DISABLE KEYS */;
INSERT INTO `apply` VALUES (1,2,'2022-07-02','12:00:00',NULL,NULL,'Епт',NULL,4),(2,2,'2022-07-02','23:00:00','efg','eafv','ev',9,4),(3,9,'2022-07-02','13:30:00','бибка','jn','kj',7,4),(4,7,'2022-07-02','13:00:00',NULL,NULL,NULL,NULL,4),(5,2,'2022-07-04','10:30:00',NULL,NULL,NULL,NULL,4),(6,4,'2022-07-05','12:30:00',NULL,NULL,NULL,NULL,4),(7,3,'2022-07-06','19:30:00',NULL,NULL,NULL,NULL,4),(8,2,'2022-07-03','17:00:00','3','Полина тест 89217817008','Нет',8,4),(9,10,'2022-07-03','13:30:00','5','Тест 124456','Нет',8,4),(10,5,'2022-05-01','22:30:00','km','mk,m','lm ,m',NULL,5),(11,2,'2022-07-03','13:30:00','5','Полина 1346','Нет',2,4),(12,8,'2022-07-04','12:00:00',NULL,NULL,NULL,8,NULL),(13,1,'2022-07-04','17:00:00',NULL,NULL,NULL,8,NULL),(14,4,'2022-07-09','09:00:00','r3c','rc','cr',NULL,4),(15,5,'2022-07-22','21:00:00','3*2000','Миша 122222222','вваавава',NULL,1),(16,5,'2022-07-10','19:30:00','3*1000','kkk','dddd',6,1),(17,3,'2022-07-10','20:00:00','4*2000','Михаил +79219868765','Комментариев нет',8,1),(18,4,'2022-07-10','16:30:00','3×1500','Игорь +79213541654','Нет',NULL,1),(19,1,'2022-07-10','21:00:00','5×1200','Р','Р',NULL,1),(20,4,'2022-07-14','15:00:00','О','О','О',10,4),(21,4,'2022-07-14','18:00:00','Р','Р','Р',10,4);
/*!40000 ALTER TABLE `apply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocked`
--

DROP TABLE IF EXISTS `blocked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blocked` (
  `id_excur` int NOT NULL,
  `date_blocked` date NOT NULL,
  `time_start` time DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  PRIMARY KEY (`id_excur`,`date_blocked`),
  CONSTRAINT `f4` FOREIGN KEY (`id_excur`) REFERENCES `excurtion` (`id_excur`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocked`
--

LOCK TABLES `blocked` WRITE;
/*!40000 ALTER TABLE `blocked` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `denied_by_guides`
--

DROP TABLE IF EXISTS `denied_by_guides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denied_by_guides` (
  `id_guide` int NOT NULL,
  `id_excur` int NOT NULL,
  PRIMARY KEY (`id_guide`,`id_excur`),
  KEY `h1_idx` (`id_excur`),
  CONSTRAINT `h1` FOREIGN KEY (`id_excur`) REFERENCES `excurtion` (`id_excur`),
  CONSTRAINT `h2` FOREIGN KEY (`id_guide`) REFERENCES `guide` (`id_guide`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denied_by_guides`
--

LOCK TABLES `denied_by_guides` WRITE;
/*!40000 ALTER TABLE `denied_by_guides` DISABLE KEYS */;
INSERT INTO `denied_by_guides` VALUES (2,7),(8,7);
/*!40000 ALTER TABLE `denied_by_guides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `excurtion`
--

DROP TABLE IF EXISTS `excurtion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `excurtion` (
  `id_excur` int NOT NULL,
  `type_excur` text,
  `category_excur` text,
  `name_excur` char(40) DEFAULT NULL,
  `dur_excur` time DEFAULT NULL,
  `place` char(30) DEFAULT NULL,
  PRIMARY KEY (`id_excur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `excurtion`
--

LOCK TABLES `excurtion` WRITE;
/*!40000 ALTER TABLE `excurtion` DISABLE KEYS */;
INSERT INTO `excurtion` VALUES (1,'Крыши','Групповая','Башенка','01:00:00','Петроградка'),(2,'Крыши','Индивидуальная','Башенка','01:00:00','Петроградка'),(3,'Крыши','Индивидуальная','Мекс','01:00:00','Петроградка'),(4,'Крыши','Индивидуальная','Хогвартс','01:00:00','Хогвартс'),(5,'Крыши','Индивидуальная','Политка','01:00:00','Политка'),(6,'Крыши','Индивидуальная','Фонтанка','01:00:00','Центр'),(7,'Парадные','Индивидуальная','Контрасты без крыши','01:00:00','Петроградка'),(8,'Комбо','Индивидуальная','Сердце Петербурга','02:00:00','Центр'),(9,'Комбо','Индивидуальная','Контрасты с крышей','03:00:00','Петроградка'),(10,'Комбо','Индивидуальная','Секреты Петроградки','02:00:00','Петроградка'),(11,'Комбо','Индивидуальная','Секреты лайт','01:30:00','Петроградка');
/*!40000 ALTER TABLE `excurtion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guide`
--

DROP TABLE IF EXISTS `guide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guide` (
  `id_guide` int NOT NULL,
  `name_guide` char(30) DEFAULT NULL,
  PRIMARY KEY (`id_guide`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guide`
--

LOCK TABLES `guide` WRITE;
/*!40000 ALTER TABLE `guide` DISABLE KEYS */;
INSERT INTO `guide` VALUES (1,'Игорь'),(2,'Юрий'),(3,'Сергей'),(4,'Антон'),(5,'['),(6,'Михаил'),(7,'Рома'),(8,'Ваня'),(9,'Артём'),(10,'Нина');
/*!40000 ALTER TABLE `guide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promik`
--

DROP TABLE IF EXISTS `promik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promik` (
  `id_promik` int NOT NULL,
  `login_promik` char(30) DEFAULT NULL,
  `pass_promik` char(30) DEFAULT NULL,
  `category_promik` char(10) DEFAULT NULL,
  PRIMARY KEY (`id_promik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promik`
--

LOCK TABLES `promik` WRITE;
/*!40000 ALTER TABLE `promik` DISABLE KEYS */;
INSERT INTO `promik` VALUES (1,'serega228','qwerty','Промоутер'),(2,'den_02','1488','Промоутер'),(3,'Irishka03','102020','Промоутер'),(4,'1','1','Промоутер'),(5,'2','2','Промоутер');
/*!40000 ALTER TABLE `promik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spec_workhours`
--

DROP TABLE IF EXISTS `spec_workhours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spec_workhours` (
  `id_guide` int NOT NULL,
  `workdate` date NOT NULL,
  `place` char(30) NOT NULL,
  `hometime` time DEFAULT NULL,
  PRIMARY KEY (`id_guide`,`workdate`,`place`),
  CONSTRAINT `p1` FOREIGN KEY (`id_guide`, `workdate`) REFERENCES `workhours` (`id_guide`, `workdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spec_workhours`
--

LOCK TABLES `spec_workhours` WRITE;
/*!40000 ALTER TABLE `spec_workhours` DISABLE KEYS */;
INSERT INTO `spec_workhours` VALUES (1,'2022-07-04','Петроградка','00:30:00'),(1,'2022-07-04','Политка','00:40:00'),(1,'2022-07-04','Хогвартс','00:50:00'),(1,'2022-07-04','Центр','00:55:00'),(8,'2022-07-10','Петроградка','00:20:00'),(8,'2022-07-10','Политка','00:20:00'),(8,'2022-07-10','Хогвартс','00:20:00'),(8,'2022-07-10','Центр','00:20:00'),(9,'2022-03-12','Петроградка','00:20:00'),(9,'2022-03-12','Политка','00:45:00'),(9,'2022-03-12','Хогвартс','00:40:00'),(9,'2022-03-12','Центр','01:00:00');
/*!40000 ALTER TABLE `spec_workhours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workhours`
--

DROP TABLE IF EXISTS `workhours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workhours` (
  `id_guide` int NOT NULL,
  `workdate` date NOT NULL,
  `timest` time DEFAULT NULL,
  `timeend` time DEFAULT NULL,
  PRIMARY KEY (`id_guide`,`workdate`),
  CONSTRAINT `g1` FOREIGN KEY (`id_guide`) REFERENCES `guide` (`id_guide`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workhours`
--

LOCK TABLES `workhours` WRITE;
/*!40000 ALTER TABLE `workhours` DISABLE KEYS */;
INSERT INTO `workhours` VALUES (1,'2022-07-04','11:00:00','19:00:00'),(2,'2022-07-02','10:00:00','19:00:00'),(2,'2022-07-03','10:00:00','19:00:00'),(8,'2022-07-03','10:00:00','22:00:00'),(8,'2022-07-04','10:00:00','23:00:00'),(8,'2022-07-10','10:00:00','23:00:00'),(9,'2022-03-12','10:00:00','23:00:00'),(10,'2022-07-14','10:00:00','22:00:00'),(10,'2022-07-15','12:00:00','19:00:00'),(10,'2022-10-11','09:00:00','19:00:00');
/*!40000 ALTER TABLE `workhours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bot3'
--

--
-- Dumping routines for database 'bot3'
--
/*!50003 DROP FUNCTION IF EXISTS `check_block` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_block`(tip text, cat text, name_ char(30), data_ date, vrem time) RETURNS int
    READS SQL DATA
BEGIN
declare vrem_end time;
declare start_block time;
declare end_block time;
declare ID_block int;
declare flag int;
set flag=1;
set ID_block = (select id_excur from excurtion where type_excur=tip and cat=category_excur and name_=name_excur);
set vrem_end=addtime(vrem, (select dur_excur from excurtion where id_excur=ID_block));
set start_block = (select time_start from blocked where id_excur=ID_block and date_blocked=data_);
set end_block = (select time_end from blocked where id_excur=ID_block and date_blocked=data_);
if ((vrem >= start_block and vrem<=end_block) or (vrem_end >= start_block and vrem_end<=end_block)) then set flag=0;
end if; 
RETURN flag;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_excurtion_available` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_excurtion_available`(tip text, cat text, places CHAR(40), data_ date,vrem time, name_ char(30)) RETURNS int
    READS SQL DATA
BEGIN
declare IDg int;
declare f1 int;
declare f2 int;
declare f3 int;
declare f4 int;
declare f5 int;
declare f0 int;
set IDg = (select id_guide from guide where name_guide=name_);
set f1 = (select bot3.check_block(tip, cat, places, data_, vrem)); 
set f2 = (select bot3.is_guide_denied(tip, cat, places, IDg));
set f3 = (select bot3.is_guide_free(tip, cat, places, data_, vrem, IDg));
set f4 = (select bot3.is_time_available2(places, data_, vrem));
if IDg in (select workhours.id_guide from workhours join guide on workhours.id_guide=guide.id_guide  where workdate=data_ and vrem>=timest  and addtime(vrem, (select dur_excur from excurtion where tip=type_excur and category_excur=cat and places=name_excur)) <=timeend)
then set f0=1;
else set f0=0;
end if;
if f1=1 and f2=1 and f3=1 and f4=1 and f0=1 then set f5=1;
else set f5=0;
end if;
RETURN f5;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_guide_available` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_guide_available`(tip text, cat text, places CHAR(40), data_ datetime,vrem time, name_ char(30)) RETURNS int
    READS SQL DATA
BEGIN
declare IDg int;
declare f2 int;
declare f3 int;
declare f0 int;
declare f5 int;
set IDg = (select id_guide from guide where name_guide=name_);
set f2 = (select bot3.is_guide_denied(tip, cat, places, IDg));
set f3 = (select bot3.is_guide_free(tip, cat, places, data_, vrem, IDg));
if IDg in (select workhours.id_guide from workhours join guide on workhours.id_guide=guide.id_guide  where workdate=data_ and vrem>=timest  and vrem +(select dur_excur from excurtion where tip=type_excur and category_excur=cat and places=name_excur) <=timeend)
then set f0=1;
else set f0=0;
end if;
if f2=1 and f3=1 and f0=1 then set f5=1;
else set f5=0;
end if;
RETURN f5;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_guide_denied` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_guide_denied`(tip text, cat text, name_ char(30), IDg int) RETURNS int
    READS SQL DATA
BEGIN
declare flag int;
declare IDex int;
set IDex = (select id_excur from excurtion where type_excur=tip and cat=category_excur and name_excur=name_);
if IDex in (select id_excur from denied_by_guides where id_guide=IDg) then set flag=0;
else set flag=1;
end if;
RETURN flag;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_guide_free` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_guide_free`(tip text, cat text, places CHAR(40), data_ date,vrem time, IDg int) RETURNS int
    READS SQL DATA
BEGIN
declare max_time_left time;
declare max_time_left2 time;
declare min_time_right time;
declare time_excur time;
declare place_excur char(30);
declare place_last_excur char(30);
declare place_next_excur char(30);
declare dur_last_exc time;
declare flag int;
declare start_time time;
declare home_time time;
declare end_last_exc time;
declare beg_next_exc time;
set start_time = (select timest from workhours where IDg=id_guide and data_=workdate); #Начало рабочего времени
set flag = 1;
set time_excur = (select dur_excur from excurtion where name_excur=places and type_excur=tip and category_excur=cat); #Длительность текущей экскурсии
set place_excur = (select place from excurtion where name_excur=places and type_excur=tip and category_excur=cat); #Место текущей экскурсии
set home_time = (select hometime from spec_workhours where IDg=id_guide and data_=workdate and place=place_excur); #Время от дома до текущей экскурсии
set place_last_excur = (select place from apply join excurtion on apply.id_excur=excurtion.id_excur where id_guide=IDg 
and data_=date_app and time_app<=vrem order by time_app desc limit 1); #Место последней экскурсии
set place_next_excur = (select place from apply join excurtion on apply.id_excur=excurtion.id_excur
where id_guide=IDg and data_=date_app and time_app>=vrem order by time_app limit 1); #Место следующей экскурсии
set dur_last_exc = (select dur_excur from apply join excurtion on apply.id_excur=excurtion.id_excur
where id_guide=IDg and data_=date_app and time_app<=vrem order by time_app desc limit 1); #Длительность последней экскурсии
set end_last_exc = (select addtime(time_app, dur_last_exc) from apply 
where id_guide=IDg and data_=date_app and time_app<=vrem order by time_app desc limit 1); #Время конца последней экскурсии
set beg_next_exc = (select time_app from apply where id_guide=IDg and data_=date_app and time_app>=vrem order by time_app limit 1); #Время начала следующей экскурсии
set max_time_left2 = if(place_last_excur=place_excur, end_last_exc, addtime(end_last_exc, "0:30:0")); #Конец последней экскурсии, если она существует
set max_time_left = if (place_last_excur is null, addtime(start_time, home_time), max_time_left2);  
set min_time_right = if (place_next_excur=place_excur, addtime(vrem, time_excur), addtime("0:30:0", addtime(vrem, time_excur))); #Во сколько гид будет на следующую экскурсию
if ((vrem<max_time_left) or (beg_next_exc<min_time_right)) then set flag=0;
end if;
RETURN flag;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_time_available` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_time_available`(name_ char(30), data_ date, vrem time) RETURNS int
    READS SQL DATA
BEGIN
declare flag int;
declare time_left time;
declare time_right time;
declare duration time;
set flag=1;
set duration = (select dur_excur from excurtion where id_excur in (select id_excur from excurtion where name_=name_excur) order by dur_excur desc limit 1);
set time_left = (select time_app from apply where id_excur in (select id_excur from excurtion where name_=name_excur) and time_app<=vrem and data_=date_app order by time_app desc limit 1);
set time_right = (select time_app from apply where id_excur in (select id_excur from excurtion where name_=name_excur) and time_app>=vrem and data_=date_app order by time_app limit 1);
if ((time_left<=vrem) and (time_left + duration>=vrem)) or ((time_right<=vrem + duration) and (time_right + duration >=vrem + duration)) then set flag = 0;
end if;
RETURN flag;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_time_available2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_time_available2`(name_ char(30), data_ date, vrem time) RETURNS int
    READS SQL DATA
BEGIN
declare flag int;
declare time_left time;
declare time_right time;
declare duration time;
set flag=1;
set duration = (select dur_excur from excurtion where id_excur in (select id_excur from excurtion where name_=name_excur) order by dur_excur desc limit 1);
set time_left = (select time_app from apply where id_excur in (select id_excur from excurtion where name_=name_excur and name_excur='Башенка') and time_app<=vrem and data_=date_app order by time_app desc limit 1);
set time_right = (select time_app from apply where id_excur in (select id_excur from excurtion where name_=name_excur and name_excur='Башенка') and time_app>=vrem and data_=date_app order by time_app limit 1);
if ((time_left<=vrem) and addtime(time_left, duration)>=vrem) or ((time_right<=addtime(vrem, duration)) and (addtime(time_right, duration) >=addtime(vrem, duration))) then set flag = 0;
end if;
RETURN flag;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_apply` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_apply`(in tip text, in cat text, in name_ex char(40), in data_ date, in time_ time, in kolvo text, in info text, in com text, in log_ char(30))
BEGIN
declare ID int;
declare IDex int;
declare IDp int;
set IDex = (select id_excur from excurtion where name_excur=name_ex and type_excur=tip and cat=category_excur);
set IDp = (select id_promik from promik where login_promik=log_);
select max(id_apply) into ID from apply;
insert into apply values(ID + 1, IDex, data_, time_, kolvo, info, com, null, IDp);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_block` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_block`(in name_ char(30), in tip text, in cat text, in name_exc char(40))
BEGIN
declare ID int;
declare id_exc int;
set ID = (select id_guide from guide where name_guide=name_);
set id_exc=(select id_excur from excurtion where type_excur=tip and category_excur=cat and name_excur=name_exc);
insert into denied_by_guides values (ID, id_exc);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_excurtion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_excurtion`(in tip text, in cat text, in name_ char(40), in dur time, in place char(30))
BEGIN
declare ID int;
select max(id_excur) into ID from excurtion;
insert into excurtion values(ID + 1, tip, cat, name_, dur, place);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_guide` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_guide`(in name_ char(30))
BEGIN
declare ID int;
select max(id_guide) into ID from guide;
insert into guide values(ID + 1, name_);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_promik` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_promik`(in login char(30), in password_ char(30), in cat char(10))
BEGIN
declare ID int;
select max(id_promik) into ID from promik;
insert into promik values(ID + 1, login, password_, cat);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_spec_workhours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_spec_workhours`(in name_ char(30), in data_ date, in petr time, in polit time, in hog time, in center time)
BEGIN
declare IDg int;
set IDg = (select id_guide from guide where name_guide=name_);
insert into spec_workhours values(IDg, data_, 'Петроградка', petr);
insert into spec_workhours values(IDg, data_, 'Политка', polit);
insert into spec_workhours values(IDg, data_, 'Хогвартс', hog);
insert into spec_workhours values(IDg, data_, 'Центр', center);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `available_guides` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `available_guides`(in tip text, in cat text, in name_ CHAR(40), in data_ date, in vrem time)
BEGIN
select workhours.id_guide, name_guide from workhours join guide on workhours.id_guide=guide.id_guide  where workdate=data_ and vrem>=timest  and vrem +(select dur_excur from excurtion where tip=type_excur and category_excur=cat and name_=name_excur) <=timeend;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_block` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_block`(in name_ char(30), in tip text, in cat text, in name_exc char(40))
BEGIN
declare ID int;
declare id_exc int;
set ID = (select id_guide from guide where name_guide=name_);
set id_exc=(select id_excur from excurtion where type_excur=tip and category_excur=cat and name_excur=name_exc);
delete from denied_by_guides where id_guide=ID and id_excur=id_exc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_excurtion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_excurtion`(in tip text, in cat text, in name_ char(30))
BEGIN
delete from excurtion where name_excur=name_ and id_excur>0 and type_excur=tip and cat=category_excur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_guide` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_guide`(in name_ char(30))
BEGIN
delete from guide where name_guide=name_ and id_guide>0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_promik` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_promik`(in login_ char(30))
BEGIN
delete from promik where login_promik=login_ and id_promik>0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `del_workhours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_workhours`(in ID int, data_ date)
BEGIN
delete from workhours where id_guide=ID and workdate=data_;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `izmener` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `izmener`(in num int,in numer text,in positioner text)
BEGIN
if positioner = '4' then 
update apply set date_app = numer where id_apply = num;
elseif positioner = '5' then 
update apply set time_app = numer where id_apply = num;
elseif positioner = '6' then 
update apply set amount_app = numer where id_apply = num;
elseif positioner = '7' then 
update apply set infa = numer where id_apply = num;
elseif positioner = '8' then 
update apply set comment = numer where id_apply = num;
elseif positioner = '9' then 
update apply set id_guide = (select id_guide where name_guide =  numer) where id_apply = num;
elseif positioner = '10' then 
update apply set id_promik = (select id_promik where login_promik = numer) where id_apply = num;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `izmener_id_exc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `izmener_id_exc`(in num int,in typer text,in categor text,in ima text)
BEGIN
update apply set id_excur = (select id_excur from excurtion where 
type_excur = typer and category_excur = categor and name_excur = ima) where id_apply = num;
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

-- Dump completed on 2024-07-11 13:26:03
