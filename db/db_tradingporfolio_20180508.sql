-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2018 at 06:24 AM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_tradingporfolio`
--

-- --------------------------------------------------------

--
-- Table structure for table `accountstock`
--

CREATE TABLE IF NOT EXISTS `accountstock` (
`id` bigint(20) NOT NULL,
  `accountid` varchar(50) NOT NULL,
  `openat` text NOT NULL COMMENT 'Tên công ty chứng khoán mở tài khoản',
  `buyfee` double NOT NULL COMMENT 'Phí mua %',
  `salefee` double NOT NULL COMMENT 'Phí bán %',
  `marginrate` double NOT NULL,
  `cardid` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL,
  `depositfee` double NOT NULL COMMENT 'Phí lưu ký/cổ phiếu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE IF NOT EXISTS `card` (
`id` bigint(20) NOT NULL,
  `cardid` varchar(20) NOT NULL,
  `account` varchar(250) NOT NULL,
  `image` text NOT NULL,
  `firstname` varchar(200) NOT NULL,
  `lastname` varchar(200) NOT NULL,
  `fullname` text NOT NULL,
  `companyname` text NOT NULL,
  `bankinfo` text NOT NULL,
  `taxcode` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telephone` varchar(100) NOT NULL,
  `mobilephone` varchar(255) NOT NULL,
  `password` varchar(50) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `activecode` varchar(50) NOT NULL,
  `added_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `addressline1` text NOT NULL,
  `addressline2` text NOT NULL,
  `birthdate` datetime NOT NULL,
  `gender` varchar(10) NOT NULL,
  `cardtype` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `zoneid` int(11) NOT NULL,
  `notes` text NOT NULL,
  `father` text NOT NULL,
  `mother` text NOT NULL,
  `fatherfone` text NOT NULL,
  `motherphone` text NOT NULL,
  `giaoho` text NOT NULL,
  `levelcode` varchar(50) NOT NULL,
  `deletedby` varchar(50) NOT NULL,
  `deleteddate` datetime NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `card`
--

INSERT INTO `card` (`id`, `cardid`, `account`, `image`, `firstname`, `lastname`, `fullname`, `companyname`, `bankinfo`, `taxcode`, `email`, `telephone`, `mobilephone`, `password`, `ip`, `approved`, `activecode`, `added_date`, `updated_date`, `addressline1`, `addressline2`, `birthdate`, `gender`, `cardtype`, `age`, `zoneid`, `notes`, `father`, `mother`, `fatherfone`, `motherphone`, `giaoho`, `levelcode`, `deletedby`, `deleteddate`) VALUES
(1, 'C1469642013', 'admin', '', 'Admin', 'Administrator', 'Administrator Admin', '', '', '', '', '', '', '', '', 0, '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '0000-00-00 00:00:00', '', 'staff', 0, 0, '', '', '', '', '', '', '', 'admin', '2017-12-13 14:41:58'),
(2, 'C1469642014', '', '', '', '', 'Nguyễn Văn Tèo', '', '', '', 'teo@gmail.com', '0908696993', '', '', '', 0, '', '2018-05-08 10:48:41', '2018-05-08 10:48:41', '', '', '0000-00-00 00:00:00', '', 'customer', 0, 0, '', '', '', '', '', '', '', '', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `card_location`
--

CREATE TABLE IF NOT EXISTS `card_location` (
`id` bigint(20) NOT NULL,
  `cardid` varchar(20) NOT NULL,
  `locationname` text NOT NULL,
  `contactname` text NOT NULL,
  `phone` text NOT NULL,
  `email` text NOT NULL,
  `addressline1` text NOT NULL,
  `addressline2` text NOT NULL,
  `city` text NOT NULL,
  `country` text NOT NULL,
  `postcode` varchar(45) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `card_location`
--

INSERT INTO `card_location` (`id`, `cardid`, `locationname`, `contactname`, `phone`, `email`, `addressline1`, `addressline2`, `city`, `country`, `postcode`) VALUES
(1, 'C1469642014', 'Default', '', '', '', '', '0', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `dividend`
--

CREATE TABLE IF NOT EXISTS `dividend` (
`id` bigint(20) NOT NULL,
  `dividendtype` varchar(20) NOT NULL COMMENT 'cash: Nhận bằng tiền\nstock: Nhận bằng cổ phiếu',
  `receivedate` date NOT NULL,
  `deadline` date NOT NULL,
  `symbol` varchar(50) NOT NULL,
  `accountid` varchar(50) NOT NULL,
  `transactionid` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `dividendrate` double NOT NULL,
  `quantity` double NOT NULL,
  `quantityallowbuy` double NOT NULL,
  `quantityallowreceive` double NOT NULL,
  `createdate` datetime NOT NULL,
  `createby` varchar(50) NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateby` varchar(50) NOT NULL,
  `deletedate` datetime NOT NULL,
  `deleteby` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE IF NOT EXISTS `invoice` (
`id` bigint(20) NOT NULL,
  `invoiceid` varchar(50) NOT NULL,
  `invoicedate` date NOT NULL,
  `transactionid` varchar(50) NOT NULL,
  `marginid` bigint(20) NOT NULL,
  `dividendid` bigint(20) NOT NULL,
  `invoicetype` varchar(20) NOT NULL COMMENT 'income: Nhận tiền\nexpenses: Chi tiền',
  `amount` double NOT NULL,
  `notes` text NOT NULL,
  `createdate` datetime NOT NULL,
  `createby` varchar(50) NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateby` varchar(50) NOT NULL,
  `deletedate` datetime NOT NULL,
  `deleteby` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE IF NOT EXISTS `item` (
`id` bigint(20) NOT NULL,
  `symbol` varchar(50) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `symbol`, `name`) VALUES
(1, 'CSM', 'Công ty Cổ phần Công nghiệp Cao su Miền Nam (HOSE)'),
(3, 'KPF', 'Công ty Cổ phần Đầu tư tài chính Hoàng Minh (HOSE)'),
(4, 'HAR', 'Công ty Cổ phần Đầu tư Thương mại Bất động sản An Dương Thảo Điền (HOSE)');

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language` (
`id` bigint(20) NOT NULL,
  `languageid` varchar(50) NOT NULL,
  `name` varchar(32) NOT NULL,
  `code` varchar(5) NOT NULL,
  `locale` varchar(255) NOT NULL,
  `image` varchar(64) DEFAULT NULL,
  `directory` varchar(32) NOT NULL,
  `filename` varchar(64) NOT NULL,
  `sortOrder` int(3) DEFAULT NULL,
  `status` int(1) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `languageid`, `name`, `code`, `locale`, `image`, `directory`, `filename`, `sortOrder`, `status`) VALUES
(1, 'vn', 'Việt Nam', 'vn', 'en_US.UTF-8,en_US,en-gb,vietnam', 'vn.png', 'vietnam', 'vietnam', 1, 1),
(2, 'en', 'English', 'en', 'en_US.UTF-8,en_US,en-gb,english', 'en.png', 'english', 'english', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
`id` bigint(20) NOT NULL,
  `locationname` text COLLATE utf8_unicode_ci NOT NULL,
  `xval` double NOT NULL,
  `yval` double NOT NULL,
  `parent` double NOT NULL,
  `sortorder` int(11) NOT NULL,
  `shipfee` double NOT NULL,
  `shipfeeorder` double NOT NULL,
  `freeshiporder` double NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=54 ;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `locationname`, `xval`, `yval`, `parent`, `sortorder`, `shipfee`, `shipfeeorder`, `freeshiporder`) VALUES
(1, 'Tp Hồ Chí Minh', 10.3423, 11.241231, 0, 1, 0, 0, 0),
(2, 'Quận 1', 0, 0, 1, 1, 15000, 20000, 200000),
(3, 'Quận 2', 0, 0, 1, 2, 25000, 20000, 300000),
(4, 'Quận 3', 0, 0, 1, 3, 25000, 20000, 300000),
(5, 'Quận 4', 0, 0, 1, 4, 25000, 20000, 300000),
(6, 'Quận 5', 0, 0, 1, 5, 25000, 25000, 400000),
(7, 'Quận 6', 0, 0, 1, 6, 25000, 25000, 400000),
(8, 'Quận 7', 0, 0, 1, 7, 28000, 25000, 400000),
(9, 'Quận 8', 0, 0, 1, 8, 25000, 0, 400000),
(10, 'Quận 9', 0, 0, 1, 9, 35000, 0, 700000),
(11, 'Quận 10', 0, 0, 1, 10, 25000, 0, 300000),
(12, 'Quận 11', 0, 0, 1, 11, 25000, 0, 300000),
(13, 'Quận 12', 0, 0, 1, 12, 35000, 0, 700000),
(14, 'Bình Thạnh', 0, 0, 1, 13, 25000, 0, 300000),
(15, 'Tân Bình', 0, 0, 1, 14, 25000, 20000, 300000),
(16, 'Phú Nhận', 0, 0, 1, 15, 25000, 20000, 500000),
(17, 'Bình Chánh', 0, 0, 1, 16, 35000, 0, 500000),
(18, 'Tân Phú', 0, 0, 1, 17, 35000, 0, 500000),
(19, 'Bình Tân', 0, 0, 1, 18, 35000, 0, 700000),
(20, 'Thủ Đức', 0, 0, 1, 19, 35000, 0, 500000),
(21, 'Hóc Môn', 0, 0, 1, 20, 35000, 0, 0),
(22, 'Nhà Bè', 0, 0, 1, 21, 35000, 0, 500000),
(23, 'Củ Chi', 0, 0, 1, 22, 0, 0, 0),
(24, 'Cần Giờ', 0, 0, 1, 23, 0, 0, 0),
(25, 'Gò Vấp', 0, 0, 1, 15, 25000, 0, 300000),
(26, 'Trang - thập cẩm', 0, 0, 14, 1, 50000, 0, 0),
(27, 'Bò NT', 0, 0, 4, 1, 25000, 0, 0),
(28, 'Bo THT', 0, 0, 11, 1, 25000, 0, 0),
(29, 'Rau DL', 0, 0, 11, 2, 25000, 0, 0),
(30, 'Lá chuối', 0, 0, 15, 1, 25000, 0, 0),
(31, 'Rau rừng', 0, 0, 2, 1, 15000, 0, 0),
(32, 'Khô cá dứa', 0, 0, 7, 1, 50000, 0, 0),
(33, 'Mì trứng', 0, 0, 7, 2, 25000, 0, 0),
(34, 'Dê', 0, 0, 8, 1, 35000, 0, 0),
(35, 'Bánh tét', 0, 0, 5, 1, 25000, 0, 0),
(36, 'Đậu hủ', 0, 0, 3, 1, 25000, 0, 0),
(37, 'Gạo', 0, 0, 4, 2, 25000, 0, 0),
(38, 'Rau song hành', 0, 0, 14, 2, 25000, 0, 0),
(39, 'Cua', 0, 0, 15, 2, 25000, 0, 0),
(40, 'Cá lagi', 0, 0, 6, 1, 50000, 0, 0),
(41, 'Cá Nha Trang', 0, 0, 2, 2, 25000, 0, 0),
(42, 'Rau nồi đất', 0, 0, 3, 2, 25000, 0, 0),
(43, 'Rau Củ chi', 0, 0, 15, 3, 25000, 0, 0),
(44, 'Giá - Thúy', 0, 0, 15, 4, 25000, 0, 0),
(45, 'Rau Kon Tum', 0, 0, 14, 3, 50000, 0, 0),
(46, 'Chả ghẹ', 0, 0, 14, 4, 50000, 0, 0),
(47, 'Chả mực', 0, 0, 15, 5, 50000, 0, 0),
(48, 'Cá PQ', 0, 0, 15, 6, 25000, 0, 0),
(49, 'Đi chợ', 0, 0, 2, 3, 15000, 0, 0),
(50, 'Mắm cá cơm', 0, 0, 15, 7, 25000, 0, 0),
(51, 'Lap xưởng', 0, 0, 5, 2, 25000, 0, 0),
(52, 'Cá Cà Mau', 0, 0, 25, 1, 50000, 0, 0),
(53, 'Bình Dương', 0, 0, 0, 2, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `margin`
--

CREATE TABLE IF NOT EXISTS `margin` (
`id` bigint(20) NOT NULL,
  `opendate` date NOT NULL,
  `closedate` date NOT NULL,
  `amount` double NOT NULL,
  `countdate` int(11) NOT NULL,
  `rate` double NOT NULL,
  `totalpay` double NOT NULL,
  `cardid` varchar(50) NOT NULL,
  `accountid` varchar(50) NOT NULL,
  `transactionid` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE IF NOT EXISTS `module` (
`id` bigint(20) NOT NULL,
  `areacode` varchar(10) NOT NULL,
  `moduleid` char(50) NOT NULL,
  `modulecode` varchar(250) NOT NULL,
  `modulename` text,
  `moduletype` varchar(10) NOT NULL,
  `position` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `modulepath` text NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=165 ;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`id`, `areacode`, `moduleid`, `modulecode`, `modulename`, `moduletype`, `position`, `status`, `modulepath`) VALUES
(1, 'module', 'module/none', 'module/none', 'None', 'code', 997, 'active', ''),
(2, 'module', 'module/group', 'module/group', 'Group', 'code', 998, 'active', ''),
(4, 'module', 'module/homepage', 'module/homepage', 'Home Page', 'code', 3, 'active', ''),
(5, 'module', 'module/information', 'module/information', 'Information', 'manage', 999, 'active', ''),
(6, 'module', 'module/news', 'module/news', 'News', 'manage', 4, 'active', ''),
(7, 'module', 'module/gallery', 'module/gallery', 'Gallery', 'manage', 5, 'active', ''),
(8, 'module', 'module/galleryalbum', 'module/galleryalbum', 'Gallery Album', 'manage', 6, 'active', ''),
(12, 'module', 'module/contactmap', 'module/contactmap', 'Contact includes map', 'manage', 1, 'active', ''),
(15, 'module', 'module/link', 'module/link', 'Link', 'manage', 12, 'active', ''),
(16, 'module', 'module/product', 'module/product', 'Product', 'manage', 13, 'active', ''),
(20, 'module', 'module/faq', 'module/faq', 'Q&amp;A', 'manage', 17, 'active', ''),
(54, 'module', 'module/groupsitemap', 'module/groupsitemap', 'Group Sitemap', 'code', 48, 'active', ''),
(58, 'module', 'module/cart', 'module/cart', 'Shopping Cart', 'code', 52, 'active', ''),
(59, 'module', 'module/active', 'module/active', 'Active Account', 'code', 53, 'active', ''),
(60, 'module', 'module/profile', 'module/profile', 'Profile', 'code', 54, 'active', ''),
(62, 'module', 'module/cartmember', 'module/cartmember', 'History Orders', 'code', 56, 'active', ''),
(161, 'addon', 'addon/dashboardbanner', 'addon/dashboardbanner', 'Dashboard Banner', 'manage', 1004, 'active', 'addon/banner'),
(64, 'module', 'module/groupallproduct', 'module/groupallproduct', 'Group All Products', 'code', 58, 'active', ''),
(66, 'module', 'module/productbytag', 'module/productbytag', 'Product By Tag', 'code', 60, 'active', ''),
(72, 'module', 'module/login', 'module/login', 'Login', 'code', 66, 'active', 'module/login'),
(73, 'module', 'module/smartcart', 'module/smartcart', 'Smart cart', 'code', 67, 'active', 'module/smartcart'),
(74, 'module', 'module/advancesearch', 'module/advancesearch', 'smartsearch', 'code', 68, 'active', 'module/advancesearch'),
(75, 'module', 'module/payment', 'module/payment', 'Payment', 'code', 69, 'active', 'module/payment'),
(157, 'module', 'module/customer', 'module/customer', 'Customer Management', 'manage', 1000, 'active', ''),
(83, 'module', 'module/register', 'module/register', 'Register', 'manage', 76, 'active', ''),
(93, 'module', 'module/searchproduct', 'module/searchproduct', 'Search Product', 'manage', 86, 'active', ''),
(96, 'module', 'module/blog', 'module/blog', 'Blog', 'manage', 89, 'active', ''),
(160, 'addon', 'addon/homeproduct', 'addon/homproduct', 'Home Product', 'code', 1003, 'active', ''),
(159, 'module', 'module/smartproduct', 'module/smartproduct', 'Smart Product', 'manage', 1002, 'active', 'module/smartproduct'),
(101, 'module', 'module/allblog', 'module/allblog', 'All Blog', 'code', 94, 'active', ''),
(102, 'module', 'module/sitemap', 'module/sitemap', 'Sitemap', 'code', 95, 'active', ''),
(108, 'module', 'module/tag', 'module/tag', 'tags Management', 'manage', 101, 'active', 'module/tag'),
(109, 'addon', 'addon/responsiveslider', 'addon/responsiveslider', 'ResponsiveSlider', 'manage', 102, 'active', 'addon/banner'),
(119, 'module', 'module/setting', 'module/setting', 'Setting', 'manage', 112, 'active', ''),
(123, 'module', 'module/advancecomment', 'module/advancecomment', 'Comment follow blog or product', 'manage', 116, 'active', 'module/advancecomment'),
(124, 'module', 'module/subject', 'module/subject', 'Subjects Management', 'manage', 117, 'active', 'module/subject'),
(125, 'module', 'module/smartcartonline', 'module/smartcartonline', 'Smartcart online', 'code', 118, 'active', ''),
(126, 'module', 'module/paymentonline', 'module/paymentonline', 'Payment Online', 'code', 119, 'active', ''),
(134, 'module', 'module/knowledgebase', 'module/knowledgebase', 'Knowledge Base', 'manage', 127, 'active', ''),
(136, 'module', 'module/groupproduct', 'module/groupproduct', 'Group Product', 'manage', 129, 'active', ''),
(164, 'addon', 'addon/receivedemail', 'addon/receivedemail', 'Received Email', 'manage', 1007, 'active', 'addon/receivedemail'),
(163, 'addon', 'addon/logoslider', 'addon/logoslider', 'Logo Slider', 'manage', 1006, 'active', 'addon/banner'),
(162, 'addon', 'addon/logobanner', 'addon/logobanner', 'Logo Banner', 'manage', 1005, 'active', 'addon/banner'),
(150, 'module', 'common/forgotpassword', 'common/forgotpassword', 'Forgot password', 'code', 143, 'active', ''),
(151, 'module', 'module/productcustomize', 'module/productcustomize', 'Product Customize', 'manage', 144, 'active', 'module/productcustomize'),
(152, 'module', 'module/booking', 'module/booking', 'Booking', 'code', 145, 'active', 'module/booking'),
(153, 'module', 'module/smartbooking', 'module/smartbooking', 'Smart Booking', 'code', 146, 'active', 'module/smartbooking');

-- --------------------------------------------------------

--
-- Table structure for table `site`
--

CREATE TABLE IF NOT EXISTS `site` (
`id` bigint(10) NOT NULL,
  `siteid` varchar(30) NOT NULL,
  `slogan` text NOT NULL,
  `logo` text NOT NULL,
  `symbol` text NOT NULL,
  `currency` varchar(20) NOT NULL,
  `contactemail` text NOT NULL,
  `contactemail2` text NOT NULL,
  `sitename` varchar(100) NOT NULL,
  `siteurl` text NOT NULL,
  `domain` varchar(100) NOT NULL,
  `language` varchar(20) NOT NULL,
  `pagetopic` text NOT NULL,
  `description` text NOT NULL,
  `keywords` text NOT NULL,
  `googleanalytics` text NOT NULL,
  `fb_appid` varchar(255) NOT NULL,
  `twitter_username` varchar(255) NOT NULL,
  `skinid` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL,
  `exchange_point` double NOT NULL,
  `paypal_emailmerchant` varchar(255) NOT NULL,
  `paypal_standard_currency` varchar(50) NOT NULL,
  `paypal_standard_transaction` varchar(50) NOT NULL,
  `paypal_standard_test` int(11) NOT NULL COMMENT '0: for test, 1: for real',
  `eway_api_key` varchar(255) NOT NULL,
  `eway_api_password` varchar(50) NOT NULL,
  `eway_api_currency` varchar(6) NOT NULL,
  `eway_api_transaction` varchar(50) NOT NULL,
  `eway_api_test` int(11) NOT NULL COMMENT '0: for test, 1: for real'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `site`
--

INSERT INTO `site` (`id`, `siteid`, `slogan`, `logo`, `symbol`, `currency`, `contactemail`, `contactemail2`, `sitename`, `siteurl`, `domain`, `language`, `pagetopic`, `description`, `keywords`, `googleanalytics`, `fb_appid`, `twitter_username`, `skinid`, `status`, `exchange_point`, `paypal_emailmerchant`, `paypal_standard_currency`, `paypal_standard_transaction`, `paypal_standard_test`, `eway_api_key`, `eway_api_password`, `eway_api_currency`, `eway_api_transaction`, `eway_api_test`) VALUES
(1, 'default', 'Because Your Dream', 'upload/ren-logo.png', 'upload/ren-nav.png', '', 'demen88@gmail.com', '', 'Shimmer Silver', 'http://www.shimmersilver.com', 'shimmersilver.com', 'vn, en', '', '', '', '', '123', '@username', 'default', 'Active', 1000, 'ZLtynpaNAJM=', '', '', 0, 'ZLtynpaNAJM=', 'ZLtynpaNAJM=', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `soft_setting`
--

CREATE TABLE IF NOT EXISTS `soft_setting` (
`id` bigint(20) NOT NULL,
  `settingcode` varchar(100) NOT NULL,
  `settingvalue` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `soft_setting`
--

INSERT INTO `soft_setting` (`id`, `settingcode`, `settingvalue`) VALUES
(1, 'companyname', 'Chợ Xổm'),
(2, 'logo', 'upload/setting/choxom_logo.png'),
(3, 'addressline1', ''),
(4, 'addressline2', ''),
(5, 'phone', '0916710044 / 0916810044'),
(6, 'hotline', ''),
(7, 'fax', ''),
(8, 'email', ''),
(9, 'currency', 'VNĐ'),
(10, 'currencyformate', 'đ'),
(11, 'softwareversion', '1.00'),
(12, 'currencyprefix', ''),
(13, 'currencysubfix', ''),
(14, 'companylongname', 'Chợ Xổm'),
(15, 'website', 'www.choxom.vn'),
(16, 'facebook', 'Chợ Xổm'),
(17, 'billfooter', 'Cảm ơn quý khách đã mua hàng ở Chợ Xổm');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE IF NOT EXISTS `transaction` (
`id` bigint(20) NOT NULL,
  `transactionid` varchar(50) NOT NULL,
  `accountid` varchar(50) NOT NULL,
  `cardid` varchar(45) NOT NULL,
  `transactiondate` date NOT NULL COMMENT 'T',
  `receivemoneydate` date NOT NULL COMMENT 'receivemoneydate +2 (T+2)',
  `receivestockdate` date NOT NULL COMMENT 'receivemoneydate + 3(T+3)',
  `symbol` varchar(50) NOT NULL,
  `name` text NOT NULL,
  `type` varchar(20) NOT NULL COMMENT 'buy/sale',
  `volume` double NOT NULL,
  `price` double NOT NULL,
  `fee` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `costofsale` double NOT NULL COMMENT 'Tình giá binh quân gia quyền đến thời điểm bán',
  `profit` double NOT NULL,
  `notes` text NOT NULL,
  `createdate` datetime NOT NULL,
  `createby` varchar(50) NOT NULL,
  `updatedate` datetime NOT NULL,
  `updateby` varchar(50) NOT NULL,
  `deletedate` datetime NOT NULL,
  `deleteby` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`id` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `usertypeid` varchar(20) NOT NULL,
  `username` text,
  `password` text,
  `fullname` text NOT NULL,
  `email` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `imagepath` text NOT NULL,
  `phone` text NOT NULL,
  `activedate` datetime NOT NULL,
  `updateddate` datetime NOT NULL,
  `deleteddate` datetime NOT NULL,
  `activeby` varchar(50) NOT NULL,
  `updatedby` varchar(50) NOT NULL,
  `deletedby` varchar(50) NOT NULL,
  `userip` varchar(50) NOT NULL,
  `permission` text NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `userid`, `usertypeid`, `username`, `password`, `fullname`, `email`, `status`, `imagepath`, `phone`, `activedate`, `updateddate`, `deleteddate`, `activeby`, `updatedby`, `deletedby`, `userip`, `permission`) VALUES
(1, 'admin', 'admin', 'admin', '827ccb0eea8a706c4c34a16891f84e7b', 'Administrator', 'demen88@gmail.com', 'active', 'upload/quoc_dung.jpg', '090 567 8893', '2016-08-19 14:32:22', '2017-05-24 16:32:51', '0000-00-00 00:00:00', 'admin', 'admin', '', '1.52.38.194', '["newsales","allsales","customerreturnproducts","newsales","allsales","customerreturnproducts","productlist","productadd","productedit","productdel","productpritamp","accountlist","accountadd","accountedit","accountdel"]');

-- --------------------------------------------------------

--
-- Table structure for table `usertype`
--

CREATE TABLE IF NOT EXISTS `usertype` (
`id` bigint(20) NOT NULL,
  `usertypeid` varchar(20) NOT NULL,
  `usertypename` text,
  `usertypeparent` varchar(20) NOT NULL,
  `permission` text
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `usertype`
--

INSERT INTO `usertype` (`id`, `usertypeid`, `usertypename`, `usertypeparent`, `permission`) VALUES
(1, 'admin', 'Admin', '0', ''),
(10, 'account', 'Kế toán', '', '["IROList","IROAdd","IROEdit","IRODel","IPOAdd","IPOList","IPOEdit","IPODel","ProductList","ProductAdd","ProductEdit","ProductDel","ProductPrintStamp","IROList","IROAdd","IROEdit","IRODel","EPCList","EPCAdd","EPCEdit","EPCDel","IPCList","IPCAdd","IPCEdit","IPCDel","EINList","EINAdd","EINEdit","EINDel","IINList","IINAdd","IINEdit","IINDel","EROList","EROAdd","EROEdit","ERODel","EDEList","EDEAdd","EDEEdit","EDEDel","incomeList","incomeAdd","incomeEdit","incomeDel","incomePrint","expenseList","expenseAdd","expenseEdit","expenseDel","expensePrint","accountsList","accountsAdd","accountsEdit","accountsDel","categoryList","categoryAdd","categoryEdit","categoryDel","manufacturerList","manufacturerAdd","manufacturerEdit","manufacturerDel","unitList","unitAdd","unitEdit","unitDel","cardList","cardAdd","cardEdit","cardDel","cardSetAcc","cardPermission","cardLocationAdd","cardLocationEdit","cardLocationDel","cardViewHistory","cardLiabilities","paymentmethodList","paymentmethodAdd","paymentmethodEdit","paymentmethodDel","jobList","jobAdd","jobEdit","jobDel","pricelevelList","pricelevelAdd","pricelevelEdit","pricelevelDel","taxList","taxAdd","taxEdit","taxDel"]'),
(9, 'saleretail', 'Sale Retail', '', '["ESAAdd","ESAList","ESAEdit","ESADel","ESAPrint"]'),
(11, 'cashier', 'Thu ngân', '', '["ESAAdd","ESAList","ESAEdit","ESADel","ESAPrint","IROList","IROAdd","IROEdit","IRODel","IPOList","ProductList","ProductAdd","cardList","cardAdd","cardEdit","cardLocationAdd","cardLocationEdit","cardLocationDel","cardViewHistory","cardLiabilities","jobList","jobAdd","pricelevelList","pricelevelAdd","pricelevelEdit","pricelevelDel","taxList","taxAdd","taxEdit"]');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accountstock`
--
ALTER TABLE `accountstock`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `card`
--
ALTER TABLE `card`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `card_location`
--
ALTER TABLE `card_location`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dividend`
--
ALTER TABLE `dividend`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `margin`
--
ALTER TABLE `margin`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site`
--
ALTER TABLE `site`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `soft_setting`
--
ALTER TABLE `soft_setting`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usertype`
--
ALTER TABLE `usertype`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accountstock`
--
ALTER TABLE `accountstock`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `card_location`
--
ALTER TABLE `card_location`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `dividend`
--
ALTER TABLE `dividend`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=54;
--
-- AUTO_INCREMENT for table `margin`
--
ALTER TABLE `margin`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `module`
--
ALTER TABLE `module`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=165;
--
-- AUTO_INCREMENT for table `site`
--
ALTER TABLE `site`
MODIFY `id` bigint(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `soft_setting`
--
ALTER TABLE `soft_setting`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `usertype`
--
ALTER TABLE `usertype`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
