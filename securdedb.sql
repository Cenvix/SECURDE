-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: securde
-- ------------------------------------------------------
-- Server version	5.6.26-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `idbooks` varchar(45) NOT NULL,
  `bookname` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `publisher` varchar(45) NOT NULL,
  `year` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idbooks`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('1234','The Hunger Games','Suzanne Collins','Scholastic Corporation','2018','Available','The Hunger Games is written in the voice of 16-year-old Katniss Everdeen, who lives in the future, post-apocalyptic nation of Panem in North America.'),('813/.54','A Game of Thrones','George R.R. Martin','Bantam Spectra','1996','Available','A Game of Thrones is the first novel in A Song of Ice and Fire, a series of fantasy novels by American author George R. R. Martin.'),('813/.54.21','A Storm of Swords','George R.R. Martin ','Bantam Spectra','2000','Available','A Storm of Swords is the third of seven planned novels in A Song of Ice and Fire, a fantasy series by American author George R. R. Martin. '),('813/.55','A Clash of Kings','George R.R. Martin ','Bantam Spectra','1998','Available','A Clash of Kings depicts the Seven Kingdoms of Westeros in civil war, while the Night\'s Watch mounts a reconnaissance to investigate the mysterious people known as wildlings. Meanwhile, Daenerys Targaryen continues her plan to reconquer the Seven Kingdoms.'),('902/.22','Life of Pi','Yann Martel','Knopf Canada','2001','Available','The protagonist is Piscine Molitor \"Pi\" Patel, an Indian boy from Pondicherry who survives 227 days after a shipwreck while stranded on a lifeboat in the Pacific Ocean with a Bengal tiger named Richard Parker.');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetingroombooking`
--

DROP TABLE IF EXISTS `meetingroombooking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meetingroombooking` (
  `idmeetingroombooking` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `timestart` datetime NOT NULL,
  `timeend` datetime NOT NULL,
  PRIMARY KEY (`idmeetingroombooking`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetingroombooking`
--

LOCK TABLES `meetingroombooking` WRITE;
/*!40000 ALTER TABLE `meetingroombooking` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetingroombooking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `idtags` int(11) NOT NULL,
  `idbooks` int(11) NOT NULL,
  `tag` varchar(45) NOT NULL,
  PRIMARY KEY (`idtags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temporarypasswords`
--

DROP TABLE IF EXISTS `temporarypasswords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temporarypasswords` (
  `idtemporarypasswords` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `temppassword` varchar(45) NOT NULL,
  `expiredate` datetime NOT NULL,
  PRIMARY KEY (`idtemporarypasswords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temporarypasswords`
--

LOCK TABLES `temporarypasswords` WRITE;
/*!40000 ALTER TABLE `temporarypasswords` DISABLE KEYS */;
/*!40000 ALTER TABLE `temporarypasswords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `idtransactions` int(11) NOT NULL,
  `idbook` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `borrowdate` date NOT NULL,
  `returndate` date NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`idtransactions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `idusers` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) DEFAULT NULL,
  `middlename` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `emailaddress` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `usernumber` varchar(45) DEFAULT NULL,
  `usertype` varchar(45) NOT NULL DEFAULT 'student',
  `secretquestion` varchar(45) DEFAULT NULL,
  `secretanswer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idusers`)
) ENGINE=InnoDB AUTO_INCREMENT=64947637 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (19549432,NULL,NULL,NULL,'dhiren@gmail.com','dhirendhanani',NULL,'student',NULL,NULL),(64947636,NULL,NULL,NULL,'dhirennn@gmail.com','zxcvbnmasd',NULL,'student',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-05 21:53:49
