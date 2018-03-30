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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add recommend music table',7,'add_recommendmusictable'),(20,'Can change recommend music table',7,'change_recommendmusictable'),(21,'Can delete recommend music table',7,'delete_recommendmusictable'),(22,'Can add share moive table',8,'add_sharemoivetable'),(23,'Can change share moive table',8,'change_sharemoivetable'),(24,'Can delete share moive table',8,'delete_sharemoivetable'),(25,'Can add comment table',9,'add_commenttable'),(26,'Can change comment table',9,'change_commenttable'),(27,'Can delete comment table',9,'delete_commenttable'),(28,'Can add book table',10,'add_booktable'),(29,'Can change book table',10,'change_booktable'),(30,'Can delete book table',10,'delete_booktable'),(31,'Can add play music table',11,'add_playmusictable'),(32,'Can change play music table',11,'change_playmusictable'),(33,'Can delete play music table',11,'delete_playmusictable'),(34,'Can add django content type',12,'add_djangocontenttype'),(35,'Can change django content type',12,'change_djangocontenttype'),(36,'Can delete django content type',12,'delete_djangocontenttype'),(37,'Can add django migrations',13,'add_djangomigrations'),(38,'Can change django migrations',13,'change_djangomigrations'),(39,'Can delete django migrations',13,'delete_djangomigrations');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$Qa0W50C55Inv$66oT6DKq6pqMgFZV2d0nrC6RjvfJta8A4WIuMCuLP/k=','2018-03-07 01:25:03.150551',1,'fured','','','2441742075@qq.com',1,1,'2018-02-13 08:36:48.503081');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_table`
--

DROP TABLE IF EXISTS `book_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(50) NOT NULL,
  `author_name` varchar(50) NOT NULL,
  `author_contry` varchar(50) NOT NULL,
  `book_type` varchar(50) NOT NULL,
  `book_image_path` varchar(100) NOT NULL,
  `book_download_url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_table`
--

