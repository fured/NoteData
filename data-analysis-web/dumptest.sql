-- MySQL dump 10.13  Distrib 5.6.27, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: testdb
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
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blogs` (
  `id` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_image` varchar(500) NOT NULL,
  `name` varchar(50) NOT NULL,
  `summary` varchar(200) NOT NULL,
  `content` mediumtext NOT NULL,
  `created_at` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES ('001511489648893d206fd8459ba4136a157a4bd60cb5101000','0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm','/static/img/imagetest.png','闲来无事','诗经 静女','静女其殊\n俟我于城隅\n爱而不见',1511489648.89374),('001511490405350271222d896fd4d9780cf16315501bece000','0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm','/static/img/imagetest.png','the second blog','仓央嘉措','住进布达拉宫\n我是雪域最大的王',1511490405.35049),('001511492078245a7e285f9d9b14f05a535c690283867ef000','0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm','/static/img/imagetest.png','test','测试一下','不知道问题出在那里',1511492078.24504),('001511493249743bf8f883bad8143b09f69284204c59543000','0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm','/static/img/imagetest.png','wwqq','wq','asdfgghhgjtbwrgdfs',1511493249.74355),('00151150143256651d8abf97d1448f5a73c5babba9cedd9000','0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm','/static/img/imagetest.png','sdkjfoiejriojf','sdfreq','sadfgrwege',1511501432.56681),('001511522213423be5e0f63d5194af1a8c2cdabb0b23b83000','0015115220836490d1c411909414e36a746c2807a1b8bdd000','dog','/static/img/dog.jpeg','第一次写blog','不知道写什么','随便写点把！终于把这个用于写网络爬虫的test-web写完了！',1511522213.42373);
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` varchar(50) NOT NULL,
  `blog_id` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_image` varchar(500) NOT NULL,
  `content` mediumtext NOT NULL,
  `created_at` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES ('001511500957781630bb9f0514c4ea5a0900805272fa1b3000','001511493249743bf8f883bad8143b09f69284204c59543000','0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm','/static/img/imagetest.png','还可以吧 ！',1511500957.78116),('0015115030054981c789d64e4124277832528e77e31479f000','001511489648893d206fd8459ba4136a157a4bd60cb5101000','0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm','/static/img/imagetest.png','不行',1511503005.49832),('001511506373976bcb7372d156f4acaa82bd04db1450342000','001511489648893d206fd8459ba4136a157a4bd60cb5101000','0015115063172445ff0626053d5426485fbfcdd103b78ab000','toom','/static/img/imagetest.png','美好的爱情',1511506373.97667),('001511522135654a752a3d5f6494b0c9387de89906a03fd000','001511489648893d206fd8459ba4136a157a4bd60cb5101000','0015115220836490d1c411909414e36a746c2807a1b8bdd000','dog','/static/img/dog.jpeg','作为单身狗，没什么好说的！',1511522135.65446);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(500) NOT NULL,
  `created_at` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_email` (`email`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('001511252441641e5a6a6158da94ed39fd9d9fc33336562000','ffff@text.com','f798ba16755ec89d4680069a086c22f2a9e55839',0,'ffff','/static/img/imagetest.png',1511252441.64183),('001511487964270268d6315a58c43c3b8298275fa14f23b000','qwert@test.com','4a3e45c342ffbe56eaf8f7a397fb74df4d9f532d',0,'qwert','/static/img/imagetest.png',1511487964.27102),('00151148857571027155ad1d23c433683d4555d10c87f9f000','asdf@test.com','3e5f6ee619d101b8074c985a0cdc634382df299a',0,'asdf','/static/img/imagetest.png',1511488575.71088),('0015114886924282220d30a26ea48bc9a1dfa0abd8b5236000','mmmm@test.com','857e0341a42f9886ae3a44e8712093b81c2cab98',0,'mmmm','/static/img/imagetest.png',1511488692.42852),('0015115063172445ff0626053d5426485fbfcdd103b78ab000','toom@test.com','d6cee9d4ceb9fa0b06ccaea886fe2b44d1d4f9a5',0,'toom','/static/img/imagetest.png',1511506317.24421),('0015115125272508f059f05ab33466e97fc1404d99aa464000','bob@test.com','d80d9e0fb8efb2fdfcef029090c4636068b70c93',0,'bob','/static/img/imagetest.png',1511512527.25078),('0015115126635618e10590419534e908963c5b6e2f6e793000','fat@test.com','3ce583cd32d9f3d3ee77d1af654b2f0ddd21c0ae',0,'fat','/static/img/imagetest.png',1511512663.56196),('001511514120715fdf21e1a9b9942a8b9a5828263afb735000','798@test.com','859bdd5f84d4e3aa727a7c70d3e777cc069d91d7',0,'798','/static/img/imagetest.png',1511514120.71576),('0015115176362037ab456e32e2749c7a478c11cb8c1bcf4000','wolf@test.com','9b42a18c65abf027a78ed6759f9413c0e6f798d2',0,'wolf','/static/img/imagetest.png',1511517636.20336),('001511517971011afda83c1b583465b8377f2973ddd1014000','wode@test.com','5c5513a1624c4998c4633364fd9102c1187d5797',0,'wode','/static/img/imagetest.png',1511517971.01205),('0015115183604775ed773f84dcc4bebb627c2c6c4d8c7e2000','zuile@test.com','52839debac35da0efa70eca445ca8f6e3afad26b',0,'zuile','/static/img/imagetest.png',1511518360.47739),('0015115195582210e282a7dffac426588b5d8040c1e97a7000','imagetest@test.com','5c14e9f807933b26b97901e1d8a6a146d66ddf5b',0,'imagetest','/static/img/imagetest.png',1511519558.22144),('0015115220836490d1c411909414e36a746c2807a1b8bdd000','dog@test.com','67568f12e45b76880de7c55041e07c45a5728ed5',0,'dog','/static/img/dog.jpeg',1511522083.64967);
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

-- Dump completed on 2017-11-24 19:21:31
