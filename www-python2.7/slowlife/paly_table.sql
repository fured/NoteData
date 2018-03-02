-- MySQL dump 10.13  Distrib 5.6.27, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: slowlife
-- ------------------------------------------------------
-- Server version	5.6.27

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
-- Table structure for table `play_music_table`
--

DROP TABLE IF EXISTS `play_music_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `play_music_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `song_name` varchar(50) NOT NULL,
  `songer_name` varchar(50) NOT NULL,
  `song_image_path` varchar(100) NOT NULL,
  `storage_path` varchar(100) NOT NULL,
  `song_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_path` (`storage_path`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `play_music_table`
--

LOCK TABLES `play_music_table` WRITE;
/*!40000 ALTER TABLE `play_music_table` DISABLE KEYS */;
INSERT INTO `play_music_table` VALUES (6,'Red','Taylor Swift','/static/images/music/Red.jpg','/static/music/Red.mp3','R＆B'),(11,'Starlight','Taylor Swift','/static/images/music/Starlight.jpg','/static/music/Starlight.mp3','R＆B'),(13,'Stay Stay Stay','Taylor Swift','/static/images/music/Stay Stay Stay.jpg','/static/music/Stay Stay Stay.mp3','R＆B'),(15,'Begin Again','Taylor Swift','/static/images/music/Begin Again.jpg','/static/music/Begin Again.mp3','R&B'),(16,'I Almost Do','Taylor Swift','/static/images/music/I Almost Do.jpg','/static/music/I Almost Do.mp3','R＆B'),(17,'22','Taylor Swift','/static/images/music/22.jpg','/static/music/22.mp3','R＆B'),(18,'Girl At Home','Taylor Swift','/static/images/music/Girl At Home.jpg','/static/music/Girl At Home.mp3','R＆B'),(21,'I Lay My Love On You','WESTLIFE','/static/images/head.png','/static/music/I Lay My Love On You.mp3','blue'),(22,'The Sound Of Silence','Paul Simon','/static/images/music/The Sound Of Silence.jpg','/static/music/The Sound Of Silence.mp3','blue'),(24,'不要说话','陈奕迅','/static/images/music/不要说话.jpg','/static/music/不要说话.mp3','rhy'),(25,'勇敢爱','Mi2','/static/images/music/勇敢爱.jpg','/static/music/勇敢爱.mp3','blue'),(26,'F.L - 你看到那遥远的星空了吗','F.L','/static/images/head.png','/static/music/FL - 你看到那遥远的星空了吗.mp3','blue'),(27,'今夜你会不会来','黎明','/static/images/head.png','/static/music/今夜你会不会来.mp3','rhy'),(28,'我不愿让你一个人','五月天','/static/images/music/我不愿让你一个人.jpg','/static/music/我不愿让你一个人.mp3','Rock'),(29,'给我一首歌的时间','周杰伦','/static/images/head.png','/static/music/给我一首歌的时间.mp3','R＆B'),(30,'I Am You','Kim Taylor','/static/images/head.png','/static/music/I Am You.mp3','blue');
/*!40000 ALTER TABLE `play_music_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-02 20:17:08
