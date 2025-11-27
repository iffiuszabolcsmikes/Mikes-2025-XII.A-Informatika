-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2023 at 12:36 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oracle`
--

-- --------------------------------------------------------

--
-- Table structure for table `bonus`
--

CREATE TABLE `bonus` (
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `SAL` decimal(10,0) DEFAULT NULL,
  `COMM` decimal(10,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dept`
--

CREATE TABLE `dept` (
  `deptno` int(2) NOT NULL,
  `dname` varchar(50) NOT NULL,
  `loc` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dept`
--

INSERT INTO `dept` (`deptno`, `dname`, `loc`) VALUES
(10, 'Accounting', 'New York'),
(20, 'Research', 'Dallas'),
(30, 'Sales', 'Chicago'),
(40, 'Operations', 'Boston');

-- --------------------------------------------------------

--
-- Table structure for table `emp`
--

CREATE TABLE `emp` (
  `empno` int(4) NOT NULL,
  `ename` varchar(50) NOT NULL,
  `job` varchar(50) NOT NULL,
  `mgr` int(4) DEFAULT NULL,
  `hiredate` date DEFAULT NULL,
  `sal` decimal(10,2) DEFAULT NULL,
  `comm` decimal(10,2) DEFAULT NULL,
  `deptno` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp`
--

INSERT INTO `emp` (`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1993-06-13', '800.00', '0.00', 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1998-08-15', '1600.00', '300.00', 30),
(7521, 'WARD', 'SALESMAN', 7698, '1996-03-26', '1250.00', '500.00', 30),
(7566, 'JONES', 'MANAGER', 7839, '1995-10-31', '2975.00', NULL, 20),
(7698, 'BLAKE', 'MANAGER', 7839, '1992-06-11', '2850.00', NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1993-05-14', '2450.00', NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1996-03-05', '3000.00', NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1990-06-09', '5000.00', '0.00', 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1995-06-04', '1500.00', '0.00', 30),
(7876, 'ADAMS', 'CLERK', 7788, '1999-06-04', '1100.00', NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '2000-06-23', '950.00', NULL, 30),
(7934, 'MILLER', 'CLERK', 7782, '2000-01-21', '1300.00', NULL, 10),
(7902, 'FORD', 'ANALYST', 7566, '1997-12-05', '3000.00', NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1998-12-05', '1250.00', '1400.00', 30);

-- --------------------------------------------------------

--
-- Table structure for table `salgrade`
--

CREATE TABLE `salgrade` (
  `grade` int(4) NOT NULL,
  `losal` decimal(10,2) DEFAULT NULL,
  `hisal` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `salgrade`
--

INSERT INTO `salgrade` (`grade`, `losal`, `hisal`) VALUES
(1, '700.00', '1200.00'),
(2, '1201.00', '1400.00'),
(3, '1401.00', '2000.00'),
(4, '2001.00', '3000.00'),
(5, '3001.00', '99999.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dept`
--
ALTER TABLE `dept`
  ADD PRIMARY KEY (`deptno`);

--
-- Indexes for table `emp`
--
ALTER TABLE `emp`
  ADD PRIMARY KEY (`empno`);

--
-- Indexes for table `salgrade`
--
ALTER TABLE `salgrade`
  ADD PRIMARY KEY (`grade`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
