-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 08, 2017 at 12:56 AM
-- Server version: 5.6.35
-- PHP Version: 7.0.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `OnlinePOS`
--

-- --------------------------------------------------------

--
-- Table structure for table `Category`
--

CREATE TABLE `Category` (
  `Category_index` int(11) NOT NULL,
  `Category_Name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Category`
--

INSERT INTO `Category` (`Category_index`, `Category_Name`) VALUES
(1, 'Beer'),
(13, 'Blended Scotch'),
(20, 'Bourbone'),
(18, 'Champaign '),
(11, 'Cigaretts'),
(15, 'Cognaic'),
(10, 'Dairy'),
(3, 'Liquor'),
(9, 'MicItem'),
(16, 'Mixers'),
(21, 'Non Alcoholic Wine'),
(7, 'NonTax'),
(17, 'Port'),
(22, 'Red Wine'),
(5, 'Rum'),
(12, 'Single Malt Scotch'),
(19, 'Sparline Wine'),
(8, 'Tax'),
(14, 'Tequila'),
(6, 'Vodka'),
(4, 'Whiskey'),
(23, 'White Wine'),
(2, 'Wine');

-- --------------------------------------------------------

--
-- Table structure for table `Invoice`
--

CREATE TABLE `Invoice` (
  `InvoiceNumber` int(11) NOT NULL,
  `InvoiceTotal` double(6,2) DEFAULT NULL,
  `ChangeDue` double NOT NULL,
  `PaymentType` varchar(10) NOT NULL,
  `Card_Token` varchar(15) DEFAULT NULL,
  `Tax` double(6,2) NOT NULL,
  `Date` date NOT NULL,
  `User_Id` int(10) NOT NULL,
  `Status` varchar(10) NOT NULL,
  `Closed_Seq_num` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Invoice`
--

INSERT INTO `Invoice` (`InvoiceNumber`, `InvoiceTotal`, `ChangeDue`, `PaymentType`, `Card_Token`, `Tax`, `Date`, `User_Id`, `Status`, `Closed_Seq_num`) VALUES
(1, 10.62, 0, 'Cash', NULL, 0.63, '2017-10-23', 1, 'Closed', 1),
(5, 21.22, 3.78, 'Cash', NULL, 1.27, '2017-10-23', 1, 'Closed', 1),
(6, 13.68, 0, 'Card', NULL, 0.69, '2017-11-08', 1, 'Closed', 1),
(7, 8.49, 0, 'Card', 'zqpdxXo9M', 0.50, '2017-11-08', 1, 'Closed', 1),
(8, 15.94, 0, 'Card', '8qpdLrGk7', 0.95, '2017-11-21', 1, 'Closed', 1),
(9, 14.86, 0, 'Card', 'Kkb8A5jL7', 0.88, '2017-11-29', 1, 'Closed', 1),
(10, 42.50, 2.5, 'Cash', NULL, 2.53, '2017-12-03', 1, 'Closed', 1),
(11, 24.95, 0.05, 'Cash', NULL, 1.49, '2017-12-03', 1, 'Closed', 1),
(12, 26.56, 3.44, 'Cash', NULL, 1.58, '2017-12-03', 1, 'Closed', 1),
(13, 34.01, 0.99, 'Cash', NULL, 2.03, '2017-12-04', 1, 'Closed', 1),
(14, 15.40, 0.6, 'Cash', NULL, 0.92, '2017-12-04', 1, 'Closed', 2),
(15, 5.32, 0.68, 'Cash', NULL, 0.32, '2017-12-04', 1, 'Closed', 2),
(16, 24.43, 0.57, 'Cash', NULL, 1.45, '2017-12-04', 1, 'Closed', 3),
(17, 20.72, 0, 'Card', 'LEzqrk8gq', 1.24, '2017-12-04', 1, 'Closed', 4),
(18, 4.78, 0.22, 'Cash', NULL, 0.29, '2017-12-05', 1, 'Closed', 5),
(19, 11.96, 0.04, 'Cash', NULL, 0.71, '2017-12-05', 1, 'Closed', 7),
(20, 10.62, 0, 'Cash', NULL, 0.63, '2017-12-05', 1, 'Closed', 8),
(21, 79.75, 0, 'Card', '5AXp7beA9', 4.76, '2017-12-05', 1, 'Closed', 9),
(22, 20.18, 0.82, 'Cash', NULL, 1.20, '2017-12-05', 1, 'Closed', 11),
(23, 63.78, 0, 'Card', 'nKd8qad7r', 3.80, '2017-12-05', 1, 'Closed', 11),
(24, 5.61, 0.14, 'Cash', NULL, 0.32, '2017-12-05', 1, 'Closed', 12),
(25, 5.61, 0.39, 'Cash', NULL, 0.32, '2017-12-05', 1, 'Closed', 12),
(26, 11.96, 0.04, 'Cash', NULL, 0.71, '2017-12-05', 1, 'Closed', 12),
(27, 21.49, 0.01, 'Cash', NULL, 1.21, '2017-12-05', 1, 'Closed', 13),
(28, 4.24, 0.76, 'Cash', NULL, 0.25, '2017-12-05', 1, 'Closed', 13);

-- --------------------------------------------------------

--
-- Table structure for table `InvoiceDetail`
--

CREATE TABLE `InvoiceDetail` (
  `Invoice_Index` int(11) NOT NULL,
  `InvoiceNumber` int(11) NOT NULL,
  `ItemCode` varchar(15) NOT NULL,
  `ItemName` varchar(30) NOT NULL,
  `ItemPrice` decimal(6,2) NOT NULL,
  `Quantity` int(5) NOT NULL,
  `Tax` decimal(6,2) NOT NULL,
  `ItemTotal` double(6,2) NOT NULL,
  `Date` date NOT NULL,
  `Status` varchar(10) NOT NULL DEFAULT 'Open',
  `Cashier_Name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `InvoiceDetail`
--

INSERT INTO `InvoiceDetail` (`Invoice_Index`, `InvoiceNumber`, `ItemCode`, `ItemName`, `ItemPrice`, `Quantity`, `Tax`, `ItemTotal`, `Date`, `Status`, `Cashier_Name`) VALUES
(1, 10, '45645', 'eghjf kewfljhb', '10.00', 1, '0.63', 10.63, '2017-12-03', 'Closed', 'Kishan'),
(2, 10, '1', 'dish, kj.bd', '2.00', 2, '0.24', 4.24, '2017-12-03', 'Closed', 'Kishan'),
(3, 11, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-03', 'Closed', 'Kishan'),
(4, 11, '909090', 'jkhfbn kefnc', '4.49', 1, '0.29', 0.00, '2017-12-03', 'Closed', 'Kishan'),
(5, 11, '909090', 'jkhfbn kefnc', '4.49', 2, '0.57', 0.00, '2017-12-03', 'Closed', 'Kishan'),
(6, 12, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-03', 'Closed', 'Kishan'),
(7, 12, '9823464', 'skjdfh ksdfh', '14.99', 1, '0.95', 0.00, '2017-12-03', 'Closed', 'Kishan'),
(8, 13, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(9, 13, '23789465', 'Absolute Plain Vodka 750ml', '21.99', 1, '1.40', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(10, 14, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(11, 14, '909090', 'jkhfbn kefnc', '4.49', 1, '0.29', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(12, 15, '45645', 'Kihasjb', '5.00', 1, '0.32', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(13, 16, '901375', 'we;oird if;fehfs;dd ahfjdblcv', '12.99', 1, '0.82', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(14, 16, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(15, 17, '45645', 'Kihasjb', '5.00', 1, '0.32', 0.00, '2017-12-04', 'Closed', 'Kishan'),
(16, 18, '909090', 'jkhfbn kefnc', '4.49', 1, '0.29', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(17, 19, '4395492364', 'Marlboro Gold', '11.25', 1, '0.71', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(18, 20, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(19, 21, '923847098327', 'Oban 14 Yr 750 ml', '74.99', 1, '4.76', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(20, 22, '453412', 'Abcdsre', '3.99', 1, '0.25', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(21, 22, '9823464', 'skjdfh ksdfh', '14.99', 1, '0.95', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(22, 23, '2903847', 'Glenfiddich 12 Yr 750ml', '46.99', 1, '2.98', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(23, 24, '1222131', 'Coke Cola 6Pk Cans', '4.99', 1, '0.32', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(25, 25, '1222131', 'Coke Cola 6Pk Cans', '4.99', 1, '0.32', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(26, 25, 'Bottle Deposit', 'Bottle Deposit', '0.05', 6, '0.00', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(27, 26, '09325768372', 'Marlboro Reds ', '11.25', 1, '0.71', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(28, 27, '1222131', 'Coke Cola 6Pk Cans', '4.99', 1, '0.32', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(29, 27, 'Bottle Deposit', 'Bottle Deposit', '0.05', 6, '0.00', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(30, 27, '677698765', 'ieorlkjh ewtr\'w;s', '13.99', 1, '0.89', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(31, 27, 'Bottle Deposit', 'Bottle Deposit', '0.05', 20, '0.00', 0.00, '2017-12-05', 'Closed', 'Kishan'),
(32, 28, '122333', 'ksDfhjbvxc.n ', '3.99', 1, '0.25', 0.00, '2017-12-05', 'Closed', 'Kishan');

-- --------------------------------------------------------

--
-- Table structure for table `Item`
--

CREATE TABLE `Item` (
  `ItemCode` varchar(15) NOT NULL,
  `ItemName` varchar(225) NOT NULL DEFAULT 'No Item Name defined',
  `ItemCost` decimal(6,2) DEFAULT '0.00',
  `ItemPrice` decimal(6,2) DEFAULT '0.00',
  `QuantityOnHand` int(11) DEFAULT '0',
  `Category_Name` varchar(25) NOT NULL,
  `deposit` int(11) DEFAULT '0',
  `Min_Qty` int(11) DEFAULT '0',
  `Vendor_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Item`
--

INSERT INTO `Item` (`ItemCode`, `ItemName`, `ItemCost`, `ItemPrice`, `QuantityOnHand`, `Category_Name`, `deposit`, `Min_Qty`, `Vendor_Name`) VALUES
('00349580485', 'American Spirit Yellow', '9.09', '11.49', 12, 'Cigaretts', NULL, NULL, 'MTC'),
('0127489368', 'Savage Sparkling Wine', '13.33', '19.99', 0, 'Champaign ', 0, 0, 'Winebow'),
('03982579', 'Pacifico Lager 6Pk Bottle', '7.00', '10.49', 4, 'Beer', 6, 0, 'Star Distributor '),
('087456968', 'American Spirit Black', '9.29', '11.49', 2, 'Cigaretts', NULL, NULL, 'MTC'),
('090994502', 'Talisker 10Yr 750 ml ', '53.00', '74.99', 2, 'Single Malt Scotch', 0, 3, 'B&B'),
('09325768372', 'Marlboro Reds ', '8.89', '11.25', 9, 'Cigaretts', NULL, NULL, 'MTC'),
('0959034389', 'Modello 24pk Cans', '18.00', '22.99', 6, 'Beer', 24, 0, 'Star Distributor '),
('09900990', 'St. Palegrano Sparkling Water 22oz bottle', '1.47', '2.69', 10, 'Mixers', 1, 0, 'Star Distributor '),
('1', 'ladhjkfjsbvcx', '7.00', '9.99', 3, 'MicItem', NULL, NULL, 'CDI'),
('1222131', 'Coke Cola 6Pk Cans', '0.42', '4.99', 9, 'Mixers', 6, 6, 'ACE'),
('122333', 'ksDfhjbvxc.n ', '1.00', '3.99', -8, 'Liquor', 0, 1, 'CDI'),
('1224422', '2 Roads Honey Spot Ale 12pk cans', '15.00', '19.99', 0, 'Beer', 12, 0, 'Star Distributor '),
('23745849', 'Absolute Plain Vodka 1.75ml', '25.00', '34.99', NULL, 'Vodka', 0, 0, 'H&P'),
('23789465', 'Absolute Plain Vodka 750ml', '12.00', '21.99', 11, 'Vodka', 0, 0, 'H&P'),
('23894765', 'Kettle One Vodka 750 ml', '20.00', '29.99', 2, 'Vodka', 0, 0, 'B&B'),
('2903847', 'Glenfiddich 12 Yr 750ml', '30.00', '46.99', 2, 'Single Malt Scotch', 0, 2, 'B&B'),
('324567987', 'Talisker Storm 750 ml ', '69.99', '84.99', 9, 'Single Malt Scotch', 0, 2, 'CDI'),
('325243546574', 'Dom Parignon Vintage 2004', '100.00', '159.99', 7, 'Champaign ', 0, 0, 'Eder Brothers'),
('32875023', 'Marlboro Silver', '0.00', '8.89', 31, 'Cigaretts', NULL, NULL, 'MTC'),
('4395492364', 'Marlboro Gold', '8.89', '11.25', 9, 'Cigaretts', NULL, NULL, 'MTC'),
('44509659', 'Bacardi Gold 750 ml', '12.00', '17.99', 14, 'Rum', 0, 12, 'CDI'),
('453412', 'Abcdsre', '2.00', '3.99', 12, 'MicItem', NULL, NULL, 'B&B'),
('4563453', 'dfgvcsaddcvx', '2.00', '3.00', 2, 'Beer', 0, 0, 'ACE'),
('45645', 'Kihasjb', '3.00', '5.00', -1, 'MicItem', 0, 1, 'ACE'),
('4657839', 'Gordans Vodka 1.75 L', '12.00', '21.99', 1, 'Vodka', 0, 0, 'CDI'),
('49837527634', 'Moet Champaign GiftBox', '33.33', '46.99', 36, 'Champaign ', 0, 0, 'Eder Brothers'),
('677698765', 'ieorlkjh ewtr\'w;s', '10.00', '13.99', 2, 'Beer', 20, NULL, 'Craft Beer'),
('729887387', 'Regiano Pasta Sauce', '8.33', '16.99', 10, 'Dairy', 0, 0, 'F & F distribution'),
('7643873', 'Corona Extra 6Pk Bottle', '6.75', '9.99', 1, 'Beer', 6, 0, 'Star Distributor '),
('823567484', 'Gray Goose', '22.00', '36.99', 2, 'Vodka', 0, 0, 'B&B'),
('8763723129846', 'BudLight 6Pk Bottles', '5.00', '7.18', 10, 'Beer', 6, 0, 'Dichallo'),
('876434678', 'Glenlevit 12 Yr 750 ml', '45.00', '59.99', 16, 'Single Malt Scotch', 0, 2, 'B&B'),
('87876763891', 'Unita Double IPA 4Pk cans', '8.33', '11.49', 4, 'Beer', 4, 0, 'Dichallo'),
('89343748', 'kjSDHF ksjdhfsdh', '10.00', '19.99', 2, 'Vodka', NULL, 1, 'B&B'),
('894343695802', 'Ch. ST Machele', '16.67', '22.99', 0, 'Red Wine', 0, 0, 'Winebow'),
('900937782', 'Budweiser 24Pk Cans', '16.59', '19.99', 10, 'Beer', 24, 0, 'Dichallo'),
('901375', 'we;oird if;fehfs;dd ahfjdblcv', '8.00', '12.99', 3, 'Wine', NULL, NULL, 'CDI'),
('909090', 'jkhfbn kefnc', '2.00', '4.49', 4, 'Liquor', NULL, NULL, 'ACE'),
('923847098327', 'Oban 14 Yr 750 ml', '59.00', '74.99', 10, 'Single Malt Scotch', 0, 0, 'CDI'),
('9823464', 'skjdfh ksdfh', '10.00', '14.99', -2, 'Vodka', NULL, 2, 'New England Wine and Spirit'),
('988935662', 'Bacardi Gold Rum 1.75 L', '18.00', '29.99', 4, 'Rum', 0, 2, 'CDI'),
('NonTax', 'NonTax Item', '1.00', '1.00', NULL, 'NonTax', NULL, NULL, 'None'),
('Tax', 'Tax Item', '1.00', '1.00', NULL, 'MicItem', NULL, NULL, 'None');

-- --------------------------------------------------------

--
-- Table structure for table `POS_Defaults`
--

CREATE TABLE `POS_Defaults` (
  `Default_Index` int(11) NOT NULL,
  `User_Type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `POS_Defaults`
--

INSERT INTO `POS_Defaults` (`Default_Index`, `User_Type`) VALUES
(1, 'Cashier'),
(2, 'Manager');

-- --------------------------------------------------------

--
-- Table structure for table `Purchase_Order`
--

CREATE TABLE `Purchase_Order` (
  `Purchase_Order_Index` int(11) NOT NULL,
  `Vendor_Id` int(11) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `Status` varchar(10) NOT NULL DEFAULT 'Open'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Purchase_Order`
--

INSERT INTO `Purchase_Order` (`Purchase_Order_Index`, `Vendor_Id`, `DateCreated`, `Status`) VALUES
(6, 1, '0000-00-00 00:00:00', 'Closed'),
(11, 3, '2017-11-17 00:00:00', 'Closed'),
(12, 14, '2017-11-17 00:00:00', 'Closed'),
(13, 1, '2017-11-27 00:00:00', 'Closed'),
(14, 1, '2017-11-27 11:44:57', 'Closed'),
(15, 1, '2017-11-27 11:45:34', 'Closed'),
(16, 8, '2017-11-27 11:47:06', 'Closed'),
(17, 1, '2017-11-27 11:48:26', 'Closed'),
(18, 1, '2017-11-27 11:50:48', 'Closed'),
(19, 1, '2017-11-27 11:53:11', 'Closed'),
(20, 1, '2017-12-04 10:35:19', 'Closed'),
(21, 2, '2017-12-04 10:36:46', 'Closed'),
(22, 1, '2017-12-04 10:40:12', 'Closed'),
(23, 1, '2017-12-04 10:40:53', 'Closed'),
(24, 1, '2017-12-04 10:42:36', 'Closed'),
(25, 1, '2017-12-07 00:00:00', 'Closed'),
(26, 14, '0000-00-00 00:00:00', 'Closed'),
(27, 2, '2017-12-07 17:04:59', 'Closed'),
(28, 1, '2017-12-07 17:07:50', 'Closed'),
(29, 17, '2017-12-07 17:20:16', 'Closed'),
(30, 17, '2017-12-07 17:20:16', 'Closed'),
(31, 11, '2017-12-07 17:28:16', 'Closed'),
(32, 15, '2017-12-07 17:29:11', 'Closed'),
(33, 6, '2017-12-07 17:41:41', 'Closed'),
(34, 6, '2017-12-07 17:41:41', 'Closed'),
(35, 8, '2017-12-07 17:45:14', 'Closed'),
(36, 14, '2017-12-07 18:10:39', 'Closed'),
(37, 6, '2017-12-07 18:29:45', 'Open'),
(38, 2, '2017-12-07 18:35:49', 'Open'),
(39, 2, '2017-12-07 18:39:14', 'Open'),
(40, 3, '2017-12-07 18:56:05', 'Closed');

-- --------------------------------------------------------

--
-- Table structure for table `Purchase_Order_Detail`
--

CREATE TABLE `Purchase_Order_Detail` (
  `orderIndex` int(11) NOT NULL,
  `Purchase_Order_Index` int(11) NOT NULL,
  `Vendor_Id` int(11) NOT NULL,
  `ItemCode` varchar(15) NOT NULL,
  `ItemName` varchar(225) NOT NULL,
  `ItemPrice` decimal(6,2) NOT NULL,
  `ItemOrdered` int(11) NOT NULL,
  `DateCreated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Purchase_Order_Detail`
--

INSERT INTO `Purchase_Order_Detail` (`orderIndex`, `Purchase_Order_Index`, `Vendor_Id`, `ItemCode`, `ItemName`, `ItemPrice`, `ItemOrdered`, `DateCreated`) VALUES
(1, 6, 1, '', '', '0.00', 0, '0000-00-00 00:00:00'),
(3, 13, 3, '', '', '0.00', 0, '2017-11-27 00:00:00'),
(5, 15, 1, '4563453', '', '0.00', 0, '2017-11-27 11:45:34'),
(7, 16, 8, '087456968', '', '0.00', 0, '2017-11-27 11:47:06'),
(8, 16, 8, '00349580485', '', '0.00', 0, '2017-11-27 11:47:06'),
(9, 16, 8, '4395492364', '', '0.00', 0, '2017-11-27 11:47:06'),
(10, 16, 8, '09325768372', '', '0.00', 0, '2017-11-27 11:47:06'),
(11, 16, 8, '32875023', '', '0.00', 0, '2017-11-27 11:47:06'),
(12, 17, 1, '4563453', '', '0.00', 0, '2017-11-27 11:48:26'),
(13, 17, 1, '909090', '', '0.00', 0, '2017-11-27 11:48:26'),
(14, 17, 1, '45645', '', '0.00', 0, '2017-11-27 11:48:26'),
(15, 18, 1, '4563453', '', '0.00', 2, '2017-11-27 11:50:48'),
(16, 18, 1, '909090', '', '0.00', 3, '2017-11-27 11:50:48'),
(17, 18, 1, '45645', '', '0.00', 1, '2017-11-27 11:50:48'),
(18, 19, 1, '4563453', '', '2.00', 3, '2017-11-27 11:53:11'),
(19, 19, 1, '909090', '', '2.00', 1, '2017-11-27 11:53:11'),
(20, 19, 1, '45645', '', '3.00', 1, '2017-11-27 11:53:11'),
(21, 20, 1, '4563453', '', '2.00', 4, '2017-12-04 10:35:19'),
(22, 20, 1, '909090', '', '2.00', 3, '2017-12-04 10:35:19'),
(23, 20, 1, '45645', '', '3.00', 1, '2017-12-04 10:35:19'),
(24, 21, 2, '453412', '', '2.00', 2, '2017-12-04 10:36:46'),
(25, 21, 2, '2903847', '', '30.00', 1, '2017-12-04 10:36:46'),
(26, 21, 2, '876434678', '', '45.00', 2, '2017-12-04 10:36:46'),
(27, 21, 2, '823567484', '', '22.00', 2, '2017-12-04 10:36:46'),
(28, 21, 2, '23894765', '', '20.00', 2, '2017-12-04 10:36:46'),
(29, 21, 2, '89343748', '', '10.00', 1, '2017-12-04 10:36:46'),
(30, 21, 2, '090994502', '', '53.00', 4, '2017-12-04 10:36:46'),
(31, 22, 1, '4563453', '', '2.00', 1, '2017-12-04 10:40:12'),
(32, 22, 1, '909090', '', '2.00', 4, '2017-12-04 10:40:12'),
(33, 22, 1, '45645', '', '3.00', 10, '2017-12-04 10:40:12'),
(34, 23, 1, '4563453', '', '2.00', 7, '2017-12-04 10:40:53'),
(35, 23, 1, '909090', '', '2.00', 6, '2017-12-04 10:40:53'),
(36, 23, 1, '45645', '', '3.00', 5, '2017-12-04 10:40:53'),
(37, 24, 1, '4563453', '', '2.00', 1, '2017-12-04 10:42:36'),
(38, 24, 1, '909090', '', '2.00', 1, '2017-12-04 10:42:36'),
(39, 24, 1, '45645', '', '3.00', 1, '2017-12-04 10:42:36'),
(40, 25, 1, '1222131', 'Coke Cola 6Pk Cans', '0.42', 2, '2017-12-07 13:21:06'),
(41, 25, 1, '4563453', 'dfgvcsaddcvx', '2.00', 2, '2017-12-07 13:21:06'),
(42, 25, 1, '909090', 'jkhfbn kefnc', '2.00', 2, '2017-12-07 13:21:06'),
(43, 25, 1, '45645', 'Kihasjb', '3.00', 2, '2017-12-07 13:21:06'),
(44, 26, 14, '677698765', 'ieorlkjh ewtr\'w;s', '10.00', 4, '2017-12-07 14:25:55'),
(45, 27, 2, '453412', 'Abcdsre', '2.00', 1, '2017-12-07 17:04:34'),
(46, 27, 2, '2903847', 'Glenfiddich 12 Yr 750ml', '30.00', 3, '2017-12-07 17:04:34'),
(47, 27, 2, '876434678', 'Glenlevit 12 Yr 750 ml', '45.00', 4, '2017-12-07 17:04:34'),
(48, 27, 2, '823567484', 'Gray Goose', '22.00', 2, '2017-12-07 17:04:34'),
(49, 27, 2, '23894765', 'Kettle One Vodka 750 ml', '20.00', 2, '2017-12-07 17:04:34'),
(50, 27, 2, '89343748', 'kjSDHF ksjdhfsdh', '10.00', 1, '2017-12-07 17:04:34'),
(51, 27, 2, '090994502', 'Talisker 10Yr 750 ml ', '53.00', 0, '2017-12-07 17:04:34'),
(52, 28, 1, '1222131', 'Coke Cola 6Pk Cans', '0.42', 0, '2017-12-07 17:07:29'),
(53, 28, 1, '4563453', 'dfgvcsaddcvx', '2.00', 2, '2017-12-07 17:07:29'),
(54, 28, 1, '909090', 'jkhfbn kefnc', '2.00', 4, '2017-12-07 17:07:29'),
(55, 28, 1, '45645', 'Kihasjb', '3.00', 0, '2017-12-07 17:07:29'),
(56, 30, 17, '1224422', '2 Roads Honey Spot Ale 12pk cans', '15.00', 0, '2017-12-07 17:19:32'),
(57, 30, 17, '7643873', 'Corona Extra 6Pk Bottle', '6.75', 1, '2017-12-07 17:19:32'),
(58, 30, 17, '0959034389', 'Modello 24pk Cans', '18.00', 1, '2017-12-07 17:19:32'),
(59, 30, 17, '03982579', 'Pacifico Lager 6Pk Bottle', '7.00', 4, '2017-12-07 17:19:32'),
(60, 30, 17, '09900990', 'St. Palegrano Sparkling Water 22oz bottle', '1.47', 10, '2017-12-07 17:19:32'),
(61, 31, 11, '325243546574', 'Dom Parignon Vintage 2004', '100.00', 1, '2017-12-07 17:27:53'),
(62, 31, 11, '49837527634', 'Moet Champaign GiftBox', '33.33', 36, '2017-12-07 17:27:53'),
(63, 32, 15, '729887387', 'Regiano Pasta Sauce', '8.33', 10, '2017-12-07 17:28:57'),
(64, 33, 6, '8763723129846', 'BudLight 6Pk Bottles', '5.00', 0, '2017-12-07 17:40:22'),
(65, 33, 6, '900937782', 'Budweiser 24Pk Cans', '16.59', 0, '2017-12-07 17:40:22'),
(66, 33, 6, '87876763891', 'Unita Double IPA 4Pk cans', '8.33', 5, '2017-12-07 17:40:22'),
(67, 34, 6, '8763723129846', 'BudLight 6Pk Bottles', '5.00', 0, '2017-12-07 17:40:49'),
(68, 34, 6, '900937782', 'Budweiser 24Pk Cans', '16.59', 0, '2017-12-07 17:40:49'),
(69, 34, 6, '87876763891', 'Unita Double IPA 4Pk cans', '8.33', 4, '2017-12-07 17:40:49'),
(70, 35, 8, '087456968', 'American Spirit Black', '9.29', 0, '2017-12-07 17:44:46'),
(71, 35, 8, '00349580485', 'American Spirit Yellow', '9.09', 10, '2017-12-07 17:44:46'),
(72, 35, 8, '4395492364', 'Marlboro Gold', '8.89', 10, '2017-12-07 17:44:46'),
(73, 35, 8, '09325768372', 'Marlboro Reds ', '8.89', 10, '2017-12-07 17:44:46'),
(74, 35, 8, '32875023', 'Marlboro Silver', '0.00', 20, '2017-12-07 17:44:46'),
(75, 36, 14, '677698765', 'ieorlkjh ewtr\'w;s', '10.00', 2, '2017-12-07 18:10:16'),
(76, 37, 6, '8763723129846', 'BudLight 6Pk Bottles', '5.00', 1, '2017-12-07 18:29:45'),
(77, 37, 6, '900937782', 'Budweiser 24Pk Cans', '16.59', 2, '2017-12-07 18:29:45'),
(78, 37, 6, '87876763891', 'Unita Double IPA 4Pk cans', '8.33', 2, '2017-12-07 18:29:45'),
(79, 38, 2, '453412', 'Abcdsre', '2.00', 2, '2017-12-07 18:35:49'),
(80, 38, 2, '2903847', 'Glenfiddich 12 Yr 750ml', '30.00', 1, '2017-12-07 18:35:49'),
(81, 38, 2, '876434678', 'Glenlevit 12 Yr 750 ml', '45.00', 1, '2017-12-07 18:35:49'),
(82, 38, 2, '823567484', 'Gray Goose', '22.00', 3, '2017-12-07 18:35:49'),
(83, 38, 2, '23894765', 'Kettle One Vodka 750 ml', '20.00', 3, '2017-12-07 18:35:49'),
(84, 38, 2, '89343748', 'kjSDHF ksjdhfsdh', '10.00', 2, '2017-12-07 18:35:49'),
(85, 38, 2, '090994502', 'Talisker 10Yr 750 ml ', '53.00', 1, '2017-12-07 18:35:49'),
(86, 39, 2, '453412', 'Abcdsre', '2.00', 1, '2017-12-07 18:39:14'),
(87, 39, 2, '2903847', 'Glenfiddich 12 Yr 750ml', '30.00', 2, '2017-12-07 18:39:14'),
(88, 39, 2, '876434678', 'Glenlevit 12 Yr 750 ml', '45.00', 2, '2017-12-07 18:39:14'),
(89, 39, 2, '823567484', 'Gray Goose', '22.00', 1, '2017-12-07 18:39:14'),
(90, 39, 2, '23894765', 'Kettle One Vodka 750 ml', '20.00', 1, '2017-12-07 18:39:14'),
(91, 39, 2, '89343748', 'kjSDHF ksjdhfsdh', '10.00', 1, '2017-12-07 18:39:14'),
(92, 39, 2, '090994502', 'Talisker 10Yr 750 ml ', '53.00', 3, '2017-12-07 18:39:14'),
(93, 40, 3, '44509659', 'Bacardi Gold 750 ml', '12.00', 2, '2017-12-07 18:55:39'),
(94, 40, 3, '988935662', 'Bacardi Gold Rum 1.75 L', '18.00', 2, '2017-12-07 18:55:39'),
(95, 40, 3, '4657839', 'Gordans Vodka 1.75 L', '12.00', 1, '2017-12-07 18:55:39'),
(96, 40, 3, '122333', 'ksDfhjbvxc.n ', '1.00', 1, '2017-12-07 18:55:39'),
(97, 40, 3, '1', 'ladhjkfjsbvcx', '7.00', 3, '2017-12-07 18:55:39'),
(98, 40, 3, '923847098327', 'Oban 14 Yr 750 ml', '59.00', 4, '2017-12-07 18:55:39'),
(99, 40, 3, '324567987', 'Talisker Storm 750 ml ', '69.99', 4, '2017-12-07 18:55:39'),
(100, 40, 3, '901375', 'we;oird if;fehfs;dd ahfjdblcv', '8.00', 3, '2017-12-07 18:55:39');

-- --------------------------------------------------------

--
-- Table structure for table `reportHeader`
--

CREATE TABLE `reportHeader` (
  `Closed_Seq_num` int(11) NOT NULL,
  `Closing_Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reportHeader`
--

INSERT INTO `reportHeader` (`Closed_Seq_num`, `Closing_Date`) VALUES
(1, '2017-12-04'),
(2, '2017-12-04'),
(3, '2017-12-04'),
(4, '2017-12-04'),
(5, '2017-12-04'),
(6, '2017-12-05'),
(7, '2017-12-05'),
(8, '2017-12-05'),
(9, '2017-12-05'),
(10, '2017-12-05'),
(11, '2017-12-05'),
(12, '2017-12-05'),
(13, '2017-12-05'),
(14, '2017-12-05');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `User_Id` int(10) NOT NULL,
  `User_Name` varchar(10) NOT NULL,
  `User_Password` varchar(15) NOT NULL,
  `User_Type` varchar(10) NOT NULL,
  `LastLogin` datetime NOT NULL,
  `LogOut` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`User_Id`, `User_Name`, `User_Password`, `User_Type`, `LastLogin`, `LogOut`) VALUES
(1, 'Kishan', 'Kishan', 'Manager', '2017-12-07 17:00:26', '2017-12-04 23:53:55'),
(2, 'abc', 'abc', 'Cashier', '2017-10-22 20:23:57', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `Vendors`
--

CREATE TABLE `Vendors` (
  `Vendor_Id` int(11) NOT NULL,
  `Vendor_Name` varchar(50) NOT NULL,
  `Vendor_Phone#` int(12) DEFAULT NULL,
  `Vendor_Address` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Vendors`
--

INSERT INTO `Vendors` (`Vendor_Id`, `Vendor_Name`, `Vendor_Phone#`, `Vendor_Address`) VALUES
(1, 'ACE', 0, 'North Haven'),
(2, 'B&B', 0, 'New haven'),
(3, 'CDI', 0, 'East Haven'),
(4, 'North East Bev Company', 0, 'Orange'),
(5, 'G&G', 0, 'Hartford'),
(6, 'Dichallo', 0, 'Hamdan'),
(7, 'None', NULL, NULL),
(8, 'MTC', NULL, NULL),
(9, 'New England Wine and Spirit', NULL, NULL),
(10, 'H&P', NULL, NULL),
(11, 'Eder Brothers', NULL, NULL),
(12, 'Slocun and Sons', NULL, NULL),
(13, 'Murphy Distributor', NULL, NULL),
(14, 'Craft Beer', NULL, NULL),
(15, 'F & F distribution', NULL, NULL),
(16, 'Winebow', NULL, NULL),
(17, 'Star Distributor ', NULL, NULL),
(18, '', 0, 'Not Available'),
(19, 'Tuton', 512234214, 'New York');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`Category_index`),
  ADD UNIQUE KEY `Category_index` (`Category_Name`);

--
-- Indexes for table `Invoice`
--
ALTER TABLE `Invoice`
  ADD PRIMARY KEY (`InvoiceNumber`),
  ADD UNIQUE KEY `Card_Token` (`Card_Token`),
  ADD KEY `User_Name` (`User_Id`) USING BTREE,
  ADD KEY `Closed_Seq_#` (`Closed_Seq_num`) USING BTREE;

--
-- Indexes for table `InvoiceDetail`
--
ALTER TABLE `InvoiceDetail`
  ADD PRIMARY KEY (`Invoice_Index`),
  ADD KEY `InvoiceNumber` (`InvoiceNumber`) USING BTREE,
  ADD KEY `ItemCode` (`ItemCode`) USING BTREE;

--
-- Indexes for table `Item`
--
ALTER TABLE `Item`
  ADD PRIMARY KEY (`ItemCode`),
  ADD KEY `Category_Name` (`Category_Name`) USING BTREE,
  ADD KEY `Vendor_Name` (`Vendor_Name`) USING BTREE;

--
-- Indexes for table `POS_Defaults`
--
ALTER TABLE `POS_Defaults`
  ADD PRIMARY KEY (`Default_Index`),
  ADD UNIQUE KEY `User_Type` (`User_Type`);

--
-- Indexes for table `Purchase_Order`
--
ALTER TABLE `Purchase_Order`
  ADD PRIMARY KEY (`Purchase_Order_Index`) USING BTREE,
  ADD KEY `Vendor_Id` (`Vendor_Id`) USING BTREE,
  ADD KEY `Purchase_Order_Index` (`Purchase_Order_Index`) USING BTREE,
  ADD KEY `DateCreated` (`DateCreated`) USING BTREE;

--
-- Indexes for table `Purchase_Order_Detail`
--
ALTER TABLE `Purchase_Order_Detail`
  ADD PRIMARY KEY (`orderIndex`),
  ADD KEY `Vendor_Id` (`Vendor_Id`) USING BTREE,
  ADD KEY `Purchase_Order_Index` (`Purchase_Order_Index`) USING BTREE,
  ADD KEY `DateCreated` (`DateCreated`) USING BTREE;

--
-- Indexes for table `reportHeader`
--
ALTER TABLE `reportHeader`
  ADD PRIMARY KEY (`Closed_Seq_num`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`User_Id`),
  ADD UNIQUE KEY `User_Id` (`User_Id`),
  ADD UNIQUE KEY `User_Name` (`User_Name`),
  ADD KEY `User_Type` (`User_Type`) USING BTREE;

--
-- Indexes for table `Vendors`
--
ALTER TABLE `Vendors`
  ADD PRIMARY KEY (`Vendor_Id`),
  ADD KEY `Vendor_Id` (`Vendor_Name`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Category`
--
ALTER TABLE `Category`
  MODIFY `Category_index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `Invoice`
--
ALTER TABLE `Invoice`
  MODIFY `InvoiceNumber` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `InvoiceDetail`
--
ALTER TABLE `InvoiceDetail`
  MODIFY `Invoice_Index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `POS_Defaults`
--
ALTER TABLE `POS_Defaults`
  MODIFY `Default_Index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Purchase_Order`
--
ALTER TABLE `Purchase_Order`
  MODIFY `Purchase_Order_Index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `Purchase_Order_Detail`
--
ALTER TABLE `Purchase_Order_Detail`
  MODIFY `orderIndex` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT for table `reportHeader`
--
ALTER TABLE `reportHeader`
  MODIFY `Closed_Seq_num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `User_Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Vendors`
--
ALTER TABLE `Vendors`
  MODIFY `Vendor_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Invoice`
--
ALTER TABLE `Invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`Closed_Seq_num`) REFERENCES `reportHeader` (`Closed_Seq_num`);

--
-- Constraints for table `InvoiceDetail`
--
ALTER TABLE `InvoiceDetail`
  ADD CONSTRAINT `invoicedetail_ibfk_1` FOREIGN KEY (`InvoiceNumber`) REFERENCES `Invoice` (`InvoiceNumber`);

--
-- Constraints for table `Item`
--
ALTER TABLE `Item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`Category_Name`) REFERENCES `Category` (`Category_Name`),
  ADD CONSTRAINT `item_ibfk_2` FOREIGN KEY (`Vendor_Name`) REFERENCES `Vendors` (`Vendor_Name`);

--
-- Constraints for table `Purchase_Order`
--
ALTER TABLE `Purchase_Order`
  ADD CONSTRAINT `purchase_order_ibfk_2` FOREIGN KEY (`Vendor_Id`) REFERENCES `Vendors` (`Vendor_Id`);

--
-- Constraints for table `Purchase_Order_Detail`
--
ALTER TABLE `Purchase_Order_Detail`
  ADD CONSTRAINT `purchase_order_detail_ibfk_1` FOREIGN KEY (`Purchase_Order_Index`) REFERENCES `Purchase_Order` (`Purchase_Order_Index`),
  ADD CONSTRAINT `purchase_order_detail_ibfk_3` FOREIGN KEY (`Vendor_Id`) REFERENCES `Purchase_Order` (`Vendor_Id`);

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`User_Type`) REFERENCES `POS_Defaults` (`User_Type`);
