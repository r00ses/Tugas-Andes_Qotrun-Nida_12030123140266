-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 09, 2024 at 09:44 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaan_qotrun`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for each book',
  `isbn` VARCHAR(13) NOT NULL COMMENT 'International Standard Book Number',
  `title` VARCHAR(255) NOT NULL COMMENT 'Title of the book',
  `author` VARCHAR(100) NOT NULL COMMENT 'Author of the book',
  `status` ENUM('available','borrowed','reserved','lost') NOT NULL COMMENT 'Status of the book',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Books';

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for each member',
  `full_name` VARCHAR(150) NOT NULL COMMENT 'Full name of the member',
  `email` VARCHAR(100) NOT NULL COMMENT 'Email address of the member',
  `phone_number` VARCHAR(15) NOT NULL COMMENT 'Phone number of the member',
  `membership_status` ENUM('active','inactive') NOT NULL COMMENT 'Status of membership',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Members';

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `loan_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for each loan transaction',
  `book_id` INT(11) NOT NULL,
  `member_id` INT(11) NOT NULL,
  `loan_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  PRIMARY KEY (`loan_id`),
  FOREIGN KEY (`book_id`) REFERENCES `books`(`book_id`) ON DELETE CASCADE,
  FOREIGN KEY (`member_id`) REFERENCES `members`(`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Loans';

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `return_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for each return transaction',
  `loan_id` INT(11) NOT NULL,
  `return_date` DATE NOT NULL,
  `fine_amount` DECIMAL(10,2) NOT NULL COMMENT 'Fine charged for late returns',
  `status` ENUM('returned','lost','damaged') NOT NULL COMMENT 'Status of the return',
  PRIMARY KEY (`return_id`),
  FOREIGN KEY (`loan_id`) REFERENCES `loans`(`loan_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Returns';

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
