-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: my_base
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.22-MariaDB

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
-- Table structure for table `admin_by_exec`
--

DROP TABLE IF EXISTS `admin_by_exec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_by_exec` (
  `project_id` int(11) NOT NULL,
  `exec_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `admin_exec_id` (`exec_id`),
  CONSTRAINT `admin_exec_id` FOREIGN KEY (`exec_id`) REFERENCES `executive` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `admin_exec_proj_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_by_exec`
--

LOCK TABLES `admin_by_exec` WRITE;
/*!40000 ALTER TABLE `admin_by_exec` DISABLE KEYS */;
-- INSERT INTO `admin_by_exec` VALUES (2,1),(3,1),(45,1),(8,2),(44,2),(46,2),(9,3),(29,3),(36,3),(43,3),(47,3),(51,3),(52,3),(4,4),(6,4),(10,4),(42,4),(48,4),(11,5),(15,5),(34,5),(41,5),(50,5),(57,5),(14,6),(40,6),(54,6),(12,7),(17,7),(21,7),(39,7),(49,7),(53,7),(55,7),(58,7),(18,8),(38,8),(56,8),(7,9),(19,9),(37,9),(5,10),(20,10),(35,10),(22,11),(33,11),(23,12),(27,12),(32,12),(24,13),(31,13),(25,15),(30,15),(26,16),(28,16);
/*!40000 ALTER TABLE `admin_by_exec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_by_org`
--

DROP TABLE IF EXISTS `admin_by_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_by_org` (
  `project_id` int(11) NOT NULL,
  `organisation_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `admin_org__org_id` (`organisation_id`),
  CONSTRAINT `admin_org__org_id` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `admin_org_proj_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_by_org`
--

LOCK TABLES `admin_by_org` WRITE;
/*!40000 ALTER TABLE `admin_by_org` DISABLE KEYS */;
-- INSERT INTO `admin_by_org` VALUES (2,1),(8,1),(10,1),(5,3),(9,3),(12,3),(14,3),(46,3),(3,6),(4,6),(21,6),(24,7),(15,9),(17,9),(19,9),(20,9),(22,9),(25,9),(28,9),(29,9),(30,9),(31,9),(34,9),(36,9),(37,9),(38,9),(39,9),(43,9),(47,9),(48,9),(50,9),(51,9),(52,9),(53,9),(54,9),(55,9),(56,9),(57,9),(58,9),(26,11),(41,11),(44,11),(6,15),(49,15),(27,16),(11,17),(18,18),(7,19),(32,19),(45,20),(33,24),(35,25),(23,27),(40,28),(42,29);
/*!40000 ALTER TABLE `admin_by_org` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `admin_by_org_people_work` BEFORE DELETE ON `admin_by_org` FOR EACH ROW BEGIN
IF (SELECT COUNT(ws.researcher_id) FROM (works_on_proj AS ws) INNER JOIN admin_by_org
WHERE (ws.project_id = old.project_id AND admin_by_org.project_id = old.project_id))
> 0 THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Cannot remove organisation from administration, its employees are working on the project!';
ELSEIF (SELECT COUNT(ws.researcher_id) FROM (supervision AS ws) INNER JOIN admin_by_org
WHERE (ws.project_id = old.project_id AND admin_by_org.project_id = old.project_id))
> (NOW()) THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Cannot remove organisation from administration, someone supervises it!';
END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `deliverable`
--

DROP TABLE IF EXISTS `deliverable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliverable` (
  `project_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `deadline` date NOT NULL,
  PRIMARY KEY (`project_id`,`name`),
  CONSTRAINT `deliverable_proj_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverable`
--

LOCK TABLES `deliverable` WRITE;
/*!40000 ALTER TABLE `deliverable` DISABLE KEYS */;
-- INSERT INTO `deliverable` VALUES (2,'Δεύτερο Στάδιο','2021-12-24'),(2,'Πρώτο Στάδιο','2021-04-23'),(6,'Αλουμίνια','2003-02-23'),(7,'Εσερίχεια Κόλη','2001-12-23'),(8,'Φάση Α','2000-02-15'),(14,'Χέρι ρομπότ','2020-12-23'),(36,'φηηγηξ','2021-12-23'),(38,'γφλφγ','2021-12-23'),(39,'κδφφγκφγ','2021-12-23');
/*!40000 ALTER TABLE `deliverable` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deliv_deadline` BEFORE INSERT ON `deliverable` FOR EACH ROW BEGIN
IF ((SELECT DISTINCT project.start FROM project
WHERE project.id = new.project_id) > new.deadline)
OR ((SELECT DISTINCT project.end FROM project
WHERE project.id = new.project_id) < new.deadline) THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Deadline must be within project date bounds!';
END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `organisation_id` int(11) NOT NULL,
  `researcher_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`researcher_id`),
  KEY `organisation` (`organisation_id`),
  CONSTRAINT `employee_researcher_id` FOREIGN KEY (`researcher_id`) REFERENCES `researcher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `organisation` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
-- INSERT INTO `employee` VALUES (1,1,'2001-09-23'),(4,2,'2017-10-10'),(9,3,'2016-11-12'),(9,4,'2015-02-04'),(11,5,'2014-01-01'),(8,6,'2017-03-20'),(11,7,'2017-12-18'),(7,9,'2017-08-18'),(2,11,'2000-07-12'),(4,12,'2016-12-01'),(5,13,'2015-05-12'),(9,14,'2010-10-01'),(6,15,'2014-12-12'),(6,16,'2020-12-20'),(6,17,'2018-12-20'),(10,18,'2017-11-09'),(10,19,'2016-03-29'),(10,20,'2015-03-29'),(4,21,'2017-10-30'),(1,22,'2001-03-22'),(3,23,'2001-08-30'),(3,24,'2010-10-25'),(3,25,'2014-09-27'),(9,29,'2014-08-10'),(7,30,'1997-03-20'),(5,31,'2014-02-13'),(11,32,'2015-12-12'),(5,33,'2017-06-20'),(9,34,'2015-12-21'),(11,35,'2015-12-12'),(11,36,'2015-12-12'),(9,37,'2015-12-21'),(19,38,'2015-12-21'),(20,39,'2015-12-21'),(6,40,'2015-12-21'),(11,41,'2015-12-12'),(25,42,'2015-12-21'),(11,43,'2015-12-12'),(9,44,'2015-12-21'),(21,45,'2015-12-21'),(11,47,'2015-12-12'),(11,48,'2015-12-12'),(15,50,'2015-12-21'),(11,51,'2015-12-12'),(2,52,'2015-12-21'),(14,53,'2015-12-21'),(9,54,'2015-12-21'),(11,55,'2015-12-12'),(13,56,'2015-12-21'),(11,57,'2015-12-12'),(1,58,'2015-12-21'),(11,59,'2015-12-21'),(7,60,'2015-12-21'),(11,61,'2015-12-12'),(10,62,'2015-12-21'),(11,63,'2015-12-12'),(9,64,'2015-12-21'),(9,65,'2015-12-21'),(11,66,'2015-12-12'),(27,67,'2015-12-21'),(30,68,'2015-12-21'),(23,69,'2015-12-21'),(9,70,'2015-12-21'),(9,71,'2015-12-21'),(11,72,'2015-12-12'),(26,73,'2015-12-21'),(30,74,'2015-12-21'),(24,75,'2015-12-21'),(9,76,'2015-12-21'),(9,77,'2015-12-21'),(9,78,'2015-12-21'),(9,79,'2015-12-21'),(9,80,'2015-12-21'),(22,81,'2015-12-21'),(9,82,'2015-12-21'),(9,83,'2015-12-21'),(28,84,'2015-12-21'),(29,85,'2015-12-21'),(11,86,'2015-12-12'),(11,87,'2015-12-12'),(11,88,'2015-12-12'),(11,89,'2015-12-12'),(11,90,'2015-12-12'),(9,91,'2015-12-21'),(8,92,'2015-12-21'),(11,93,'2015-12-12'),(4,94,'2015-12-21'),(7,95,'2015-12-21'),(9,96,'2015-12-21'),(11,97,'2015-12-12'),(17,98,'2015-12-21'),(11,99,'2015-12-12'),(3,100,'2015-12-21'),(16,101,'2015-12-21'),(5,102,'2015-12-21'),(11,103,'2015-12-12'),(18,104,'2015-12-21'),(11,105,'2015-12-12');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employee_project` BEFORE DELETE ON `employee` FOR EACH ROW BEGIN
IF (SELECT MAX(p.end) -- Find the MAX end date of projects that researcher with id = 1 has worked on
FROM (project AS p) INNER JOIN (works_on_proj AS w)
WHERE (w.researcher_id = old.researcher_id AND w.project_id = p.id))
> (NOW()) THEN -- If max date is yet to come, the researcher still has projects to work on
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Researcher works on potentially active project!';
ELSEIF (SELECT MAX(p.end) -- Find the end date of projects that researcher with id = 1 has supervised
FROM (project AS p) INNER JOIN (supervision AS w)
WHERE (w.researcher_id = old.researcher_id AND w.project_id = p.id))
> (NOW()) THEN -- If max date is yet to come, the researcher still has projects to supervise
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Researcher supervises potentially active project!';
END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `executive`
--

DROP TABLE IF EXISTS `executive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `executive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `executive`
--

LOCK TABLES `executive` WRITE;
/*!40000 ALTER TABLE `executive` DISABLE KEYS */;
-- INSERT INTO `executive` VALUES (1,'Αριστομένης','Παπαδόπουλος'),(2,'Φαίδων','Κυριακίδης'),(3,'Μενέλαος','Παπαπαύλου'),(4,'Παρμενίων','Περιστέρης'),(5,'Ιάσονας','Αργοναύτης'),(6,'Περικλής','Χρυσός'),(7,'Αχιλλέας','Φτέρνας'),(8,'Ιφιγένεια','Αυλίδου'),(9,'Ασπασία','Εξαπίνη'),(10,'Ιφιγένεια','Ταύρου'),(11,'Ευαγόρας','Παπαβαγγέλης'),(12,'Περικλής','Σφιγγόπουλος'),(13,'Κλέαρχος','Υπερείδης'),(15,'Παρασκυάς','Κελετζής'),(16,'Ηλέκτρα','Μηχανικού');
/*!40000 ALTER TABLE `executive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field` (
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
-- INSERT INTO `field` VALUES ('Αρχαιολογία'),('Βιοιατρική'),('Βιολογία'),('Γλωσσολογία'),('Ηλεκτρονική'),('Μαθηματικά'),('Οικονομικά'),('Περιβάλλον'),('Πληροφορική'),('Φυσική');
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financing`
--

DROP TABLE IF EXISTS `financing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financing` (
  `project_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `program` (`program_id`),
  CONSTRAINT `program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `project` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financing`
--

LOCK TABLES `financing` WRITE;
/*!40000 ALTER TABLE `financing` DISABLE KEYS */;
-- INSERT INTO `financing` VALUES (2,3),(11,3),(56,3),(6,6),(12,6),(55,6),(57,6),(3,7),(10,7),(14,7),(15,7),(54,7),(4,8),(17,8),(53,8),(5,9),(9,9),(18,9),(52,9),(7,10),(19,10),(33,10),(51,10),(20,12),(34,12),(50,12),(8,13),(21,13),(35,13),(49,13),(22,18),(36,18),(48,18),(23,19),(37,19),(47,19),(24,20),(46,20),(58,20),(45,21),(44,22),(43,23),(42,24),(41,25),(40,26),(39,27),(32,28),(38,28),(31,29),(30,30),(29,31),(26,32),(28,32),(27,33),(25,34);
/*!40000 ALTER TABLE `financing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grading`
--

DROP TABLE IF EXISTS `grading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grading` (
  `project_id` int(11) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `researcher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `grading_researcher_id` (`researcher_id`),
  CONSTRAINT `grading_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `grading_researcher_id` FOREIGN KEY (`researcher_id`) REFERENCES `researcher` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grading`
--

LOCK TABLES `grading` WRITE;
/*!40000 ALTER TABLE `grading` DISABLE KEYS */;
-- INSERT INTO `grading` VALUES (2,81,'2020-01-10',17),(3,56,'2017-12-23',56),(4,56,'2017-12-23',57),(5,56,'2017-12-23',58),(6,56,'2017-12-23',59),(7,78,'2017-12-23',60),(8,78,'2017-12-23',61),(11,98,'2020-07-14',1),(14,83,'2017-06-17',16),(15,83,'2017-06-17',21),(17,83,'2017-06-17',22),(18,83,'2017-06-17',23),(19,63,'2018-11-22',24),(20,63,'2018-11-22',25),(21,63,'2018-11-22',29),(22,63,'2018-11-22',30),(23,63,'2018-11-22',31),(24,63,'2018-11-22',32),(25,63,'2018-11-22',33),(26,63,'2018-11-22',34),(27,63,'2018-11-22',35),(28,63,'2018-11-22',36),(29,94,'2018-12-09',90),(30,94,'2018-12-09',2),(31,94,'2018-12-09',63),(32,65,'2017-06-12',63),(33,65,'2017-06-12',62),(34,65,'2017-06-12',61),(35,65,'2017-06-12',60),(36,65,'2017-06-12',59),(37,65,'2017-06-12',58),(38,51,'2017-06-12',25),(39,51,'2017-06-12',24),(40,51,'1940-04-29',81),(41,51,'1940-04-29',80),(42,71,'2018-04-29',98),(43,71,'2018-04-29',97),(44,71,'2018-04-29',96),(45,71,'2018-04-29',95),(46,58,'2017-05-03',94),(47,58,'2017-05-03',93),(48,58,'2017-05-03',63),(49,58,'2017-05-03',62),(50,58,'2017-05-03',61),(51,58,'2017-05-03',60),(52,58,'2017-05-03',1),(53,58,'2017-05-03',43),(54,58,'2017-05-03',42),(55,58,'2017-05-03',41),(56,63,'2018-11-22',40),(57,63,'2018-11-22',39),(58,63,'2018-11-22',38);
/*!40000 ALTER TABLE `grading` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `grader_org` BEFORE INSERT ON `grading` FOR EACH ROW BEGIN
IF (SELECT DISTINCT employee.organisation_id FROM
employee NATURAL JOIN researcher
WHERE employee.researcher_id = new.researcher_id)
= (SELECT DISTINCT admin_by_org.organisation_id FROM project INNER JOIN admin_by_org
ON project.id = admin_by_org.project_id
WHERE (project.id = new.project_id)) THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Grading researcher must not be of same organisation as the project!';
END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `organisation`
--

DROP TABLE IF EXISTS `organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `short_name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `postal_code` int(11) NOT NULL,
  `street` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_organisation` (`id`),
  CONSTRAINT `CHK_Category` CHECK (strcmp(`category`,'Πανεπιστήμιο') = 0 or strcmp(`category`,'Ερευνητικό Κέντρο') = 0 or strcmp(`category`,'Εταιρία') = 0)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation`
--

LOCK TABLES `organisation` WRITE;
/*!40000 ALTER TABLE `organisation` DISABLE KEYS */;
-- INSERT INTO `organisation` VALUES (1,'Εθνικό Μετσόβιο Πολυτεχνείο','ΕΜΠ','Αθήνα',1234,'Ηρώων Πολυτεχνείου','Πανεπιστήμιο'),(2,'Καποδιστριακό','ΕΚΠΑ','Αθήνα',5678,'Ιπποκράτους','Πανεπιστήμιο'),(3,'Πανεπιστήμιο Θεσσαλίας','ΠΑΘΕ','Βόλος',47873,'Αργοναυτών','Πανεπιστήμιο'),(4,'Ινστιτόυτο έρευνας καινοτομίας','ΙΕΚ','Μαλακάσα',46573,'Ναυτών','Ερευνητικό Κέντρο'),(5,'Τεχνολογικό κέντρο αιχμής','ΤΕΚΑ','Ξάνθη',4589,'Θεμιστοκλέους','Ερευνητικό Κέντρο'),(6,'Βιοεργαστήρια Βιοιατρικής','ΒΒ','Φλώρινα',12781,'Καποδίστρια','Ερευνητικό Κέντρο'),(7,'Επιστημονικό κέντρο Κανελόπουλου','ΕΚΚ','Ιωάννινα',34992,'Καραθεοδωρή','Ερευνητικό Κέντρο'),(8,'Εταιρία Όνομα ΟΕ','ΕΟ','Δράμα',48329,'Μαυρογένους','Εταιρία'),(9,'Χαλυβουργική Κιλκίς ΕΕ','ΧΚ','Κιλκίς',37821,'Κολοκοτρώνη','Εταιρία'),(10,'Πανεπιστήμιο Στερεάς Ελλάδας','ΠΣΕ','Λαμία',12783,'Ελευθερίας','Πανεπιστήμιο'),(11,'Ανοιχτό Πανεπιστήμιο','ΑΠ','Κάπου',11230,'Φ. Δέδε','Πανεπιστήμιο'),(13,'Ορυκτά Καύσιμα ΑΕ','ΟΚ','Ρέθυμνο',78787,'Ηράκλειτου','Εταιρία'),(14,'Πανεπιστήμιο Πειραιά','ΠΑΠΕΙ','Πειραιάς',14853,'Σοφοκλέους','Πανεπιστήμιο'),(15,'Αφοί Αλεξανδρή','ΑΑ','Άγιος Νικόλας',54893,'Βενιζέλου','Εταιρία'),(16,'Πτήση του Ίκαρου','ΠΤΙ','Κνωσός',18211,'Δαίδαλου','Ερευνητικό Κέντρο'),(17,'Φιλοπάππος και Υιοί','ΦΥ','Καβάλα',81893,'Καπνικαρέας','Εταιρία'),(18,'Οικονομικό Πανεπιστήμιο','ΟΠ','Αργοστόλι',68953,'Νησιωτών','Πανεπιστήμιο'),(19,'Αλεπουδάκης και Σία','ΑΣ','Σπάρτη',48729,'Λεωνίδα','Εταιρία'),(20,'Δαιδαλώδεις Σχεδιαστές','ΔΣ','Φαιστός',16711,'Λαβυρίνθου','Ερευνητικό Κέντρο'),(21,'Φιλολογικό Πανεπιστήμιο','ΦΦ','Όλυμπος',98765,'Φιλοσόφων','Πανεπιστήμιο'),(22,'Οβελιστήριο Θεός της Πείνας','ΟΘΠ','Στυξ',66642,'Κόλασης','Εταιρία'),(23,'Καθρέφτης του Αρχιμήδη','ΚΤΑ','Ηγουμενίτσα',90871,'Αριστοτέλους','Ερευνητικό Κέντρο'),(24,'Διεθνή γεωτρύπανα ΕΕ','ΔΓ','Ξάνθη',34111,'Πλαστήρα','Εταιρία'),(25,'Τσαγκαράδικο του Μητσάρα','ΤΜ','Φάληρο',71211,'Μπότσαρη','Εταιρία'),(26,'Σπουδαίοι Ερευνητές','ΣΕ','Χαλκιδική',19563,'Φιλελλήνων','Ερευνητικό Κέντρο'),(27,'Πανεπιστήμιο Εύβοιας','ΠΕ','Χαλκίδα',54892,'Αρχαίου Θεάτρου','Πανεπιστήμιο'),(28,'Χημική Εταιρία','ΧΕ','Ορεστιάδα',8213,'Ορφέα','Εταιρία'),(29,'Σύνδεσμος Ελλήνων Μαθηματικών','ΣΕΜ','Περιστέρι',45923,'Παπάγου','Ερευνητικό Κέντρο'),(30,'Διεθνές Πανεπιστήμιο','ΔΠ','Παντού',12094,'Πλάτωνα','Πανεπιστήμιο');
/*!40000 ALTER TABLE `organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisation_phone`
--

DROP TABLE IF EXISTS `organisation_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation_phone` (
  `organisation_id` int(11) NOT NULL,
  `telephone_number` varchar(45) NOT NULL,
  PRIMARY KEY (`organisation_id`,`telephone_number`),
  UNIQUE KEY `telephone_number` (`telephone_number`),
  CONSTRAINT `organisation_phone_id` FOREIGN KEY (`organisation_id`) REFERENCES `organisation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation_phone`
--

LOCK TABLES `organisation_phone` WRITE;
/*!40000 ALTER TABLE `organisation_phone` DISABLE KEYS */;
-- INSERT INTO `organisation_phone` VALUES (1,'5919562095'),(1,'6493008199'),(1,'9146467528'),(2,'4489556724'),(2,'9763235962'),(3,'2664719187'),(3,'4271377555'),(3,'8563708332'),(4,'4507203666'),(4,'8099442029'),(4,'8749343167'),(4,'8749343432'),(5,'4513911897'),(5,'5536865701'),(6,'6513745945'),(9,'9845763280'),(11,'8749343123'),(13,'9845763278'),(14,'123458765');
/*!40000 ALTER TABLE `organisation_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `address` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
-- INSERT INTO `program` VALUES (3,'Προώθηση νέας τεχνολογίας','Διεύθυνση Τεχνολογίας'),(6,'Αειφόρος ανάπτυξη','Διεύθυνση Βιωσιμότητας'),(7,'Καινοτομία','Διεύθυνση Έρευνας'),(8,'Πράσινη σκέψη','Διεύθυνση Βιωσιμότητας'),(9,'Ηλεκτρονικές τεχνολογίες','Διεύθυνση Ηλεκτρονικών'),(10,'Γεωφυσική επένδυση','Διεύθυνση Περιβάλλοντος'),(12,'Επιστροφή στις ρίζες','Διεύθυνση Αρχαιολογίας'),(13,'Ανασκαφές στη Βόρεια Ελλάδα','Διεύθυνση Αρχαιολογίας'),(18,'Πρόγραμμα κοινωνικής πρόνοιας','Διεύθυνση Κοινωνίας'),(19,'Πρόγραμμα Διατήρησης Ιστορίας','Διεύθυνση Αρχαιολογίας'),(20,'Πρόγραμμα Αποδοτικής Ανάπτυξης','Διεύθυνση Οικονομίας'),(21,'Πρόγραμμα Ενίσχυσης Τάσεων Αυτοματισμού','Διεύθυνση Ηλεκτρονικών'),(22,'Ευρωπαικό πρόγραμμα καλλιτεχνίας','Διεύθυνση Τεχνών'),(23,'Χορηγία Εθνικού Θεάτρου','Διεύθυνση Τεχνών'),(24,'Φιλική τεχνολογία','Διεύθυνση Τεχνολογίας'),(25,'Πρόγραμμα Εξάπλωσης Επικοινωνίας','Διεύθυνση Κοινωνίας'),(26,'Βραβείο στις νέες καινοτομίες','Διεύθυνση Τεχνολογίας'),(27,'Διαγωνισμός για πράσινες προτάσεις','Διεύθυνση Περιβάλλοντος'),(28,'Πρόγραμμα φυσικών πόρων','Διεύθυνση Περιβάλλοντος'),(29,'Επένδυση στις ανανεώσιμες','Διεύθυνση Ηλεκτρονικών'),(30,'Ηλεκτρονική Επανάστηση','Διεύθυνση Ηλεκτρονικών'),(31,'Τεχνολογική Επανάσταση','Διεύθυνση Τεχνολογίας'),(32,'Πράσινη προώθηση','Διεύθυνση Περιβάλλοντος'),(33,'Παιδεία για όλους','Διεύθυνση Κοινωνίας'),(34,'Μουσικοτεχνολογία','Διεύθυνση Τεχνών');
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `information` mediumtext NOT NULL,
  `start` date NOT NULL,
  `end` date NOT NULL,
  `budget` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_project` (`id`),
  CONSTRAINT `CHK_Date` CHECK (`end` > `start` and to_days(`end`) - to_days(`start`) <= 1461 and to_days(`end`) - to_days(`start`) >= 365),
  CONSTRAINT `CHK_Budget` CHECK (`budget` >= 100000 and `budget` <= 1000000)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
-- INSERT INTO `project` VALUES (2,'Διαμορφωσεις ASK1024','κι αλλο μπλα μπλα','2020-02-15','2023-10-17',205000),(3,'Γλωσσα προγραμματισμου D++','περισσοτερο μπλα μπλα','2024-02-15','2026-10-17',300000),(4,'Αποδοτικές ανεμογεννήτριες','σδφξξφδκξδ','2024-02-15','2026-06-04',310000),(5,'Σμίκρυνση VLSI','ασδσφ','2024-02-15','2027-01-21',410600),(6,'Εξοικονόμηση ενέργειας σε σπίτια','Γενική διαμόρφωση κτιρίων, αποδοτικότητα','2002-12-23','2004-03-11',210600),(7,'Κλωνοποίηση βακτηρίων','Διπλασιασμός ενός βακτηρίου','2000-03-05','2002-11-11',244700),(8,'Γεώτρηση 3 χιλιόμετρα','Νέες τεχνικές γεώτρησης','1999-03-22','2001-10-20',271830),(9,'Εικονική Πραγματικότητα','Ψεύτικα πράγματα που φαίνονται αληθινά','2021-07-16','2024-01-30',751800),(10,'Εξελιγμένη κρυπτογραφία','Εφαρμογή μεθόδων προστασίας δεδομένων','2020-11-07','2023-02-03',173910),(11,'Καταλύτης 99','Νέος καταλύτης με μείωση εκπομπής καυσαερίων 99%','2022-12-23','2025-09-12',987000),(12,'Αυτοκίνητο 300','Αυτοκίνητο που θα τρέχει με 300χλμ/ώρα','2020-02-20','2023-08-11',760000),(14,'Έρευνα σε ρομπότ','Σήματα και χειρισμός ρομπότ','2019-02-15','2022-10-17',150000),(15,'Εύρεση τάφου Μ.Αλεξάνδρου','Θα τον βρούμε κάποια στιγμή, που θα παέι','2020-06-01','2023-12-15',350000),(17,'Εντομοφαγία','Μελέτη και επιπτώσεις που έχει στην υγεία','2020-02-15','2022-11-17',174000),(18,'Ταξίδι στον Άρη','Έρευνα για ταξίδι','2023-04-25','2025-09-17',706700),(19,'Εξελιγμένη πίσσα','Θα χρησιμοποιηθεί στην άσφαλτο','2021-08-17','2023-01-27',999000),(20,'Αεροπορική σύνδεση Γης Σελήνης','Πετάμε στο φεγγάρι','2030-07-13','2033-12-12',987000),(21,'Βιωσιμότητα χωματερής στα Λιόσια','Καλά δεν θα γίνει ποτέ αυτό','2050-01-01','2052-12-31',500000),(22,'Υποθαλάσσιος δρόμος Πειραιάς Ρώμη','Κολύμπι','2020-02-15','2023-10-17',850000),(23,'Κοπή διαμαντιού με λέιζερ','Προσέχτε, κόβει πολυ','2021-03-23','2023-11-05',642300),(24,'Ταξίδι στο κέντρο της Γης','Σκάβουμε αρκετά','2018-11-15','2022-07-27',345678),(25,'Πυρηνικός σταθμός','Μελέτη ώστε να μην κινδινεύει από σεισμούς','2021-08-05','2023-09-18',732000),(26,'Αναδάσοση με τρανζίστορ','Το μέλλον των δέντρων είναι τώρα','2021-09-20','2023-08-19',342000),(27,'Αυτόματα πυροσβεστικά ελικόπτερα','Άμεση ανταπόκριση σε ανάγκη','2023-10-10','2025-02-19',832230),(28,'Πολύχρωμοι φακοί επαφής','Αλλάζουν το χρώμα των ματιών','2020-11-24','2023-01-07',832564),(29,'Τεχνητό συκώτι','Τώρα μπορείς να πίνεις όσο θες','2020-07-06','2022-10-16',328000),(30,'Φυσικός υπολογιστής','Υπολογιστής φτιαγμένος μόνο από φυσικά υλικά','2020-03-15','2023-12-18',378921),(31,'Φαγητό από πλαστικό','Θρεπτικές τροφές φτιαγμένες από ανακυκλώσιμο πλαστικό','2019-04-25','2022-12-17',378124),(32,'Διαστημική Διασύνδεση Αθήνα-Λαμία','Χωρίς διόδια','2021-07-17','2023-02-08',842000),(33,'Τηλεμεταφορά','Εφαφάνιση και επανεμφάνιση','2022-03-15','2025-04-20',507000),(34,'Γονιμοποίηση άγονων πεδιάδων','Νέα γη για καλλιέργειες','2020-11-01','2022-12-05',509700),(35,'Ανατίναξη βουνών','Χρειαζόμαστε κι άλλο χώρο','2022-02-21','2024-07-29',234500),(36,'Εναέριοι δρόμοι στην Αθήνα','Λιγότερη ηχορύπανση','2020-10-28','2023-01-29',908700),(37,'Μετρό Θεσσαλονίκης','Δεν θα γίνε ποτέ','2040-03-15','2043-12-18',123456),(38,'Ουρανοξύστης στη Λαμία','Πρέπει να χει ωραία θέα','2020-04-01','2023-07-19',450000),(39,'Νέα Παιδαγωγική','Μέθοδοι για να μαθαίνουν τα παιδάκια','2019-05-11','2022-08-29',150000),(40,'Κοραλιογενής Ύφαλος στον Πειραιά','Τόνωση του φυσικού περιβάλλοντος','2021-08-24','2023-09-07',785400),(41,'Τεχνητή Λίμνη Μόρνου','Ύδρευση Αττικής','1960-04-01','1963-07-19',612000),(42,'Νοητικός έλεγχος αντικειμένων','Τηλεκίνηση','2022-04-01','2025-03-25',895000),(43,'Τυχαίο έργο','Δεν έχω ιδέες','2021-11-30','2023-06-13',595000),(44,'Επιχορήγηση κάτι','Τυχαία περίληψη','2021-10-01','2024-01-28',175000),(45,'Νέο πρωτότυπο έργο','Κανούρια ιδέα','2021-12-03','2023-07-17',629000),(46,'Διαδίκτυο','Σύνδεση πολλών υπολογιστών','1980-04-01','1983-06-10',995000),(47,'Ανθρωπιστικότερη παιδεία','Πνοή στην εκπαίδευση','2020-04-01','2023-08-09',444000),(48,'Πλήρης αναστήλωση Ακρόπολης','Θυμόμαστε τα παλιά','2019-03-20','2022-12-01',987000),(49,'Αισθητήρες Κίνησης','Σύγχρονα συστήματα ελεγκτών','2021-05-20','2023-01-21',786000),(50,'Ψυγείο με τεχνητή νοημοσύνη','Αυτοματοποίηση παντού','2019-12-01','2022-07-29',654000),(51,'Διαδίκτυο πραγμάτων','Σύνδεση των πάντων με τα πάντα','2020-03-01','2022-10-09',123987),(52,'Χαλυβουργία Υψηλού Επιπέδου','Μιλάμε για χάλυβα, όχι αστεία','2019-05-23','2022-08-20',800780),(53,'Ανάδειξη Φυσικής Ομορφιάς στο Κιλκίς','Πολύ όμορφο μέρος','2019-11-02','2022-01-21',150000),(54,'Οικονομική εξόρυξη σιδήρου στη Μακεδονία','Έχει πράμα εκεί πέρα','2019-03-30','2022-10-20',900789),(55,'Εφεύρεση νέων κραμάτων','Πειραματισμός σε υψικαμίνους','2019-03-27','2023-01-19',867000),(56,'Κατασκευή ιπτάμενων αυτοκινήτων','Προσοχή μην τρακάρουν με αεροπλάνα','2019-08-12','2023-02-21',450000),(57,'Άθραυστοι σιδερένιοι τόιχοι μικρού πάχους','Και λεπτοί, και ανθεκτικοί','2019-12-07','2022-06-12',309000),(58,'Ένα ακόμα','Ό,τι να είναι','2019-12-12','2022-11-23',123456);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_field`
--

DROP TABLE IF EXISTS `project_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_field` (
  `project_id` int(11) NOT NULL,
  `field_name` varchar(45) NOT NULL,
  PRIMARY KEY (`project_id`,`field_name`),
  KEY `pf_name` (`field_name`),
  CONSTRAINT `pf_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pf_name` FOREIGN KEY (`field_name`) REFERENCES `field` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_field`
--

LOCK TABLES `project_field` WRITE;
/*!40000 ALTER TABLE `project_field` DISABLE KEYS */;
-- INSERT INTO `project_field` VALUES (2,'Βιοιατρική'),(2,'Ηλεκτρονική'),(2,'Μαθηματικά'),(2,'Πληροφορική'),(3,'Αρχαιολογία'),(3,'Ηλεκτρονική'),(3,'Περιβάλλον'),(3,'Πληροφορική'),(3,'Φυσική'),(4,'Αρχαιολογία'),(4,'Βιολογία'),(4,'Ηλεκτρονική'),(4,'Μαθηματικά'),(5,'Γλωσσολογία'),(5,'Περιβάλλον'),(5,'Φυσική'),(6,'Αρχαιολογία'),(6,'Ηλεκτρονική'),(6,'Περιβάλλον'),(7,'Αρχαιολογία'),(7,'Βιολογία'),(7,'Οικονομικά'),(8,'Μαθηματικά'),(8,'Πληροφορική'),(8,'Φυσική'),(9,'Αρχαιολογία'),(9,'Περιβάλλον'),(9,'Φυσική'),(10,'Γλωσσολογία'),(10,'Οικονομικά'),(10,'Φυσική'),(11,'Βιοιατρική'),(11,'Περιβάλλον'),(11,'Φυσική'),(12,'Αρχαιολογία'),(12,'Μαθηματικά'),(12,'Οικονομικά'),(14,'Βιοιατρική'),(14,'Βιολογία'),(14,'Οικονομικά'),(15,'Αρχαιολογία'),(15,'Οικονομικά'),(15,'Πληροφορική'),(17,'Βιοιατρική'),(17,'Πληροφορική'),(17,'Φυσική'),(18,'Αρχαιολογία'),(18,'Βιολογία'),(18,'Μαθηματικά'),(19,'Μαθηματικά'),(20,'Γλωσσολογία'),(21,'Βιοιατρική'),(21,'Οικονομικά'),(22,'Βιολογία'),(22,'Μαθηματικά'),(23,'Βιολογία'),(23,'Ηλεκτρονική'),(23,'Περιβάλλον'),(24,'Αρχαιολογία'),(24,'Ηλεκτρονική'),(25,'Βιολογία'),(25,'Ηλεκτρονική'),(26,'Περιβάλλον'),(27,'Βιοιατρική'),(27,'Πληροφορική'),(27,'Φυσική'),(28,'Αρχαιολογία'),(28,'Γλωσσολογία'),(28,'Φυσική'),(29,'Βιολογία'),(30,'Αρχαιολογία'),(30,'Βιολογία'),(30,'Μαθηματικά'),(31,'Βιοιατρική'),(31,'Μαθηματικά'),(31,'Οικονομικά'),(32,'Αρχαιολογία'),(32,'Βιοιατρική'),(32,'Περιβάλλον'),(33,'Ηλεκτρονική'),(33,'Οικονομικά'),(33,'Περιβάλλον'),(34,'Αρχαιολογία'),(35,'Αρχαιολογία'),(35,'Γλωσσολογία'),(35,'Περιβάλλον'),(36,'Αρχαιολογία'),(36,'Βιολογία'),(37,'Αρχαιολογία'),(37,'Γλωσσολογία'),(37,'Περιβάλλον'),(38,'Βιολογία'),(38,'Περιβάλλον'),(38,'Φυσική'),(39,'Αρχαιολογία'),(39,'Βιοιατρική'),(39,'Βιολογία'),(40,'Αρχαιολογία'),(40,'Βιολογία'),(40,'Μαθηματικά'),(41,'Αρχαιολογία'),(41,'Γλωσσολογία'),(41,'Μαθηματικά'),(42,'Βιοιατρική'),(42,'Γλωσσολογία'),(42,'Περιβάλλον'),(43,'Βιοιατρική'),(43,'Περιβάλλον'),(43,'Πληροφορική'),(44,'Πληροφορική'),(45,'Αρχαιολογία'),(45,'Ηλεκτρονική'),(46,'Αρχαιολογία'),(46,'Μαθηματικά'),(46,'Οικονομικά'),(47,'Γλωσσολογία'),(47,'Μαθηματικά'),(47,'Πληροφορική'),(48,'Πληροφορική'),(49,'Αρχαιολογία'),(49,'Ηλεκτρονική'),(49,'Φυσική'),(50,'Βιοιατρική'),(50,'Μαθηματικά'),(50,'Φυσική'),(51,'Βιολογία'),(51,'Μαθηματικά'),(52,'Βιολογία'),(52,'Μαθηματικά'),(52,'Πληροφορική'),(53,'Βιοιατρική'),(53,'Περιβάλλον'),(54,'Αρχαιολογία'),(54,'Μαθηματικά'),(54,'Περιβάλλον'),(55,'Βιολογία'),(55,'Μαθηματικά'),(56,'Βιολογία'),(56,'Μαθηματικά'),(57,'Βιοιατρική'),(57,'Μαθηματικά'),(57,'Φυσική'),(58,'Βιοιατρική');
/*!40000 ALTER TABLE `project_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `researcher`
--

DROP TABLE IF EXISTS `researcher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `researcher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `birthdate` date NOT NULL,
  `gender` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_researcher` (`id`),
  CONSTRAINT `CHK_Birthdate` CHECK (`birthdate` < '2009-01-01' and `birthdate` > '1900-01-01')
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `researcher`
--

LOCK TABLES `researcher` WRITE;
/*!40000 ALTER TABLE `researcher` DISABLE KEYS */;
-- INSERT INTO `researcher` VALUES (1,'Μιχάλης','Ηλιόπουλος','1977-02-15','M'),(2,'Παναγιώτης','Παπαθανασίου','1977-08-29','F'),(3,'Ανθή','Γκίκα','1957-01-29','F'),(4,'Μαρία','Καραμήτρου','1970-02-06','F'),(5,'Ιωάννης','Παπαπαντολέων','1976-05-03','M'),(6,'Χρήστος','Παπακώστας','1978-06-01','M'),(7,'Αντώνιος','Οικονόμου','1987-06-23','M'),(9,'Αργύρης','Παπαλάνος','1987-07-16','M'),(11,'Διαμάντω','Μπότσαρη','1950-04-18','F'),(12,'Ανδρομάχη','Ψυχογιού','1970-11-23','F'),(13,'Θεοδώρα','Παπασταύρου','1982-06-30','F'),(14,'Μελέτης','Χατζηδιακόσιας','1983-05-23','M'),(15,'Άννα','Μελετίου','1967-11-12','F'),(16,'Χρήστος','Ψαλλίδας','2001-08-25','M'),(17,'Γιώτα','Παπανδρέου','1956-12-12','F'),(18,'Παναγιώτα','Τσούπρα','1980-07-31','F'),(19,'Δημήτριος','Καρατάβλης','1974-12-12','M'),(20,'Δήμητρα','Καρατάσου','1967-11-03','F'),(21,'Αφροδίτη','Καλλέργη','1991-03-23','F'),(22,'Παρασκευή','Μπασδουκέα','1987-05-14','F'),(23,'Γεώργιος','Κοντοπάνος','1992-12-12','M'),(24,'Βρασίδας','Κρεμμυδόπουλος','2000-02-29','M'),(25,'Φώτης','Τριγωνής','1983-04-25','M'),(29,'Κώστας','Παπαδόπουλος','1989-03-31','M'),(30,'Ελένη','Πετράκη','1979-09-22','F'),(31,'Βαγγελιώ','Πυργάκη','1945-01-21','F'),(32,'Μαριγώ','Μαριγοπούλου','1951-07-14','F'),(33,'Δήμητρα','Εξαδάκτυλου','1974-12-06','F'),(34,'Γιάννης','Λουλάκης','1990-11-23','M'),(35,'Μαρία','Παπαπέτρου','1990-06-12','F'),(36,'Πέτρος','Λούλος','1987-08-12','M'),(37,'Αλέξανδρος','Γεωργίου','1976-11-11','M'),(38,'Ειρήνη','Καραμήτρου','1960-07-31','F'),(39,'Ελευθερία','Διονυσίου','1965-06-21','F'),(40,'Γιώργος','Δάντης','1988-03-01','M'),(41,'Μανώλης','Ανδρουλέας','1978-09-30','M'),(42,'Κυριακή','Παρασκευοπούλου','1990-12-13','F'),(43,'Υβόννη','Κελευστή','1989-10-25','F'),(44,'Βαγγέλης','Παππάς','2000-09-11','M'),(45,'Ελπίδα','Υπαρκτή','1990-12-25','F'),(47,'Ραφαήλ','Γαντάς','1990-05-12','M'),(48,'Φώντας','Σκληρός','1987-04-12','M'),(50,'Δημήτρης','Παπαλέξης','1965-01-18','M'),(51,'Μαρία','Λέκτορα','1964-03-19','F'),(52,'Γιώργος','Πηλιωρίτης','1987-10-10','M'),(53,'Δημήτρης','Γεωργόπουλος','1990-12-12','M'),(54,'Γιώργος','Παπαλούλος','1969-09-06','M'),(55,'Μαρία','Παπαπά','1986-11-23','F'),(56,'Δημήτρης','Μιχαλαριάς','1970-07-12','M'),(57,'Μαρία','Μητροπάνου','1971-05-17','F'),(58,'Γιώργος','Αγόρας','1945-10-03','M'),(59,'Δημήτρης','Λιοπύρης','1992-11-30','M'),(60,'Γιώργος','Ρόπουλος','1995-02-20','M'),(61,'Μαρία','Μελετίου','1999-04-21','F'),(62,'Δημήτρης','Μερακλής','1995-08-23','M'),(63,'Μαρία','Μάρκου','1999-09-10','F'),(64,'Γιάννης','Μάστορας','1972-03-18','M'),(65,'Αλεξάνδρα','Υδραυλικού','1964-03-19','F'),(66,'Μάριος','Χτίστης','1987-10-10','M'),(67,'Κώστας','Μαλαγάνας','1990-12-12','M'),(68,'Λεωνίδας','Λούλος','1969-09-06','M'),(69,'Ιωάννα','Βασιλείου','1986-11-23','F'),(70,'Γιάννης','Γιαννιώτας','1970-07-12','M'),(71,'Αλεξάνδρα','Μητρολάνου','1971-05-17','F'),(72,'Μάριος','Πουλημένος','1949-10-03','M'),(73,'Κώστας','Ηλιοφόρος','1993-11-30','M'),(74,'Λεωνίδας','Φωστήρας','1994-02-20','M'),(75,'Ιωάννα','Αλαλάνου','1979-04-21','F'),(76,'Γιάννης','Μεράκης','1995-08-23','M'),(77,'Αλεξάνδρα','Ποτίκου','1999-09-10','F'),(78,'Απόστολος','Ελευθερόπουλος','1982-01-28','M'),(79,'Αντωνία','Καβαλούρη','1954-02-17','F'),(80,'Αντριάννα','Κουλούρης','1985-03-20','M'),(81,'Θανάσης','Μαραγκός','1990-11-15','M'),(82,'Βλάσης','Μοσχόπουλος','1959-04-26','M'),(83,'Άννα','Πουλοπούλου','1988-10-13','F'),(84,'Λάζαρος','Ραγκαβής','1974-06-22','M'),(85,'Λάμπρος','Ρόκας','1981-06-14','F'),(86,'Οδυσσέας','Σημηριώτης','1959-11-06','M'),(87,'Μιλτιάδης','Στεφανόπουλος','1983-12-10','M'),(88,'Ορέστης','Δέδες','1949-01-22','M'),(89,'Στυλιανός','Δασκαλάκη','1959-08-11','F'),(90,'Σπύρος','Γαλάνης','1996-09-24','M'),(91,'Αριάδνη','Γρηγορίου','1995-05-11','F'),(92,'Δημήτρης','Γούσιος','1965-01-18','M'),(93,'Μαρία','Παλαμά','1964-03-19','F'),(94,'Γιώργος','Ευαγγελιστής','1987-10-10','M'),(95,'Δημήτρης','Κυριακός','1990-12-12','M'),(96,'Γιώργος','Δενδρινός','1969-09-06','M'),(97,'Μαρία','Βασιλόπουλου','1986-11-23','F'),(98,'Δημήτρης','Βούλγαρης','1970-07-12','M'),(99,'Μαρία','Βόυρου','1971-05-17','F'),(100,'Γιώργος','Αρμένης','1945-10-03','M'),(101,'Δημήτρης','Βαρβάτος','1992-11-30','M'),(102,'Γιώργος','Βιτάλης','1995-02-20','M'),(103,'Μαρία','Κουράκη','1999-04-21','F'),(104,'Δημήτρης','Κουταλιανός','1995-08-23','M'),(105,'Μαρία','Κυπραίου','1999-09-10','F');
/*!40000 ALTER TABLE `researcher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervision`
--

DROP TABLE IF EXISTS `supervision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supervision` (
  `project_id` int(11) NOT NULL,
  `researcher_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `researcher` (`researcher_id`),
  CONSTRAINT `researcher` FOREIGN KEY (`researcher_id`) REFERENCES `researcher` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `title` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervision`
--

LOCK TABLES `supervision` WRITE;
/*!40000 ALTER TABLE `supervision` DISABLE KEYS */;
-- INSERT INTO `supervision` VALUES (10,1),(20,3),(22,4),(21,17),(2,22),(4,40),(43,76),(47,77),(48,78),(50,79),(51,80),(53,82),(54,83),(55,91),(56,96);
/*!40000 ALTER TABLE `supervision` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `super` BEFORE INSERT ON `supervision` FOR EACH ROW BEGIN
IF (SELECT DISTINCT employee.organisation_id FROM -- Return true if supervisor works for other org than the project
employee NATURAL JOIN researcher
WHERE employee.researcher_id = new.researcher_id)
!= (SELECT DISTINCT admin_by_org.organisation_id FROM project INNER JOIN admin_by_org
ON project.id = admin_by_org.project_id
WHERE (project.id = new.project_id)) THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Scientific supervisor must be of same organisation as the project!';
ELSEIF (new.project_id IN (SELECT DISTINCT works_on_proj.project_id FROM
works_on_proj NATURAL JOIN researcher
WHERE works_on_proj.researcher_id = new.researcher_id)) THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Scientific supervisor must not be working on the project!';
END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `view1`
--

DROP TABLE IF EXISTS `view1`;
/*!50001 DROP VIEW IF EXISTS `view1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view1` AS SELECT 
 1 AS `name`,
 1 AS `surname`,
 1 AS `title`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view2`
--

DROP TABLE IF EXISTS `view2`;
/*!50001 DROP VIEW IF EXISTS `view2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view2` AS SELECT 
 1 AS `surname`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `works_on_proj`
--

DROP TABLE IF EXISTS `works_on_proj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `works_on_proj` (
  `project_id` int(11) NOT NULL,
  `researcher_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`,`researcher_id`),
  KEY `works_researcher_id` (`researcher_id`),
  CONSTRAINT `works_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `works_researcher_id` FOREIGN KEY (`researcher_id`) REFERENCES `researcher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on_proj`
--

LOCK TABLES `works_on_proj` WRITE;
/*!40000 ALTER TABLE `works_on_proj` DISABLE KEYS */;
-- INSERT INTO `works_on_proj` VALUES (2,1),(3,16),(4,16),(5,23),(5,24),(7,76),(7,77),(7,78),(7,79),(7,80),(8,1),(9,24),(14,25),(15,3),(15,4),(15,14),(15,29),(15,34),(15,37),(15,44),(15,54),(15,64),(15,77),(15,78),(15,79),(15,80),(15,83),(15,96),(17,3),(17,4),(17,54),(17,80),(17,82),(17,83),(17,91),(20,65),(21,16),(22,14),(22,29),(22,34),(22,76),(22,77),(22,78),(22,79),(22,80),(26,7),(26,32),(26,35),(26,36),(26,41),(26,43),(26,47),(26,48),(26,51),(26,86),(26,87),(26,88),(26,89),(26,90),(26,93),(26,97),(26,99),(26,103),(26,105),(29,54),(29,64),(29,65),(33,54),(34,37),(34,44),(34,54),(34,71),(34,76),(34,77),(34,91),(34,96),(41,36),(41,88),(41,89),(41,90),(41,93),(41,97),(41,99),(41,103),(41,105),(44,36),(44,48),(44,51),(44,55),(44,57),(44,86),(44,87),(44,88),(44,89),(44,90),(44,103),(44,105),(46,24),(50,37),(50,44),(50,54),(52,54),(56,3),(56,4),(56,34),(57,3),(57,4),(57,70),(57,71),(57,76),(57,77),(57,78),(57,79),(57,80),(57,82),(58,77),(58,78),(58,79),(58,80),(58,82);
/*!40000 ALTER TABLE `works_on_proj` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `work` BEFORE INSERT ON `works_on_proj` FOR EACH ROW BEGIN
IF (SELECT DISTINCT employee.organisation_id FROM
employee NATURAL JOIN researcher
WHERE employee.researcher_id = new.researcher_id)
!= (SELECT DISTINCT admin_by_org.organisation_id FROM project INNER JOIN admin_by_org
ON project.id = admin_by_org.project_id
WHERE (project.id = new.project_id)) THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'Wrong organisation!';
ELSEIF (new.project_id IN (SELECT DISTINCT supervision.project_id FROM
supervision NATURAL JOIN researcher
WHERE supervision.researcher_id = new.researcher_id)) THEN
SIGNAL SQLSTATE '45000'   
SET MESSAGE_TEXT = 'The researcher is the supervisor of this project!';
END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'my_base'
--

--
-- Dumping routines for database 'my_base'
--
/*!50003 DROP PROCEDURE IF EXISTS `query3_4` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query3_4`()
BEGIN
SET @year = 1900;
SET @temp_id = 0;
SET @prev = 0;
SET @curr = 0;
WHILE @temp_id <= /*MAX(admin_by_org.organisation_id)*/50 DO
    SET @year = 1900;
    WHILE @year < 2300 DO
        SET @curr = (SELECT COUNT(*) FROM admin_by_org INNER JOIN project
        WHERE (admin_by_org.organisation_id = @temp_id AND project.id = admin_by_org.project_id AND YEAR(project.start) = @year));
        IF (@curr > 9 AND @curr = @prev) THEN
            INSERT INTO org (id) VALUES (@temp_id);
            SET @year = 2300;
		END IF;
        SET @prev = @curr;
        SET @year = @year + 1;
	END WHILE;
    SET @temp_id = @temp_id + 1;
END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query3_6` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query3_6`()
BEGIN
SET @id1 = 0;
SET @id2 = 0;
SET @id3 = 0;
SET @max1 = 0;
SET @max2 = 0;
SET @max3 = 0;
SET @temp_id = 0;
SET @curr = 0;
WHILE @temp_id < 150 DO
    SET @curr = (SELECT COUNT(*) FROM researcher AS r INNER JOIN works_on_proj AS w
    INNER JOIN project AS p
    WHERE (DATEDIFF(NOW(),r.birthdate) < 40*356 + 10 AND r.id = @temp_id
    AND r.id = w.researcher_id AND p.id = w.project_id AND
    p.start < NOW() AND p.end > NOW()));
	IF (@curr >= @max1 AND @curr > 0) THEN -- Move all max and id's down
		SET @max3 = @max2;
        SET @max2 = @max1;
        SET @max1 = @curr;
        SET @id3 = @id2;
        SET @id2 = @id1;
        SET @id1 = @temp_id;
        INSERT INTO temp (id, counter) VALUES (@temp_id, @curr);
	END IF;
    SET @temp_id = @temp_id + 1;
END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query3_7` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query3_7`()
BEGIN
SET @temp_exec_id = 0;
SET @temp_comp_id = 0;
SET @curr = 0;
WHILE @temp_exec_id < 150 DO -- For each executive
    WHILE @temp_comp_id < 150 DO -- For each company
        WHILE (SELECT o.category FROM organisation AS o
        WHERE o.id = @temp_comp_id) != 'Εταιρία' DO
            -- Not company, go next
            SET @temp_comp_id = @temp_comp_id + 1;
            END WHILE;
		-- Next statement sums all money given by exec
        -- @temp_exec_id to the company @temp_comp_id
		SET @curr = (SELECT SUM(p.budget) FROM admin_by_exec AS a
        INNER JOIN project AS p INNER JOIN executive AS e
        INNER JOIN organisation AS o INNER JOIN admin_by_org AS b
        WHERE e.id = @temp_exec_id AND e.id = a.exec_id AND
        a.project_id = p.id AND b.project_id = p.id AND
        b.organisation_id = o.id AND o.id = @temp_comp_id);
        IF @curr > 0 THEN
            -- SELECT "Here!";
            INSERT INTO temp7 (id, company_id, money)
            VALUES (@temp_exec_id, @temp_comp_id, @curr);
		END IF;
        SET @curr = 0;
        SET @temp_comp_id = @temp_comp_id + 1;
	END WHILE; -- Checked all companies for this exec
    SET @temp_exec_id = @temp_exec_id + 1; -- Next exec
    SET @temp_comp_id = 0; -- Must reset this
END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query3_8` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query3_8`()
BEGIN
SET @temp_res_id = 0;
SET @temp_pro_id = 0;
SET @curr = 0;
SET @temp = 0;
WHILE @temp_res_id < 150 DO -- For each researcher
    WHILE @temp_pro_id < 150 DO -- For each project
        WHILE (SELECT COUNT(*) FROM deliverable AS d -- TODO check for deliverables
        WHERE d.project_id = @temp_pro_id) != 0 DO
            -- Not zero deliverables, go next
            SET @temp_pro_id = @temp_pro_id + 1;
            END WHILE;
		-- Next statement sums all money given by exec
        -- @temp_exec_id to the company @temp_comp_id
		/*This subquery useless, researcher either works or does not
        SET @temp = (SELECT COUNT(*) FROM project AS p INNER JOIN
        researcher AS r INNER JOIN works_on_proj AS w
        WHERE r.id = @temp_res_id AND r.id = w.researcher_id AND
        w.project_id = p.id AND p.id = @temp_pro_id);*/
        IF (SELECT COUNT(*) FROM researcher AS r INNER JOIN
        works_on_proj AS w INNER JOIN project AS p WHERE
        r.id = @temp_res_id AND r.id = w.researcher_id AND
        w.project_id = p.id AND p.id = @temp_pro_id) != 0 THEN
            SET @temp = @temp + 1;
		END IF;
        SET @temp_pro_id = @temp_pro_id + 1;
	END WHILE; -- Checked all projects for this res
    -- Are they more than 5?
    IF @temp > 4 THEN
        INSERT INTO temp8 (id, counter)
		VALUES (@temp_res_id, @temp);
	END IF;
    SET @temp_res_id = @temp_res_id + 1; -- Next res
    SET @temp_pro_id = 0; -- Must reset this
    SET @temp = 0; -- Must reset this
END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view1`
--

/*!50001 DROP VIEW IF EXISTS `view1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view1` AS select distinct `r`.`name` AS `name`,`r`.`surname` AS `surname`,`p`.`title` AS `title` from (((`researcher` `r` join `project` `p`) join `works_on_proj` `w`) join `supervision` `s`) where `r`.`id` = `w`.`researcher_id` and `p`.`id` = `w`.`project_id` or `r`.`id` = `s`.`researcher_id` and `p`.`id` = `s`.`project_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view2`
--

/*!50001 DROP VIEW IF EXISTS `view2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view2` AS select distinct `executive`.`surname` AS `surname`,`program`.`name` AS `name` from ((((`executive` join `project`) join `admin_by_exec`) join `program`) join `financing`) where `executive`.`id` = `admin_by_exec`.`exec_id` and `admin_by_exec`.`project_id` = `project`.`id` and `project`.`id` = `financing`.`project_id` and `financing`.`program_id` = `program`.`id` */;
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

-- Dump completed on 2022-06-05 13:05:33
