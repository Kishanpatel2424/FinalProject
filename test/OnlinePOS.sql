-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 03, 2017 at 10:48 PM
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
  `Closed_Seq_#` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Invoice`
--

INSERT INTO `Invoice` (`InvoiceNumber`, `InvoiceTotal`, `ChangeDue`, `PaymentType`, `Card_Token`, `Tax`, `Date`, `User_Id`, `Status`, `Closed_Seq_#`) VALUES
(1, 10.62, 0, 'Cash', NULL, 0.63, '2017-10-23', 1, 'Open', 1),
(5, 21.22, 3.78, 'Cash', NULL, 1.27, '2017-10-23', 1, 'Open', 1),
(6, 13.68, 0, 'Card', NULL, 0.69, '2017-11-08', 1, 'Open', 0),
(7, 8.49, 0, 'Card', 'zqpdxXo9M', 0.50, '2017-11-08', 1, 'Open', 0),
(8, 15.94, 0, 'Card', '8qpdLrGk7', 0.95, '2017-11-21', 1, 'Open', 0),
(9, 14.86, 0, 'Card', 'Kkb8A5jL7', 0.88, '2017-11-29', 1, 'Open', 0),
(10, 42.50, 2.5, 'Cash', NULL, 2.53, '2017-12-03', 1, 'Open', 0),
(11, 24.95, 0.05, 'Cash', NULL, 1.49, '2017-12-03', 1, 'Open', 0),
(12, 26.56, 3.44, 'Cash', NULL, 1.58, '2017-12-03', 1, 'Open', 0);

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
(1, 10, '45645', 'eghjf kewfljhb', '10.00', 1, '0.63', 10.63, '2017-12-03', 'Open', 'Kishan'),
(2, 10, '1', 'dish, kj.bd', '2.00', 2, '0.24', 4.24, '2017-12-03', 'Open', 'Kishan'),
(3, 11, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-03', 'Open', 'Kishan'),
(4, 11, '909090', 'jkhfbn kefnc', '4.49', 1, '0.29', 0.00, '2017-12-03', 'Open', 'Kishan'),
(5, 11, '909090', 'jkhfbn kefnc', '4.49', 2, '0.57', 0.00, '2017-12-03', 'Open', 'Kishan'),
(6, 12, '1', 'ladhjkfjsbvcx', '9.99', 1, '0.63', 0.00, '2017-12-03', 'Open', 'Kishan'),
(7, 12, '9823464', 'skjdfh ksdfh', '14.99', 1, '0.95', 0.00, '2017-12-03', 'Open', 'Kishan');

-- --------------------------------------------------------

--
-- Table structure for table `Item`
--

CREATE TABLE `Item` (
  `ItemCode` varchar(15) NOT NULL,
  `ItemName` varchar(50) NOT NULL DEFAULT 'No Item Name defined',
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
('00349580485', 'American Spirit Yellow', '9.09', '11.49', 2, 'Cigaretts', NULL, NULL, 'MTC'),
('087456968', 'American Spirit Black', '9.29', '11.49', 2, 'Cigaretts', NULL, NULL, 'MTC'),
('090994502', 'Talisker 10Yr 750 ml ', '53.00', '74.99', 2, 'Single Malt Scotch', 0, 3, 'B&B'),
('09325768372', 'Marlboro Reds ', '8.89', '11.25', 0, 'Cigaretts', NULL, NULL, 'MTC'),
('1', 'ladhjkfjsbvcx', '7.00', '9.99', NULL, 'MicItem', NULL, NULL, 'CDI'),
('122333', 'ksDfhjbvxc.n ', '1.00', '3.99', -8, 'Liquor', 0, 1, 'CDI'),
('23745849', 'Absolute Plain Vodka 1.75ml', '25.00', '34.99', NULL, 'Vodka', 0, 0, 'H&P'),
('23789465', 'Absolute Plain Vodka 750ml', '12.00', '21.99', 12, 'Vodka', 0, 0, 'H&P'),
('23894765', 'Kettle One Vodka 750 ml', '20.00', '29.99', 0, 'Vodka', 0, 0, 'B&B'),
('2903847', 'Glenfiddich 12 Yr 750ml', '30.00', '46.99', 0, 'Single Malt Scotch', 0, 2, 'B&B'),
('324567987', 'Talisker Storm 750 ml ', '69.99', '84.99', 5, 'Single Malt Scotch', 0, 2, 'CDI'),
('32875023', 'Marlboro Silver', '0.00', '8.89', 11, 'Cigaretts', NULL, NULL, 'MTC'),
('4395492364', 'Marlboro Gold', '8.89', '11.25', 0, 'Cigaretts', NULL, NULL, 'MTC'),
('44509659', 'Bacardi Gold 750 ml', '12.00', '17.99', 12, 'Rum', 0, 12, 'CDI'),
('453412', 'Abcdsre', '2.00', '3.99', 12, 'MicItem', NULL, NULL, 'B&B'),
('4563453', 'dfgvcsaddcvx', '2.00', '3.00', 0, 'Beer', 0, 0, 'ACE'),
('45645', 'Kihasjb', '3.00', '5.00', 1, 'MicItem', 0, 1, 'ACE'),
('4657839', 'Gordans Vodka 1.75 L', '12.00', '21.99', 0, 'Vodka', 0, 0, 'CDI'),
('677698765', 'ieorlkjh ewtr\'w;s', '10.00', '13.99', NULL, 'Beer', 20, NULL, 'Craft Beer'),
('823567484', 'Gray Goose', '22.00', '36.99', 0, 'Vodka', 0, 0, 'B&B'),
('876434678', 'Glenlevit 12 Yr 750 ml', '45.00', '59.99', 12, 'Single Malt Scotch', 0, 2, 'B&B'),
('89343748', 'kjSDHF ksjdhfsdh', '10.00', '19.99', 1, 'Vodka', NULL, 1, 'B&B'),
('901375', 'we;oird if;fehfs;dd ahfjdblcv', '8.00', '12.99', NULL, 'Wine', NULL, NULL, 'CDI'),
('909090', 'jkhfbn kefnc', '2.00', '4.49', NULL, 'Liquor', NULL, NULL, 'ACE'),
('923847098327', 'Oban 14 Yr 750 ml', '59.00', '74.99', 7, 'Single Malt Scotch', 0, 0, 'CDI'),
('9823464', 'skjdfh ksdfh', '10.00', '14.99', -1, 'Vodka', NULL, 2, 'New England Wine and Spirit'),
('988935662', 'Bacardi Gold Rum 1.75 L', '18.00', '29.99', 2, 'Rum', 0, 2, 'CDI'),
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
  `DateCreated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Purchase_Order`
--

INSERT INTO `Purchase_Order` (`Purchase_Order_Index`, `Vendor_Id`, `DateCreated`) VALUES
(6, 1, '0000-00-00 00:00:00'),
(11, 3, '2017-11-17 00:00:00'),
(12, 14, '2017-11-17 00:00:00'),
(13, 1, '2017-11-27 00:00:00'),
(14, 1, '2017-11-27 11:44:57'),
(15, 1, '2017-11-27 11:45:34'),
(16, 8, '2017-11-27 11:47:06'),
(17, 1, '2017-11-27 11:48:26'),
(18, 1, '2017-11-27 11:50:48'),
(19, 1, '2017-11-27 11:53:11');

-- --------------------------------------------------------

--
-- Table structure for table `Purchase_Order_Detail`
--

CREATE TABLE `Purchase_Order_Detail` (
  `orderIndex` int(11) NOT NULL,
  `Purchase_Order_Index` int(11) NOT NULL,
  `Vendor_Id` int(11) NOT NULL,
  `ItemCode` varchar(15) NOT NULL,
  `ItemPrice` decimal(6,2) NOT NULL,
  `ItemOrdered` int(11) NOT NULL,
  `DateCreated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Purchase_Order_Detail`
--

INSERT INTO `Purchase_Order_Detail` (`orderIndex`, `Purchase_Order_Index`, `Vendor_Id`, `ItemCode`, `ItemPrice`, `ItemOrdered`, `DateCreated`) VALUES
(1, 6, 1, '', '0.00', 0, '0000-00-00 00:00:00'),
(3, 13, 3, '', '0.00', 0, '2017-11-27 00:00:00'),
(5, 15, 1, '4563453', '0.00', 0, '2017-11-27 11:45:34'),
(7, 16, 8, '087456968', '0.00', 0, '2017-11-27 11:47:06'),
(8, 16, 8, '00349580485', '0.00', 0, '2017-11-27 11:47:06'),
(9, 16, 8, '4395492364', '0.00', 0, '2017-11-27 11:47:06'),
(10, 16, 8, '09325768372', '0.00', 0, '2017-11-27 11:47:06'),
(11, 16, 8, '32875023', '0.00', 0, '2017-11-27 11:47:06'),
(12, 17, 1, '4563453', '0.00', 0, '2017-11-27 11:48:26'),
(13, 17, 1, '909090', '0.00', 0, '2017-11-27 11:48:26'),
(14, 17, 1, '45645', '0.00', 0, '2017-11-27 11:48:26'),
(15, 18, 1, '4563453', '0.00', 2, '2017-11-27 11:50:48'),
(16, 18, 1, '909090', '0.00', 3, '2017-11-27 11:50:48'),
(17, 18, 1, '45645', '0.00', 1, '2017-11-27 11:50:48'),
(18, 19, 1, '4563453', '2.00', 3, '2017-11-27 11:53:11'),
(19, 19, 1, '909090', '2.00', 1, '2017-11-27 11:53:11'),
(20, 19, 1, '45645', '3.00', 1, '2017-11-27 11:53:11');

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
(1, 'Kishan', 'Kishan', 'Manager', '2017-12-03 10:15:36', '2017-11-29 10:22:40'),
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
(17, 'Star Distributor ', NULL, NULL);

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
  ADD KEY `User_Name` (`User_Id`) USING BTREE;

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
  MODIFY `InvoiceNumber` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `InvoiceDetail`
--
ALTER TABLE `InvoiceDetail`
  MODIFY `Invoice_Index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `POS_Defaults`
--
ALTER TABLE `POS_Defaults`
  MODIFY `Default_Index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Purchase_Order`
--
ALTER TABLE `Purchase_Order`
  MODIFY `Purchase_Order_Index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `Purchase_Order_Detail`
--
ALTER TABLE `Purchase_Order_Detail`
  MODIFY `orderIndex` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `User_Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Vendors`
--
ALTER TABLE `Vendors`
  MODIFY `Vendor_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `InvoiceDetail`
--
ALTER TABLE `InvoiceDetail`
  ADD CONSTRAINT `invoicedetail_ibfk_1` FOREIGN KEY (`InvoiceNumber`) REFERENCES `Invoice` (`InvoiceNumber`),
  ADD CONSTRAINT `invoicedetail_ibfk_2` FOREIGN KEY (`ItemCode`) REFERENCES `Item` (`ItemCode`);

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
  ADD CONSTRAINT `purchase_order_detail_ibfk_3` FOREIGN KEY (`Vendor_Id`) REFERENCES `Purchase_Order` (`Vendor_Id`),
  ADD CONSTRAINT `purchase_order_detail_ibfk_4` FOREIGN KEY (`DateCreated`) REFERENCES `Purchase_Order` (`DateCreated`);

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`User_Type`) REFERENCES `POS_Defaults` (`User_Type`);
