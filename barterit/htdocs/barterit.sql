-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2023 at 03:23 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barterit`
--
CREATE DATABASE IF NOT EXISTS `barterit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `barterit`;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_items`
--

CREATE TABLE `tbl_items` (
  `item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_desc` varchar(255) NOT NULL,
  `item_qty` int(11) NOT NULL,
  `item_lat` varchar(255) NOT NULL,
  `item_long` varchar(255) NOT NULL,
  `item_state` varchar(255) NOT NULL,
  `item_locality` varchar(255) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_items`
--

INSERT INTO `tbl_items` (`item_id`, `user_id`, `item_name`, `item_desc`, `item_qty`, `item_lat`, `item_long`, `item_state`, `item_locality`, `date`) VALUES
(1, 1, 'dog 1', 'dog 1', 4, '37.33405', '-122.0180233', 'California', 'Sunnyvale', '2023-07-17'),
(2, 1, 'TV 1', 'TV 1', 5, '37.33405', '-122.0180233', 'California', 'Sunnyvale', '2023-07-17'),
(3, 1, 'Cat 1', 'Cat 1', 4, '37.33405', '-122.0180233', 'California', 'Sunnyvale', '2023-07-17'),
(4, 1, 'cup 1', 'Cup 1', 4, '37.33405', '-122.0180233', 'California', 'Sunnyvale', '2023-07-17'),
(5, 1, 'Sofa 1', 'Sofa 1', 5, '37.4226711', '-122.0849872', 'California', 'Mountain View', '2023-07-18'),
(6, 1, 'Table set 1', 'Table set 1', 5, '37.4226711', '-122.0849872', 'California', 'Mountain View', '2023-07-18'),
(7, 2, 'Dog 2', 'Dog 2', 4, '37.33405', '-122.0180233', 'California', 'Sunnyvale', '2023-07-19'),
(8, 2, 'TV 2', 'TV 2', 4, '37.33405', '-122.0180233', 'California', 'Sunnyvale', '2023-07-19'),
(9, 2, 'Cup 2', 'Cup 2', 4, '37.33405', '-122.0180233', 'California', 'Sunnyvale', '2023-07-19'),
(10, 1, 'dfs', 'dfd', 5, '37.4226711', '-122.0849872', 'California', 'Mountain View', '2023-07-19');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `order_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `buyer_name` varchar(255) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `seller_name` varchar(255) NOT NULL,
  `buyer_item_id` int(11) NOT NULL,
  `seller_item_id` int(11) NOT NULL,
  `order_status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_order`
--

INSERT INTO `tbl_order` (`order_id`, `buyer_id`, `buyer_name`, `seller_id`, `seller_name`, `buyer_item_id`, `seller_item_id`, `order_status`) VALUES
(1, 2, 'Leon', 1, 'Lemuel', 9, 1, 'Success'),
(2, 2, 'Leon', 1, 'Lemuel', 9, 2, 'Rejected'),
(3, 1, 'Lemuel', 2, 'Leon', 3, 7, 'Success'),
(4, 1, 'Asaf', 2, 'Leon', 4, 8, 'Success');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_otp` int(6) NOT NULL,
  `user_datareg` date NOT NULL DEFAULT current_timestamp(),
  `user_coin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_name`, `user_email`, `user_password`, `user_otp`, `user_datareg`, `user_coin`) VALUES
(1, 'Asaf', 'lemuel@gmail.com', '318ea2325ac109b18b739cafd99e543807980b99', 301783, '2023-07-17', 35),
(2, 'Leon', 'leon@gmail.com', '318ea2325ac109b18b739cafd99e543807980b99', 321776, '2023-07-19', 50);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
