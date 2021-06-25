-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Jun 24, 2021 at 07:18 AM
-- Server version: 10.5.8-MariaDB-1:10.5.8+maria~focal-log
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cagnote`
--

-- --------------------------------------------------------

--
-- Table structure for table `campaign`
--

CREATE TABLE `campaign` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `campaign_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign_content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign_goal` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `campaign`
--

INSERT INTO `campaign` (`id`, `user_id`, `campaign_name`, `campaign_content`, `campaign_goal`, `name`, `email`) VALUES
('33399097a64443ca9edc895afe11d9b3', 1, 'WE Camping', 'Petite cagnotte pour organiser un Week-End en Camping !', 550, 'Elea', 'elea@gmail.com'),
('5623b63c9a1c4cc88fd3c7f596ca9df5', 2, 'Vacances d\'été', 'Pour des vacances de fou en Croatie', 2600, 'Jean', 'jean@gmail.com'),
('c652141557cd482093c3b6539b267450', 3, 'Vacances dans les Rockies', 'Road Trip dans les Rockies entre homies', 5000, 'Susana', 'susana@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20210525073122', '2021-05-25 09:31:29', 56),
('DoctrineMigrations\\Version20210526075833', '2021-05-26 09:58:38', 90),
('DoctrineMigrations\\Version20210526092420', '2021-05-26 11:24:25', 946);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `campaign_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`id`, `campaign_id`, `name`) VALUES
(23, 'c652141557cd482093c3b6539b267450', 'cf9f7c1301d1d37a31191abd798d8588.jpg'),
(24, 'c652141557cd482093c3b6539b267450', 'a820b2203c79a7e555d4803b10793145.jpg'),
(26, '33399097a64443ca9edc895afe11d9b3', 'a6340fa86c121e6b858fe002a41282e9.jpg'),
(27, '33399097a64443ca9edc895afe11d9b3', '0b8bfc78d588b98052674ebf8c9f3298.jpg'),
(28, '5623b63c9a1c4cc88fd3c7f596ca9df5', '3177a59259940189c6c0c915be73c577.jpg'),
(29, '5623b63c9a1c4cc88fd3c7f596ca9df5', '27f070f0a3ac5f5c87c7d1320f80c958.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `participant`
--

CREATE TABLE `participant` (
  `id` int(11) NOT NULL,
  `campaign_id_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_anonymous` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `participant`
--

INSERT INTO `participant` (`id`, `campaign_id_id`, `name`, `email`, `is_anonymous`) VALUES
(1, '33399097a64443ca9edc895afe11d9b3', 'jean', 'jean@gmail.com', 0),
(2, '33399097a64443ca9edc895afe11d9b3', 'Elea Toos', 'elea@gmail.com', 0),
(3, '33399097a64443ca9edc895afe11d9b3', 'Jean', 'jean@gmail.com', 1),
(4, 'c652141557cd482093c3b6539b267450', 'John Doe', 'johndoe@gmail.com', 0),
(5, '5623b63c9a1c4cc88fd3c7f596ca9df5', 'Thomas', 'genereux@gmail.com', 0),
(6, 'c652141557cd482093c3b6539b267450', 'Elea T', 'elea@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `participant_id_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `participant_id_id`, `amount`) VALUES
(1, 1, 200),
(2, 2, 25),
(3, 3, 200),
(4, 4, 250),
(5, 5, 500),
(6, 6, 500);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `user_name`) VALUES
(1, 'elea@gmail.com', '[]', '$argon2id$v=19$m=65536,t=4,p=1$G+TPasvQWC9sbvfIJLJ0VQ$ZSicm444akhGMKoQsDzqv1oWnTtq95Zqs3qXN0nvnsI', 'Elea'),
(2, 'jean@gmail.com', '[]', '$argon2id$v=19$m=65536,t=4,p=1$4mbQjrPXPWZXE8Gqx0hbkw$H/usM6R7LfO/qdZDY0FhshiHMzF6L/3Uejkj+LL77Ps', 'Jean'),
(3, 'susana@gmail.com', '[]', '$argon2id$v=19$m=65536,t=4,p=1$YXnDNpan7IwquKRN395Mkw$y1Z9kJxQ2absgPk7DORPrExxy95Zojh2eDFkl0lCzuc', 'Susana'),
(4, 'jd@gmail.com', '[]', '$argon2id$v=19$m=65536,t=4,p=1$vvIiKXrXcmyAVTflXJs+Hw$Nmh5cNtyOXpiVR5r90M32pZcHt0jUkriZQCnGkgoBWs', 'John Doe'),
(5, 'lelou@gmail.com', '[]', '$argon2id$v=19$m=65536,t=4,p=1$LNWD6A1WvVjS8BVi0jsI5w$4QNd9nyB6SOYH9LoPTStiVNuIOrpp71f4D4HJ6RHVvA', 'lelou');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `campaign`
--
ALTER TABLE `campaign`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1F1512DDA76ED395` (`user_id`);

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C53D045FF639F774` (`campaign_id`);

--
-- Indexes for table `participant`
--
ALTER TABLE `participant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D79F6B113141FA38` (`campaign_id_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6D28840DBEF137EE` (`participant_id_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `participant`
--
ALTER TABLE `participant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `campaign`
--
ALTER TABLE `campaign`
  ADD CONSTRAINT `FK_1F1512DDA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `FK_C53D045FF639F774` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`id`);

--
-- Constraints for table `participant`
--
ALTER TABLE `participant`
  ADD CONSTRAINT `FK_D79F6B113141FA38` FOREIGN KEY (`campaign_id_id`) REFERENCES `campaign` (`id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `FK_6D28840DBEF137EE` FOREIGN KEY (`participant_id_id`) REFERENCES `participant` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