LOCK TABLES `book_table` WRITE;
/*!40000 ALTER TABLE `book_table` DISABLE KEYS */;
INSERT INTO `book_table` VALUES (1,'The Dog Of Babel','Carolyn-Parkhurst','America','novel','/static/images/book/thedogofbabel.jpg','https://pan.baidu.com/s/1o9uJxMU'),(2,'Man Som Hatar Kvinnor','Stieg Larsson','Sweden','novel','/static/images/book/mansonhatarkvinnor.jpg','https://pan.baidu.com/s/1o9uJxMU'),(3,'Norwegian Wood','村上春树','Japan','novel','/static/images/book/norweiganwood.jpg','https://pan.baidu.com/s/1o9uJxMU'),(4,'The Kite Runner','Khaled Hosseini','Afghanistan','novel','/static/images/book/thekiterunner.jpg','https://pan.baidu.com/s/1o9uJxMU'),(5,'The Godfather','Mario Puzo','Ameria','novel','/static/images/book/thegodfather.jpg','https://pan.baidu.com/s/1o9uJxMU');
/*!40000 ALTER TABLE `book_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_movie_table`
--

DROP TABLE IF EXISTS `comment_movie_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_movie_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL COMMENT 'people who publish comment',
  `content` varchar(300) NOT NULL,
  `user_img_path` varchar(100) NOT NULL,
  `user_address` varchar(100) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BeReplyName` varchar(50) DEFAULT NULL COMMENT 'who be replay use the comment这条评论是用来回复谁的',
  `OSName` varchar(50) DEFAULT 'windows',
  `BrowerName` varchar(50) DEFAULT 'google',
  `ReplyBody` varchar(50) DEFAULT NULL COMMENT 'this is some comment that be used to replay the comment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_movie_table`
--

LOCK TABLES `comment_movie_table` WRITE;
/*!40000 ALTER TABLE `comment_movie_table` DISABLE KEYS */;
INSERT INTO `comment_movie_table` VALUES (1,'test','wqeqweqwed','/static/img.jpg','default','2018-03-23 09:41:46',NULL,'windows','google',NULL),(2,'test2','this movie is very nice!','/static/img.jpg','default','2018-03-23 09:43:12',NULL,'windows','google',NULL),(3,'fured','同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。','/static/img.jpg','default','2018-03-23 09:44:50',NULL,'windows','google',NULL),(4,'fured','同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。','/static/img.jpg','default','2018-03-23 09:50:18',NULL,'windows','google',NULL),(5,'fured','同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。','/static/img.jpg','default','2018-03-23 09:53:15',NULL,'windows','google',NULL),(6,'fured','同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。','/static/img.jpg','default','2018-03-23 09:53:34',NULL,'windows','google',NULL),(7,'fured','同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。','/static/img.jpg','default','2018-03-23 10:07:54',NULL,'windows','google',NULL),(8,'fured','同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。','/static/img.jpg','default','2018-03-26 01:19:44',NULL,'windows','google',NULL);
/*!40000 ALTER TABLE `comment_movie_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_table`
--

DROP TABLE IF EXISTS `comment_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_name` varchar(50) NOT NULL,
  `comment_email` varchar(50) NOT NULL,
  `comment_message` varchar(500) NOT NULL,
  `create_at` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_table`
--

LOCK TABLES `comment_table` WRITE;
/*!40000 ALTER TABLE `comment_table` DISABLE KEYS */;
INSERT INTO `comment_table` VALUES (1,'fured','2441742075@qq.com','test',1519436747),(2,'bob','hawksjhd@fured.com','test2',1519448685),(3,'tom','hawksjhd@126.com','test3',1519449961),(4,'123','hasfuhyeui@qq.com','test4',1519472277),(5,'123','hasfuhyeui@qq.com','test4',1519473062),(6,'123','hasfuhyeui@qq.com','test4',1519473098),(7,'test','test@fured.com','asduifuencshuhui',1519788030);
/*!40000 ALTER TABLE `comment_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-03-02 10:09:47.063792','30','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(2,'2018-03-02 10:10:37.213525','29','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(3,'2018-03-02 10:10:53.214859','28','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(4,'2018-03-02 10:11:09.564775','27','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(5,'2018-03-02 10:11:26.773322','6','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(6,'2018-03-02 10:11:35.302792','11','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(7,'2018-03-02 10:11:45.181456','13','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(8,'2018-03-02 10:11:59.028204','16','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(9,'2018-03-02 10:12:14.338129','17','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(10,'2018-03-02 10:12:27.682941','18','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(11,'2018-03-02 10:12:42.965649','26','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(12,'2018-03-02 10:13:17.617263','25','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(13,'2018-03-02 10:13:29.635524','24','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(14,'2018-03-02 10:13:38.586364','21','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(15,'2018-03-02 10:13:55.490349','22','PlayMusicTable object',2,'[{\"changed\": {\"fields\": [\"song_type\"]}}]',11,1),(16,'2018-03-07 01:25:39.226443','5','BookTable object',2,'[{\"changed\": {\"fields\": [\"book_name\"]}}]',10,1),(17,'2018-03-07 01:28:46.215301','5','BookTable object',2,'[{\"changed\": {\"fields\": [\"book_name\"]}}]',10,1),(18,'2018-03-07 01:32:11.357051','5','BookTable object',2,'[{\"changed\": {\"fields\": [\"author_name\", \"author_contry\"]}}]',10,1),(19,'2018-03-07 01:36:53.337252','3','BookTable object',2,'[{\"changed\": {\"fields\": [\"book_name\", \"author_name\"]}}]',10,1),(20,'2018-03-07 05:27:09.859520','5','BookTable object',2,'[{\"changed\": {\"fields\": [\"book_image_path\"]}}]',10,1),(21,'2018-03-07 05:28:25.074255','3','BookTable object',2,'[{\"changed\": {\"fields\": [\"book_image_path\"]}}]',10,1),(22,'2018-03-07 06:06:29.192775','31','PlayMusicTable object',1,'[{\"added\": {}}]',11,1),(23,'2018-03-07 09:51:45.440642','32','PlayMusicTable object',1,'[{\"added\": {}}]',11,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(10,'fured','booktable'),(9,'fured','commenttable'),(12,'fured','djangocontenttype'),(13,'fured','djangomigrations'),(11,'fured','playmusictable'),(7,'fured','recommendmusictable'),(8,'fured','sharemoivetable'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-02-13 08:34:12.776343'),(2,'auth','0001_initial','2018-02-13 08:34:23.616012'),(3,'admin','0001_initial','2018-02-13 08:34:25.884330'),(4,'admin','0002_logentry_remove_auto_add','2018-02-13 08:34:26.136094'),(5,'contenttypes','0002_remove_content_type_name','2018-02-13 08:34:27.486562'),(6,'auth','0002_alter_permission_name_max_length','2018-02-13 08:34:28.399496'),(7,'auth','0003_alter_user_email_max_length','2018-02-13 08:34:29.244605'),(8,'auth','0004_alter_user_username_opts','2018-02-13 08:34:29.325446'),(9,'auth','0005_alter_user_last_login_null','2018-02-13 08:34:30.024811'),(10,'auth','0006_require_contenttypes_0002','2018-02-13 08:34:30.075102'),(11,'auth','0007_alter_validators_add_error_messages','2018-02-13 08:34:30.140837'),(12,'auth','0008_alter_user_username_max_length','2018-02-13 08:34:32.084121'),(13,'fured','0001_initial','2018-02-13 08:34:32.470042'),(14,'fured','0002_auto_20180213_0833','2018-02-13 08:34:32.686359'),(15,'sessions','0001_initial','2018-02-13 08:34:33.390029');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('39aw5iy3qm82g01j83jbrdw6aw6aqpi8','ZGZlZjYxZmYwMDExZmNiMzVkOTdmMTAzODVkMDAwMDBiMmE4NGYxNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjgyZWI0MDk4MjY3NTRmOGM2OWFjNmU0NzIxNzBkOWUyMWJmYmIxOTQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-02-27 08:42:18.258443'),('8e1vlzz07o5aqyxr87tkstyymamav015','ZGZlZjYxZmYwMDExZmNiMzVkOTdmMTAzODVkMDAwMDBiMmE4NGYxNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjgyZWI0MDk4MjY3NTRmOGM2OWFjNmU0NzIxNzBkOWUyMWJmYmIxOTQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-03-13 09:52:09.607494'),('drzhjxpviy1uy8i79jp22srcc6fjkuxj','ZGZlZjYxZmYwMDExZmNiMzVkOTdmMTAzODVkMDAwMDBiMmE4NGYxNzp7Il9hdXRoX3VzZXJfaGFzaCI6IjgyZWI0MDk4MjY3NTRmOGM2OWFjNmU0NzIxNzBkOWUyMWJmYmIxOTQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-03-21 01:25:03.201175');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

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
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_path` (`storage_path`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `play_music_table`
--

LOCK TABLES `play_music_table` WRITE;
/*!40000 ALTER TABLE `play_music_table` DISABLE KEYS */;
INSERT INTO `play_music_table` VALUES (6,'Red','Taylor Swift','/static/images/music/Red.jpg','/static/music/Red.mp3','R＆B','2018-03-07 09:20:21'),(11,'Starlight','Taylor Swift','/static/images/music/Starlight.jpg','/static/music/Starlight.mp3','R＆B','2018-03-07 09:20:21'),(13,'Stay Stay Stay','Taylor Swift','/static/images/music/Stay Stay Stay.jpg','/static/music/Stay Stay Stay.mp3','R＆B','2018-03-07 09:20:21'),(15,'Begin Again','Taylor Swift','/static/images/music/Begin Again.jpg','/static/music/Begin Again.mp3','R&B','2018-03-07 09:20:21'),(16,'I Almost Do','Taylor Swift','/static/images/music/I Almost Do.jpg','/static/music/I Almost Do.mp3','R＆B','2018-03-07 09:20:21'),(17,'22','Taylor Swift','/static/images/music/22.jpg','/static/music/22.mp3','R＆B','2018-03-07 09:20:21'),(18,'Girl At Home','Taylor Swift','/static/images/music/Girl At Home.jpg','/static/music/Girl At Home.mp3','R＆B','2018-03-07 09:20:21'),(21,'I Lay My Love On You','WESTLIFE','/static/images/head.png','/static/music/I Lay My Love On You.mp3','blue','2018-03-07 09:20:21'),(22,'The Sound Of Silence','Paul Simon','/static/images/music/The Sound Of Silence.jpg','/static/music/The Sound Of Silence.mp3','blue','2018-03-07 09:20:21'),(24,'不要说话','陈奕迅','/static/images/music/不要说话.jpg','/static/music/不要说话.mp3','rhy','2018-03-07 09:20:21'),(25,'勇敢爱','Mi2','/static/images/music/勇敢爱.jpg','/static/music/勇敢爱.mp3','blue','2018-03-07 09:20:21'),(26,'F.L - 你看到那遥远的星空了吗','F.L','/static/images/head.png','/static/music/FL - 你看到那遥远的星空了吗.mp3','blue','2018-03-07 09:20:21'),(27,'今夜你会不会来','黎明','/static/images/head.png','/static/music/今夜你会不会来.mp3','rhy','2018-03-07 09:20:21'),(28,'我不愿让你一个人','五月天','/static/images/music/我不愿让你一个人.jpg','/static/music/我不愿让你一个人.mp3','Rock','2018-03-07 09:20:21'),(29,'给我一首歌的时间','周杰伦','/static/images/head.png','/static/music/给我一首歌的时间.mp3','R＆B','2018-03-07 09:20:21'),(30,'I Am You','Kim Taylor','/static/images/head.png','/static/music/I Am You.mp3','blue','2018-03-07 09:20:21'),(31,'当我想你的时候','汪峰','/static/images/head.png','/static/music/当我想你的时候.mp3','slow rock','2018-03-07 09:20:21'),(32,'test','test','test','test','test','2018-03-07 09:51:45');
/*!40000 ALTER TABLE `play_music_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommend_music_table`
--

DROP TABLE IF EXISTS `recommend_music_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recommend_music_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `song_name` varchar(50) NOT NULL,
  `song_type` varchar(50) NOT NULL,
  `recommend_name` varchar(50) NOT NULL,
  `recommend_reason` varchar(500) NOT NULL,
  `create_at` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommend_music_table`
--

LOCK TABLES `recommend_music_table` WRITE;
/*!40000 ALTER TABLE `recommend_music_table` DISABLE KEYS */;
INSERT INTO `recommend_music_table` VALUES (1,'谢谢侬','General Question','fured','very nice!',1519357560),(2,'red','don\'t know','fured','very nice!',1519357862),(3,'stay stay','Blue','cute','好听',1519472336),(4,'I Am You','blue','postman','very nice!',1519897988),(5,'I Am You','blue','postman','very nice!',1519898413),(6,'I Am You','blue','postman','very nice!',1519898483),(7,'醉赤壁','R&B','fured','好听',1520212297),(8,'父亲写的散文诗','Blue','fured','好听',1520212705),(9,'test','Rock','hsakd','tes',1520245202),(10,'askdghujasdf','Blue','tets','sadfer',1520245521),(11,'wef','Rock','asf','wfe',1520245557);
/*!40000 ALTER TABLE `recommend_music_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `share_moive_table`
--

DROP TABLE IF EXISTS `share_moive_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_moive_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moive_name` varchar(50) NOT NULL,
  `share_reason` varchar(500) NOT NULL,
  `moive_download_url` varchar(200) NOT NULL,
  `moive_image_path` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `share_moive_table`
--

LOCK TABLES `share_moive_table` WRITE;
/*!40000 ALTER TABLE `share_moive_table` DISABLE KEYS */;
INSERT INTO `share_moive_table` VALUES (1,'The Master','在徐之前，虽然我们看了多年的中国功夫片，前有李小龙的完美打斗，后有成龙李连杰式的全新港台武打。','https://pan.baidu.com/s/1gfTnwnp','/static/images/moive/themaster.jpg'),(2,'Farewell My Concubine','影片围绕两位京剧伶人半个世纪的悲欢离合，展现了对传统文化、人的生存状态及人性的思考与领悟。','https://pan.baidu.com/s/1gfTnwnp','/static/images/moive/farewellmyconcubine.jpg'),(3,'The Shawshank Redemption','全片透过监狱这一强制剥夺自由、高度强调纪律的特殊背景来展现作为个体的人对“时间流逝、环境改造”的恐惧。','https://pan.baidu.com/s/1gfTnwnp','/static/images/moive/theshawshankRedemption.jpg'),(4,'Brotherhood of Blades','该片讲述了明末崇祯年间，锦衣卫三兄弟奉命追杀魏忠贤，最后却卷入到一场宫廷阴谋当中的充满悬疑的故事。','https://pan.baidu.com/s/1gfTnwnp','/static/images/moive/brotherhoodofblades.jpg');
/*!40000 ALTER TABLE `share_moive_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_table`
--

DROP TABLE IF EXISTS `user_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(50) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_table`
--

LOCK TABLES `user_table` WRITE;
/*!40000 ALTER TABLE `user_table` DISABLE KEYS */;
INSERT INTO `user_table` VALUES (2,'test','test@fured.com','7c222fb2927d828af22f592134e8932480637c0d','2018-03-13 01:37:33'),(3,'test2','test2@fured.com','7c222fb2927d828af22f592134e8932480637c0d','2018-03-13 01:37:58'),(4,'fured','fured@slowlife.com','7c222fb2927d828af22f592134e8932480637c0d','2018-03-23 09:44:31');
/*!40000 ALTER TABLE `user_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-28  9:22:56
