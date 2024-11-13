/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ecofix_portal_db3
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ChatMessage`
--

DROP TABLE IF EXISTS `ChatMessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ChatMessage` (
  `message_id` int(11) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `message_text` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`message_id`),
  KEY `session_id` (`session_id`),
  KEY `sender_id` (`sender_id`),
  CONSTRAINT `ChatMessage_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `ChatSession` (`session_id`),
  CONSTRAINT `ChatMessage_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ChatMessage`
--

LOCK TABLES `ChatMessage` WRITE;
/*!40000 ALTER TABLE `ChatMessage` DISABLE KEYS */;
INSERT INTO `ChatMessage` VALUES
(1,1,1,'I am unable to log in to my account','2024-11-01 10:21:00'),
(2,1,2,'I can help with that. Let me check your details.','2024-11-01 10:22:00'),
(3,2,3,'My payment failed, and I don’t know why.','2024-11-02 14:36:00'),
(4,2,2,'I’ll look into it right away. Please hold.','2024-11-02 14:37:00'),
(5,3,1,'My account got locked. Can you assist?','2024-11-03 09:51:00'),
(6,3,4,'Yes, I’ll unlock it for you now.','2024-11-03 09:52:00');
/*!40000 ALTER TABLE `ChatMessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ChatSession`
--

DROP TABLE IF EXISTS `ChatSession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ChatSession` (
  `session_id` int(11) NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `client_id` (`client_id`),
  KEY `agent_id` (`agent_id`),
  CONSTRAINT `ChatSession_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `ChatSession_ibfk_2` FOREIGN KEY (`agent_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ChatSession`
--

LOCK TABLES `ChatSession` WRITE;
/*!40000 ALTER TABLE `ChatSession` DISABLE KEYS */;
INSERT INTO `ChatSession` VALUES
(1,1,2,'2024-11-01 10:20:00','2024-11-01 10:40:00'),
(2,3,2,'2024-11-02 14:35:00','2024-11-02 15:05:00'),
(3,1,4,'2024-11-03 09:50:00','2024-11-03 10:10:00');
/*!40000 ALTER TABLE `ChatSession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SupportTicket`
--

DROP TABLE IF EXISTS `SupportTicket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SupportTicket` (
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `subject` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `status` enum('Open','In progress','Closed') NOT NULL,
  `priority` enum('Low','Medium','High') NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `SupportTicket_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SupportTicket`
--

LOCK TABLES `SupportTicket` WRITE;
/*!40000 ALTER TABLE `SupportTicket` DISABLE KEYS */;
INSERT INTO `SupportTicket` VALUES
(1,1,'Login Issue','Cannot log in to the portal','Technical','Open','High','2024-11-01 10:15:00','2024-11-01 10:15:00'),
(2,3,'Payment Issue','Failed transaction while making a payment','Billing','In progress','Medium','2024-11-02 14:30:00','2024-11-02 15:00:00'),
(3,1,'Account Locked','Account locked after multiple failed attempts','Technical','Closed','High','2024-11-03 09:45:00','2024-11-03 10:15:00');
/*!40000 ALTER TABLE `SupportTicket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('Client','Admin') NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `points_balance` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES
(1,'AliceJohnson','alice@example.com','password123','Client','Alice','Johnson','123456789','1 Toronto St.','Toronto','postalcode',0,'2024-11-01 10:15:00','2024-11-01 10:15:00'),
(2,'Bob Smith','bob@example.com','password456','Admin','Bob','Smith','123456789','1 Toronto St.','Toronto','postalcode',10,'2024-11-01 10:15:00','2024-11-01 10:15:00'),
(3,'Charlie Brown','charlie@example.com','password789','Admin','Charlie','Brown','123456789','1 Toronto St.','Toronto','postalcode',100,'2024-11-01 10:15:00','2024-11-01 10:15:00'),
(4,'Daisy Lee','daisy@example.com','password101','Admin','Daisy','Lee','123456789','1 Toronto St.','Toronto','postalcode',0,'2024-11-01 10:15:00','2024-11-01 10:15:00');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add support ticket',7,'add_supportticket'),
(26,'Can change support ticket',7,'change_supportticket'),
(27,'Can delete support ticket',7,'delete_supportticket'),
(28,'Can view support ticket',7,'view_supportticket'),
(29,'Can add ticket comment',8,'add_ticketcomment'),
(30,'Can change ticket comment',8,'change_ticketcomment'),
(31,'Can delete ticket comment',8,'delete_ticketcomment'),
(32,'Can view ticket comment',8,'view_ticketcomment'),
(33,'Can add chat session',9,'add_chatsession'),
(34,'Can change chat session',9,'change_chatsession'),
(35,'Can delete chat session',9,'delete_chatsession'),
(36,'Can view chat session',9,'view_chatsession'),
(37,'Can add chat message',10,'add_chatmessage'),
(38,'Can change chat message',10,'change_chatmessage'),
(39,'Can delete chat message',10,'delete_chatmessage'),
(40,'Can view chat message',10,'view_chatmessage');
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
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$600000$hdfPyLRFs5x79y32Gnb0KI$sHBCBMsQH67K3X7jy0joUcsvbGviWmKkBYMjh9ihYps=',NULL,0,'josh','','','josh@example.com',0,1,'2024-11-09 15:41:50.663354'),
(2,'pbkdf2_sha256$600000$PHP4bnbcetKthgXb1pFZ0R$7hTRSYfJ0BuL8FtO0O/P3I5sdDkjBqcxFXP6+iEv4nI=',NULL,0,'john_doe','','','john@example.com',0,1,'2024-11-09 15:40:02.729610'),
(3,'pbkdf2_sha256$600000$o8m1rpt50eVzDlTpzVrHU7$z5h17/bcpEZviDlO1vqO7qgINm7Fjc4KISvOo624niw=',NULL,0,'jane_smith','','','jane@example.com',0,1,'2024-11-09 15:40:02.842116'),
(4,'pbkdf2_sha256$600000$9LapsioVyIADiQV21ofvGm$bo1IfppAsDrkUVuKY1u+k7Pfr2nq24OAYPSyP6aJFME=',NULL,0,'agent_bob','','','bob@example.com',0,1,'2024-11-09 15:40:02.941746'),
(5,'pbkdf2_sha256$600000$CqfzVgIUeKq7CPjilHa0ti$Mo5Q+ya3eI07QB4vgY94dP3uWwnLo0NzATaDmKUeX2I=',NULL,0,'client_user','','','client_user@example.com',0,1,'2024-11-09 15:59:08.934565'),
(6,'pbkdf2_sha256$600000$SSQtkLiqsisJvQg0G4GXt1$bjqjf96zCqBe9Pwg9SvVmcjdfWyonYdBFKNubuu+Yjw=','2024-11-11 02:08:14.047668',1,'admin','','','admin@example.com',1,1,'2024-11-11 02:01:02.770015');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
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
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session'),
(10,'support','chatmessage'),
(9,'support','chatsession'),
(7,'support','supportticket'),
(8,'support','ticketcomment');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2024-11-09 15:08:52.924232'),
(2,'auth','0001_initial','2024-11-09 15:08:53.032139'),
(3,'admin','0001_initial','2024-11-09 15:08:53.057596'),
(4,'admin','0002_logentry_remove_auto_add','2024-11-09 15:08:53.061021'),
(5,'admin','0003_logentry_add_action_flag_choices','2024-11-09 15:08:53.064293'),
(6,'contenttypes','0002_remove_content_type_name','2024-11-09 15:08:53.084753'),
(7,'auth','0002_alter_permission_name_max_length','2024-11-09 15:08:53.095758'),
(8,'auth','0003_alter_user_email_max_length','2024-11-09 15:08:53.103225'),
(9,'auth','0004_alter_user_username_opts','2024-11-09 15:08:53.106124'),
(10,'auth','0005_alter_user_last_login_null','2024-11-09 15:08:53.117706'),
(11,'auth','0006_require_contenttypes_0002','2024-11-09 15:08:53.118738'),
(12,'auth','0007_alter_validators_add_error_messages','2024-11-09 15:08:53.121541'),
(13,'auth','0008_alter_user_username_max_length','2024-11-09 15:08:53.129034'),
(14,'auth','0009_alter_user_last_name_max_length','2024-11-09 15:08:53.136685'),
(15,'auth','0010_alter_group_name_max_length','2024-11-09 15:08:53.144085'),
(16,'auth','0011_update_proxy_permissions','2024-11-09 15:08:53.148408'),
(17,'auth','0012_alter_user_first_name_max_length','2024-11-09 15:08:53.155854'),
(18,'sessions','0001_initial','2024-11-09 15:08:53.165934'),
(19,'support','0001_initial','2024-11-09 15:08:53.245861');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('1zkcntcx0hz8v3q5a2ejhpsqke0d8sla','.eJxVjLEOAiEQRP-F2hABWcDS3m-4LOwipwaS464y_ruSXKHFNPPezEtMuK1l2jov00ziLEAcfruI6cF1ALpjvTWZWl2XOcqhyJ12eW3Ez8vu_h0U7OW7Ph0hYwieDQSdibN3wZKPFsg7RjOCnhWBZtDeueQiGK0gs1EWQbw_6n431A:1tAJqg:GDFE4-s6hvQFgTYaQSZKRXklWbDySWLWCXN575-BOpQ','2024-11-25 02:08:14.048862');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_chatmessage`
--

DROP TABLE IF EXISTS `support_chatmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support_chatmessage` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_text` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `support_chatmessage_sender_id_57e839dc_fk_auth_user_id` (`sender_id`),
  KEY `support_chatmessage_session_id_175e23ea_fk_support_c` (`session_id`),
  CONSTRAINT `support_chatmessage_sender_id_57e839dc_fk_auth_user_id` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `support_chatmessage_session_id_175e23ea_fk_support_c` FOREIGN KEY (`session_id`) REFERENCES `support_chatsession` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_chatmessage`
--

LOCK TABLES `support_chatmessage` WRITE;
/*!40000 ALTER TABLE `support_chatmessage` DISABLE KEYS */;
INSERT INTO `support_chatmessage` VALUES
(1,'Hello, I\'m having trouble logging in.','2024-11-11 02:05:44.981155',2,1),
(2,'Hi John, I\'m sorry to hear that. Let\'s resolve this issue together.','2024-11-11 02:05:44.989785',4,1),
(3,'I noticed an extra charge on my account.','2024-11-11 02:05:44.991303',3,2),
(4,'I\'m reviewing your billing details. I\'ll get back to you shortly.','2024-11-11 02:05:44.992334',4,2),
(5,'hi there','2024-11-11 03:12:23.400851',6,3);
/*!40000 ALTER TABLE `support_chatmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_chatsession`
--

DROP TABLE IF EXISTS `support_chatsession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support_chatsession` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `support_chatsession_agent_id_562cde59_fk_auth_user_id` (`agent_id`),
  KEY `support_chatsession_client_id_eaab7507_fk_auth_user_id` (`client_id`),
  CONSTRAINT `support_chatsession_agent_id_562cde59_fk_auth_user_id` FOREIGN KEY (`agent_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `support_chatsession_client_id_eaab7507_fk_auth_user_id` FOREIGN KEY (`client_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_chatsession`
--

LOCK TABLES `support_chatsession` WRITE;
/*!40000 ALTER TABLE `support_chatsession` DISABLE KEYS */;
INSERT INTO `support_chatsession` VALUES
(1,'2024-11-11 02:02:41.394286',NULL,4,2),
(2,'2024-11-11 02:02:41.395753',NULL,4,3),
(3,'2024-11-11 03:10:48.013127',NULL,NULL,6),
(4,'2024-11-12 02:19:47.617427',NULL,NULL,6);
/*!40000 ALTER TABLE `support_chatsession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_supportticket`
--

DROP TABLE IF EXISTS `support_supportticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support_supportticket` (
  `ticket_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `category` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `priority` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `support_supportticket_user_id_afde63b2_fk_auth_user_id` (`user_id`),
  CONSTRAINT `support_supportticket_user_id_afde63b2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_supportticket`
--

LOCK TABLES `support_supportticket` WRITE;
/*!40000 ALTER TABLE `support_supportticket` DISABLE KEYS */;
INSERT INTO `support_supportticket` VALUES
(1,'asdf','asdf','Technical','Open','Low','2024-11-09 15:29:42.970999','2024-11-09 15:29:42.971026',1),
(2,'asdf','sdf','Technical','Open','Low','2024-11-09 15:42:36.993357','2024-11-09 15:42:36.993377',1),
(3,'asdf','asdf','Technical','Open','Low','2024-11-09 15:43:25.148786','2024-11-09 15:43:25.148808',1),
(4,'asdf','asdf','Technical','Open','Low','2024-11-09 15:44:11.938697','2024-11-09 15:44:11.938720',1),
(5,'asdf','sdf','Technical','Open','Low','2024-11-09 15:46:01.931470','2024-11-09 15:46:01.931489',1),
(6,'asdf','adf','Technical','Open','Low','2024-11-09 15:49:41.766775','2024-11-09 15:49:41.766794',2),
(7,'Issue with EcoFix App','The app crashes whenever I try to open it.','Technical','Open','High','2024-11-11 02:01:02.880756','2024-11-11 02:01:02.880787',2),
(8,'Billing Inquiry','I was charged twice for my subscription.','Billing','Open','Medium','2024-11-11 02:01:02.883185','2024-11-11 02:01:02.883202',3),
(9,'asdfasdfasdf','asdfasdfasdfasdf','Technical','Open','Low','2024-11-11 02:48:41.558078','2024-11-11 02:48:41.558092',6),
(10,'asdfasdfasdf','asdfasdfasdfasdf','Technical','Open','Low','2024-11-11 02:49:43.397240','2024-11-11 02:49:43.397257',6);
/*!40000 ALTER TABLE `support_supportticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_ticketcomment`
--

DROP TABLE IF EXISTS `support_ticketcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support_ticketcomment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_text` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `support_ticketcommen_ticket_id_ff028e93_fk_support_s` (`ticket_id`),
  KEY `support_ticketcomment_user_id_16f194bd_fk_auth_user_id` (`user_id`),
  CONSTRAINT `support_ticketcommen_ticket_id_ff028e93_fk_support_s` FOREIGN KEY (`ticket_id`) REFERENCES `support_supportticket` (`ticket_id`),
  CONSTRAINT `support_ticketcomment_user_id_16f194bd_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_ticketcomment`
--

LOCK TABLES `support_ticketcomment` WRITE;
/*!40000 ALTER TABLE `support_ticketcomment` DISABLE KEYS */;
INSERT INTO `support_ticketcomment` VALUES
(1,'I\'m experiencing the same issue consistently.','2024-11-11 02:02:41.383301',7,2),
(2,'We\'re looking into this issue and will update you shortly.','2024-11-11 02:02:41.391733',7,4),
(3,'I need a refund for the extra charge.','2024-11-11 02:02:41.392947',8,3);
/*!40000 ALTER TABLE `support_ticketcomment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-12 21:02:39
