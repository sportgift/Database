-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 12, 2019 at 01:36 PM
-- Server version: 5.7.25-log
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sportgift_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
CREATE TABLE IF NOT EXISTS `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `sport_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_acctios_sport_id` (`sport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save sports actions, running, swimming, jumping, walking, jogging, climbing';

-- --------------------------------------------------------

--
-- Table structure for table `action_challenges`
--

DROP TABLE IF EXISTS `action_challenges`;
CREATE TABLE IF NOT EXISTS `action_challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(20) NOT NULL,
  `symbol` varchar(5) NOT NULL,
  `value` float NOT NULL,
  `measured_type_id` int(11) NOT NULL COMMENT 'distance / time / calories / heart rate',
  `range_symbol` varchar(15) NOT NULL,
  `range_value_1` float NOT NULL,
  `measured_type_range_1_id` int(11) NOT NULL,
  `range_value_2` float NOT NULL,
  `measured_type_range_2_id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL COMMENT 'There are challenges that can have a defined route on the map',
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_action_challenge_actions_idx` (`action_id`),
  KEY `fk_type_measure_challenge_actions_idx` (`measured_type_id`),
  KEY `fk_type_measure_r1_challenge_actions_idx` (`measured_type_range_1_id`),
  KEY `fk_type_measure_r2_challenge_actions_idx` (`measured_type_range_2_id`),
  KEY `fk_route_challenge_actions_idx` (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the configuration and conditions of the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `advertising`
--

DROP TABLE IF EXISTS `advertising`;
CREATE TABLE IF NOT EXISTS `advertising` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sponsoring_company_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `creation_date` date NOT NULL,
  `expiration_date` date NOT NULL,
  `rate` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_sponsoring_advertising_idx` (`sponsoring_company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the advertising of the sponsoring companies';

-- --------------------------------------------------------

--
-- Table structure for table `blockchain`
--

DROP TABLE IF EXISTS `blockchain`;
CREATE TABLE IF NOT EXISTS `blockchain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `status` smallint(1) NOT NULL,
  `java_class` varchar(30) NOT NULL,
  `timeout_minuts` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name_block_index` (`name`),
  KEY `index_java_class` (`java_class`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blockchain`
--

INSERT INTO `blockchain` (`id`, `name`, `status`, `java_class`, `timeout_minuts`) VALUES
(1, 'Ethereum', 1, 'EthereumService', 600),
(2, 'Bitcoin', 1, 'BitcoinService', 720);

-- --------------------------------------------------------

--
-- Table structure for table `challenge`
--

DROP TABLE IF EXISTS `challenge`;
CREATE TABLE IF NOT EXISTS `challenge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `maximum_participants` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL,
  `sponsoring_company_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sport_challenge_idx` (`sport_id`),
  KEY `fk_company_spongosr_reto_idx` (`sponsoring_company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the heading of the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `country_id` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the cities of the countries';

-- --------------------------------------------------------

--
-- Table structure for table `competitor`
--

DROP TABLE IF EXISTS `competitor`;
CREATE TABLE IF NOT EXISTS `competitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `user_account_id` int(11) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `weight` float NOT NULL,
  `height` float NOT NULL,
  `gender` char(1) NOT NULL,
  `birth_date` date NOT NULL,
  `country_id` int(11) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `address` text,
  `facebook` varchar(200) DEFAULT NULL,
  `instagram` varchar(200) DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `snapchat` varchar(200) DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_city_competitor_idx` (`city_id`),
  KEY `fk_country_competitor__idx` (`country_id`),
  KEY `fk_user_account_competitor` (`user_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the participants from the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `competitor_awards`
--

DROP TABLE IF EXISTS `competitor_awards`;
CREATE TABLE IF NOT EXISTS `competitor_awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promotions_awards_id` int(11) NOT NULL,
  `competitor_id` int(11) NOT NULL,
  `competitor_challenge_id` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_awards_promotions_awards_competitor_idx` (`promotions_awards_id`),
  KEY `fk_competitor_awards_competitor_idx` (`competitor_id`),
  KEY `fk_challenge_competitor_awards_competitor_idx` (`competitor_challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the prizes of the participants in the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `competitor_challenges`
--

DROP TABLE IF EXISTS `competitor_challenges`;
CREATE TABLE IF NOT EXISTS `competitor_challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) NOT NULL,
  `competitor_id` int(11) NOT NULL,
  `participation_date` int(11) NOT NULL,
  `final_status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_challenges_competitor_idx` (`challenge_id`),
  KEY `fk_competitor_challenges_competitor_idx` (`competitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the participants from the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `coordinates_route`
--

DROP TABLE IF EXISTS `coordinates_route`;
CREATE TABLE IF NOT EXISTS `coordinates_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route_id` int(11) NOT NULL,
  `latitude` double NOT NULL,
  `length` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_route_route_coordinates_idx` (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the coordinates of the defined route';

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `code` varchar(8) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the countries';

-- --------------------------------------------------------

--
-- Table structure for table `cryptocurrency`
--

DROP TABLE IF EXISTS `cryptocurrency`;
CREATE TABLE IF NOT EXISTS `cryptocurrency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smart_contract` varchar(50) NOT NULL,
  `coin_id` varchar(20) NOT NULL,
  `api_url` text NOT NULL,
  `api_url_1` text,
  `api_url_2` text,
  `is_token_ethereum` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `blockchain_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `smart_contract_UNIQUE` (`smart_contract`),
  KEY `smart_contract_index` (`smart_contract`),
  KEY `coin_index` (`coin_id`),
  KEY `index_blockchain_id` (`blockchain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cryptocurrency`
--

INSERT INTO `cryptocurrency` (`id`, `smart_contract`, `coin_id`, `api_url`, `api_url_1`, `api_url_2`, `is_token_ethereum`, `status`, `blockchain_id`) VALUES
(1, '', 'ETH', 'https://api.coingecko.com/api/v3/coins/ethereum', 'https://api.coingecko.com/api/v3/coins/ethereum', 'https://api.coingecko.com/api/v3/coins/ethereum', 0, 1, 1),
(2, '0xd26114cd6EE289AccF82350c8d8487fedB8A0C07', 'OMG', 'https://api.coingecko.com/api/v3/coins/omisego', 'https://api.coingecko.com/api/v3/coins/omisego', 'https://api.coingecko.com/api/v3/coins/omisego', 1, 1, 1),
(3, '0x514910771af9ca656af840dff83e8264ecf986ca', 'LINK', 'https://api.coingecko.com/api/v3/coins/chainlink', 'https://api.coingecko.com/api/v3/coins/chainlink', 'https://api.coingecko.com/api/v3/coins/chainlink', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cryptocurrency_sponsoring_company`
--

DROP TABLE IF EXISTS `cryptocurrency_sponsoring_company`;
CREATE TABLE IF NOT EXISTS `cryptocurrency_sponsoring_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cryptocurrency_id` int(11) NOT NULL,
  `sponsoring_company_id` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `crypto_cs_fk_idx` (`cryptocurrency_id`),
  KEY `company_idx` (`sponsoring_company_id`),
  KEY `company_crypto_idx` (`sponsoring_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `measured_type`
--

DROP TABLE IF EXISTS `measured_type`;
CREATE TABLE IF NOT EXISTS `measured_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the measurement types Km, meters, inches, seconds, minutes, pounds, kg';

-- --------------------------------------------------------

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
CREATE TABLE IF NOT EXISTS `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) NOT NULL,
  `competitor_id` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_challenge_photos_idx` (`challenge_id`),
  KEY `fk_competitor_photos_idx` (`competitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the photos of the participants in the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `promotions_awards`
--

DROP TABLE IF EXISTS `promotions_awards`;
CREATE TABLE IF NOT EXISTS `promotions_awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `prize_type` char(1) NOT NULL,
  `photo` varchar(150) NOT NULL,
  `maximum_exchange_date` date NOT NULL,
  `sponsoring_company_id` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_sponsoring_awards_promotions_idx` (`sponsoring_company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the prizes and promotions of the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
CREATE TABLE IF NOT EXISTS `route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `country_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_country_route_idx` (`country_id`),
  KEY `fk_city_route_idx` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the header of the defined route of a challenge';

-- --------------------------------------------------------

--
-- Table structure for table `sponsoring_company`
--

DROP TABLE IF EXISTS `sponsoring_company`;
CREATE TABLE IF NOT EXISTS `sponsoring_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `rif_ruc` varchar(100) NOT NULL,
  `user_account_id` int(11) NOT NULL,
  `logo` varchar(150) NOT NULL,
  `headquarters_address` text CHARACTER SET latin1,
  `phones` text CHARACTER SET latin1,
  `length_location` double DEFAULT NULL,
  `latitude_location` double DEFAULT NULL,
  `emails` text CHARACTER SET latin1,
  `web` text CHARACTER SET latin1,
  `facebook` text CHARACTER SET latin1,
  `instagram` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `registration_date` date NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_account_idx` (`user_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the information of the companies creating the challenges';

-- --------------------------------------------------------

--
-- Table structure for table `sports`
--

DROP TABLE IF EXISTS `sports`;
CREATE TABLE IF NOT EXISTS `sports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `icon` varchar(150) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Save the sports';

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wallet_id` int(11) NOT NULL,
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `timeout_transaction` timestamp NULL DEFAULT NULL,
  `cryptocurrency_id` int(11) NOT NULL,
  `sponsoring_company_id` int(11) DEFAULT NULL,
  `competitor_id` int(11) DEFAULT NULL,
  `transaction_status_id` int(11) NOT NULL,
  `coins_amount` double NOT NULL,
  `coins_received` double DEFAULT NULL,
  `coin_price` double DEFAULT NULL,
  `total_payment` double NOT NULL,
  `transaction_id` varchar(40) NOT NULL,
  `blockchain_id` int(11) NOT NULL,
  `end_transaction` timestamp NULL DEFAULT NULL,
  `number_of_checks` int(11) DEFAULT '0',
  `last_check_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wallet_id_fk_idx` (`wallet_id`),
  KEY `cryptocurrency_id_fk_idx` (`cryptocurrency_id`),
  KEY `sponsoring_id_fk_idx` (`sponsoring_company_id`),
  KEY `transaction_status_id_fk_idx` (`transaction_status_id`),
  KEY `transaction_index_id` (`transaction_id`),
  KEY `blockchain_id_transaction` (`blockchain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_status`
--

DROP TABLE IF EXISTS `transaction_status`;
CREATE TABLE IF NOT EXISTS `transaction_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction_status`
--

INSERT INTO `transaction_status` (`id`, `name`, `status`) VALUES
(1, 'waiting', 1),
(2, 'successful', 1),
(3, 'error', 1),
(4, 'timeout', 1),
(5, 'Incomplete', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
CREATE TABLE IF NOT EXISTS `user_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(12) NOT NULL,
  `email` varchar(10) NOT NULL,
  `type_user` tinyint(4) NOT NULL,
  `role` varchar(20) NOT NULL,
  `password` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
CREATE TABLE IF NOT EXISTS `wallets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wallet` varchar(50) NOT NULL,
  `private_key` varchar(100) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sponsoring_company_id` int(11) DEFAULT NULL,
  `competitor_id` int(11) DEFAULT NULL,
  `public_key` varchar(200) DEFAULT NULL,
  `blockchain_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wallet_UNIQUE` (`wallet`),
  KEY `wallet_index` (`wallet`),
  KEY `sponsoring_company_id_fk_idx` (`sponsoring_company_id`),
  KEY `index_public_key` (`public_key`),
  KEY `index_blockchain_id_wallet` (`blockchain_id`),
  KEY `fk_competitor_wallet_idx` (`competitor_id`),
  KEY `fk_sponsoring_wallet` (`sponsoring_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `actions`
--
ALTER TABLE `actions`
  ADD CONSTRAINT `fk_actions_sport` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `action_challenges`
--
ALTER TABLE `action_challenges`
  ADD CONSTRAINT `fk_action_challenge_actions` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_measured_type_r1_challenge_actions` FOREIGN KEY (`measured_type_range_1_id`) REFERENCES `measured_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_measured_type_r2_challenge_actions` FOREIGN KEY (`measured_type_range_2_id`) REFERENCES `measured_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_route_challenge_actions` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_type_measured_r1_challenge_actions` FOREIGN KEY (`measured_type_id`) REFERENCES `measured_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `advertising`
--
ALTER TABLE `advertising`
  ADD CONSTRAINT `fk_company_sponsoring_advertising` FOREIGN KEY (`sponsoring_company_id`) REFERENCES `sponsoring_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `challenge`
--
ALTER TABLE `challenge`
  ADD CONSTRAINT `fk_company_sponsoring_challenge` FOREIGN KEY (`sponsoring_company_id`) REFERENCES `sponsoring_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sport_challenge` FOREIGN KEY (`sport_id`) REFERENCES `sports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `fk_country_city` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `competitor`
--
ALTER TABLE `competitor`
  ADD CONSTRAINT `fk_city_competitor` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_country_competitor` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_account_competitor` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `competitor_awards`
--
ALTER TABLE `competitor_awards`
  ADD CONSTRAINT `fk_awards_promotions_awards_competitor` FOREIGN KEY (`promotions_awards_id`) REFERENCES `promotions_awards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_challenge_competitor_awards_competitor` FOREIGN KEY (`competitor_challenge_id`) REFERENCES `competitor_challenges` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competitor_awards_competitor` FOREIGN KEY (`competitor_id`) REFERENCES `competitor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `competitor_challenges`
--
ALTER TABLE `competitor_challenges`
  ADD CONSTRAINT `fk_challenge_challenges_competitors` FOREIGN KEY (`challenge_id`) REFERENCES `challenge` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competitor_challenges_competitors` FOREIGN KEY (`competitor_id`) REFERENCES `competitor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `coordinates_route`
--
ALTER TABLE `coordinates_route`
  ADD CONSTRAINT `fk_route_coordinates_route` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cryptocurrency_sponsoring_company`
--
ALTER TABLE `cryptocurrency_sponsoring_company`
  ADD CONSTRAINT `crypto_cs_fk` FOREIGN KEY (`cryptocurrency_id`) REFERENCES `cryptocurrency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sponsoring_crypto` FOREIGN KEY (`sponsoring_company_id`) REFERENCES `sponsoring_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sponsoring_company_cs_fk` FOREIGN KEY (`sponsoring_company_id`) REFERENCES `sponsoring_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `photos`
--
ALTER TABLE `photos`
  ADD CONSTRAINT `fk_challenge_photos` FOREIGN KEY (`challenge_id`) REFERENCES `challenge` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competitor_photos` FOREIGN KEY (`competitor_id`) REFERENCES `competitor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `promotions_awards`
--
ALTER TABLE `promotions_awards`
  ADD CONSTRAINT `fk_company_sponsoring_awards_promotions` FOREIGN KEY (`sponsoring_company_id`) REFERENCES `sponsoring_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `fk_city_route` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_country_route` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sponsoring_company`
--
ALTER TABLE `sponsoring_company`
  ADD CONSTRAINT `fk_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `cryptocurrency_id_fk` FOREIGN KEY (`cryptocurrency_id`) REFERENCES `cryptocurrency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ blockchain_transacction` FOREIGN KEY (`blockchain_id`) REFERENCES `blockchain` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sponsoring_company_id_fk` FOREIGN KEY (`sponsoring_company_id`) REFERENCES `sponsoring_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `transaction_status_id_fk` FOREIGN KEY (`transaction_status_id`) REFERENCES `transaction_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `wallet_id_fk` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `fk_blockchain_wallet` FOREIGN KEY (`blockchain_id`) REFERENCES `blockchain` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competitor_wallet` FOREIGN KEY (`competitor_id`) REFERENCES `competitor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sponsoring_company_wallet` FOREIGN KEY (`sponsoring_company_id`) REFERENCES `sponsoring_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
