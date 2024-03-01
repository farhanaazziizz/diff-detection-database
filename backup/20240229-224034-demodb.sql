-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: 103.117.56.81    Database: demodb
-- ------------------------------------------------------
-- Server version	5.5.5-10.3.39-MariaDB-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `NewTable`
--

DROP TABLE IF EXISTS `NewTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NewTable` (
  `Column1` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewTable`
--

LOCK TABLES `NewTable` WRITE;
/*!40000 ALTER TABLE `NewTable` DISABLE KEYS */;
/*!40000 ALTER TABLE `NewTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Penjaga`
--

DROP TABLE IF EXISTS `Penjaga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Penjaga` (
  `id` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Penjaga`
--

LOCK TABLES `Penjaga` WRITE;
/*!40000 ALTER TABLE `Penjaga` DISABLE KEYS */;
/*!40000 ALTER TABLE `Penjaga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengguna`
--

DROP TABLE IF EXISTS `pengguna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengguna` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengguna`
--

LOCK TABLES `pengguna` WRITE;
/*!40000 ALTER TABLE `pengguna` DISABLE KEYS */;
/*!40000 ALTER TABLE `pengguna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas`
--

DROP TABLE IF EXISTS `petugas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas`
--

LOCK TABLES `petugas` WRITE;
/*!40000 ALTER TABLE `petugas` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_ab`
--

DROP TABLE IF EXISTS `petugas_ab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_ab` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_ab`
--

LOCK TABLES `petugas_ab` WRITE;
/*!40000 ALTER TABLE `petugas_ab` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_ab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_ac`
--

DROP TABLE IF EXISTS `petugas_ac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_ac` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_ac`
--

LOCK TABLES `petugas_ac` WRITE;
/*!40000 ALTER TABLE `petugas_ac` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_ac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_bb`
--

DROP TABLE IF EXISTS `petugas_bb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_bb` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_bb`
--

LOCK TABLES `petugas_bb` WRITE;
/*!40000 ALTER TABLE `petugas_bb` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_bb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_cc`
--

DROP TABLE IF EXISTS `petugas_cc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_cc` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_cc`
--

LOCK TABLES `petugas_cc` WRITE;
/*!40000 ALTER TABLE `petugas_cc` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_cc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_dd`
--

DROP TABLE IF EXISTS `petugas_dd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_dd` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_dd`
--

LOCK TABLES `petugas_dd` WRITE;
/*!40000 ALTER TABLE `petugas_dd` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_dd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_ee`
--

DROP TABLE IF EXISTS `petugas_ee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_ee` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_ee`
--

LOCK TABLES `petugas_ee` WRITE;
/*!40000 ALTER TABLE `petugas_ee` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_ee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_ff`
--

DROP TABLE IF EXISTS `petugas_ff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_ff` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_ff`
--

LOCK TABLES `petugas_ff` WRITE;
/*!40000 ALTER TABLE `petugas_ff` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_ff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_gg`
--

DROP TABLE IF EXISTS `petugas_gg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_gg` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_gg`
--

LOCK TABLES `petugas_gg` WRITE;
/*!40000 ALTER TABLE `petugas_gg` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_gg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_hh`
--

DROP TABLE IF EXISTS `petugas_hh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_hh` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_hh`
--

LOCK TABLES `petugas_hh` WRITE;
/*!40000 ALTER TABLE `petugas_hh` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_hh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_ii`
--

DROP TABLE IF EXISTS `petugas_ii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_ii` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_ii`
--

LOCK TABLES `petugas_ii` WRITE;
/*!40000 ALTER TABLE `petugas_ii` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_ii` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_jj`
--

DROP TABLE IF EXISTS `petugas_jj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_jj` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_jj`
--

LOCK TABLES `petugas_jj` WRITE;
/*!40000 ALTER TABLE `petugas_jj` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_jj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petugas_kk`
--

DROP TABLE IF EXISTS `petugas_kk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petugas_kk` (
  `id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petugas_kk`
--

LOCK TABLES `petugas_kk` WRITE;
/*!40000 ALTER TABLE `petugas_kk` DISABLE KEYS */;
/*!40000 ALTER TABLE `petugas_kk` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-29 22:40:38
