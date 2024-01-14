-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2023-06-12 23:26:53
-- 服务器版本： 5.7.26
-- PHP 版本： 5.6.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `supermarket`
--

-- --------------------------------------------------------

--
-- 表的结构 `goodsinfo`
--

CREATE TABLE `goodsinfo` (
  `goodsid` int(11) NOT NULL,
  `goodsname` text COLLATE utf8_unicode_ci NOT NULL,
  `type` text COLLATE utf8_unicode_ci NOT NULL,
  `inventory` int(11) NOT NULL,
  `stockprice` double NOT NULL,
  `saleprice` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `goodsinfo`
--

INSERT INTO `goodsinfo` (`goodsid`, `goodsname`, `type`, `inventory`, `stockprice`, `saleprice`) VALUES
(1, 'bread', 'food', 20, 4.5, 6),
(2, 'banana', 'food', 0, 5, 8),
(3, 'footable', 'ball', 6, 50, 95),
(4, 'basketball', 'ball', 0, 5, 10),
(5, 'cake', 'food', 0, 5, 10),
(6, 'apple', 'food', 0, 3, 5);

-- --------------------------------------------------------

--
-- 表的结构 `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `login`
--

INSERT INTO `login` (`id`, `name`, `password`) VALUES
(1, 'root', 'root'),
(2, 'xiaoming', 'xiaoming'),
(3, 'test', 'test');

-- --------------------------------------------------------

--
-- 表的结构 `profitdata`
--

CREATE TABLE `profitdata` (
  `checkdate` date NOT NULL,
  `profitnumber` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `profitdata`
--

INSERT INTO `profitdata` (`checkdate`, `profitnumber`) VALUES
('2023-05-02', 400),
('2023-06-09', 15),
('2023-06-08', 0),
('2023-06-07', 0),
('2023-06-06', 0),
('2023-06-05', 0),
('2023-06-04', 0),
('2023-06-03', 0),
('2023-06-02', 15),
('2023-06-01', 0),
('2023-05-31', 0),
('2023-05-30', 0),
('2023-05-29', 0),
('2023-05-28', 0),
('2023-05-27', 0),
('2023-05-26', 0),
('2023-05-25', 0),
('2023-05-24', 0),
('2023-05-23', 0),
('2023-05-22', 0),
('2023-05-21', 0),
('2023-05-20', 0),
('2023-05-19', 0),
('2023-05-18', 0),
('2023-05-17', 0),
('2023-05-16', 0),
('2023-05-15', 0),
('2023-05-14', 0),
('2023-05-13', 0),
('2023-05-12', 0),
('2023-05-11', 0),
('2023-05-10', 0),
('2023-05-03', 0),
('2023-05-01', 0),
('2023-05-09', 10),
('2023-06-11', 0),
('2023-06-10', 0),
('2023-06-12', 0);

-- --------------------------------------------------------

--
-- 表的结构 `sale`
--

CREATE TABLE `sale` (
  `saleid` int(11) NOT NULL,
  `goodsname` text COLLATE utf8_unicode_ci NOT NULL,
  `saletime` date NOT NULL,
  `type` text COLLATE utf8_unicode_ci NOT NULL,
  `salenumber` int(11) NOT NULL,
  `saleunitprice` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `sale`
--

INSERT INTO `sale` (`saleid`, `goodsname`, `saletime`, `type`, `salenumber`, `saleunitprice`) VALUES
(2, 'banana', '2023-05-02', 'food', 20, 8),
(1, 'bread', '2023-05-02', 'food', 40, 6),
(3, 'footable', '2023-05-02', 'ball', 4, 95),
(4, 'basketball', '2023-05-02', 'ball', 4, 10),
(5, 'cake', '2023-05-02', 'food', 10, 10),
(7, 'bread', '2023-06-02', 'food', 10, 6),
(6, 'bread', '2023-06-09', 'food', 10, 6),
(8, 'bread', '2023-05-02', 'food', 20, 6);

-- --------------------------------------------------------

--
-- 表的结构 `stock`
--

CREATE TABLE `stock` (
  `stockid` int(11) NOT NULL,
  `goodsname` text COLLATE utf8_unicode_ci NOT NULL,
  `stocktime` date NOT NULL,
  `type` text COLLATE utf8_unicode_ci NOT NULL,
  `stocknumber` int(11) NOT NULL,
  `stockunitprice` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `stock`
--

INSERT INTO `stock` (`stockid`, `goodsname`, `stocktime`, `type`, `stocknumber`, `stockunitprice`) VALUES
(1, 'bread', '2023-05-01', 'food', 50, 4.5),
(2, 'banana', '2023-05-01', 'food', 20, 5),
(3, 'footable', '2023-05-01', 'ball', 10, 50),
(4, 'basketball', '2023-05-01', 'ball', 4, 5),
(5, 'cake', '2023-05-01', 'food', 10, 5),
(6, 'bread', '2023-06-02', 'food', 20, 4.5),
(7, 'bread', '2023-06-05', 'food', 20, 4.5),
(8, 'bread', '2023-06-02', 'food', 10, 4.5);

--
-- 转储表的索引
--

--
-- 表的索引 `goodsinfo`
--
ALTER TABLE `goodsinfo`
  ADD PRIMARY KEY (`goodsid`);

--
-- 表的索引 `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`saleid`);

--
-- 表的索引 `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`stockid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `goodsinfo`
--
ALTER TABLE `goodsinfo`
  MODIFY `goodsid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `sale`
--
ALTER TABLE `sale`
  MODIFY `saleid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `stock`
--
ALTER TABLE `stock`
  MODIFY `stockid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
