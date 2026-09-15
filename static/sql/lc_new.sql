-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 14, 2026 at 05:31 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lc_new`
--

-- --------------------------------------------------------

--
-- Table structure for table `batsmen_dismassals`
--

CREATE TABLE `batsmen_dismassals` (
  `id` int(11) NOT NULL,
  `fixtureID` int(4) NOT NULL,
  `team` int(2) NOT NULL,
  `playerName` varchar(36) NOT NULL,
  `playerSurname` varchar(36) NOT NULL,
  `fow` int(5) NOT NULL,
  `noDismissed` int(2) NOT NULL,
  `bowler` varchar(36) NOT NULL,
  `fielder` varchar(36) NOT NULL,
  `method` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `batsmen_dismassals`
--

INSERT INTO `batsmen_dismassals` (`id`, `fixtureID`, `team`, `playerName`, `playerSurname`, `fow`, `noDismissed`, `bowler`, `fielder`, `method`) VALUES
(17, 1, 1, 'Xander', 'Lategang', 21, 1, 'De Wet Viljoen', 'Noah Jansen', 'caught'),
(18, 1, 1, 'Von W', 'Louw', 25, 2, 'Jean-Luc Olivier', 'Noah Jansen', 'caught'),
(19, 1, 1, 'Xzander', 'Muller', 61, 3, 'Simion Kriel', 'Ruben le Grange', 'caught'),
(20, 1, 1, 'Kian', 'Joubert', 61, 4, 'Simion Kriel', 'None', 'lbw'),
(21, 1, 1, 'Steven', 'Steyl', 80, 5, 'Simion Kriel', 'None', 'bowled'),
(22, 1, 1, 'Tiaan', 'Hartman', 105, 6, 'Jean-Luc Olivier', 'None', 'lbw'),
(23, 1, 1, 'Marno', 'Botes', 144, 7, 'Jan-Oscar van Tonder', 'Noah Jansen', 'caught'),
(24, 1, 1, 'Johan', 'Bergh', 149, 8, 'Jan-Oscar van Tonder', 'Ruben le Grange', 'caught'),
(25, 1, 1, 'Jurgens', 'Steyn', 155, 9, 'Simion Kriel', 'None', 'bowled'),
(26, 1, 1, 'Stiaan', 'Groenewald', 157, 10, 'Marnus Notnagel', 'None', 'bowled'),
(27, 1, 2, 'Ruben', 'le Grange', 6, 1, 'Kian Joubert', 'None', 'bowled'),
(28, 1, 2, 'Jan-Oscar', 'van Tonder', 20, 2, 'Xzander Muller', 'Von W Louw', 'caught'),
(29, 1, 2, 'Marnus', 'Notnagel', 106, 3, 'Marno Botes', 'Johan Bergh', 'caught'),
(30, 1, 2, 'Noah', 'Jansen', 140, 4, 'Xander Lategan', 'Johan Bergh', 'caught'),
(31, 9, 1, 'Liam', 'Vermeulen', 8, 1, 'Jody Lawrence', 'Fritz de Beer', 'caught'),
(32, 9, 1, 'Cody', 'Niewoudt', 144, 2, 'Bradley Peterson', 'None', 'bowled'),
(33, 13, 2, 'Darius', 'de Goede', 6, 1, 'Hiram Ockhuis', 'Jean Bester', 'caught'),
(34, 13, 2, 'Aldo', 'Botha', 7, 2, 'Jean Bester', 'None', 'lbw'),
(35, 13, 2, 'Jay-C', 'Dikella', 100, 3, 'Alan-Juan Roberts', 'None', 'lbw'),
(36, 13, 2, 'Stiaan', 'Kotze', 122, 4, 'Josh de Freitas', 'Hiram Ockhuis', 'caught'),
(37, 13, 2, 'Krige', 'van Jaarsveld', 158, 5, 'Jean Bester', 'Pottas Smit', 'caught'),
(38, 13, 2, 'Jean', 'le Roux', 164, 6, 'Hiram Ockhuis', 'None', 'lbw'),
(39, 13, 2, 'Kian', 'Joubert', 246, 7, 'Arno van Staden', 'None', 'bowled'),
(40, 13, 2, 'Johan', 'Bergh', 250, 8, 'Arno van Staden', 'Hiram Ockhuis', 'caught'),
(41, 13, 2, 'Hein', 'Slabbert', 275, 9, 'Arno van Staden', 'Josh de Freitas', 'caught'),
(42, 13, 1, 'Christiaan', 'Hattingh', 9, 1, 'Jean le Roux', 'None', 'bowled'),
(43, 13, 1, 'Storm', 'Louw', 17, 2, 'Jean le Roux', 'None', 'bowled'),
(44, 13, 1, 'Jean', 'Bester', 20, 3, 'Jean le Roux', 'None', 'bowled'),
(45, 13, 1, 'Hiram', 'Ockhuis', 25, 4, 'Kian Joubert', 'None', 'bowled'),
(46, 13, 1, 'Taige', 'van Niekerk', 66, 5, 'Aldo Botha', 'None', 'bowled'),
(47, 13, 1, 'Arno', 'van Staden', 67, 6, 'Jay-C Dikella', 'Johan Bergh', 'stumped'),
(48, 13, 1, 'Josh', 'de Freitas', 72, 7, 'Jay-C Dikella', 'None', 'bowled'),
(49, 13, 1, 'Jordan', 'Samuels', 79, 8, 'Jay-C Dikella', 'None', 'bowled'),
(50, 13, 1, 'Pottas', 'Smit', 88, 9, 'Tiaan Hartman', 'None', 'bowled'),
(51, 13, 1, 'Alan-Juan', 'Roberts', 101, 10, 'Tiaan Hartman', 'Jay-C Dikella', 'caught'),
(52, 14, 2, 'Darius', 'de Goede', 5, 1, 'AD van der Westhuizen', 'Gustav Maass', 'caught');

-- --------------------------------------------------------

--
-- Table structure for table `batsmen_scores`
--

CREATE TABLE `batsmen_scores` (
  `id` int(11) NOT NULL,
  `fixtureID` int(2) NOT NULL,
  `team` int(2) NOT NULL,
  `batPos` int(2) NOT NULL,
  `playerName` varchar(36) NOT NULL,
  `playerSurname` varchar(36) NOT NULL,
  `runs` int(5) NOT NULL,
  `ballsFaced` int(5) NOT NULL,
  `4` int(5) NOT NULL,
  `6` int(5) NOT NULL,
  `notOut` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `batsmen_scores`
--

INSERT INTO `batsmen_scores` (`id`, `fixtureID`, `team`, `batPos`, `playerName`, `playerSurname`, `runs`, `ballsFaced`, `4`, `6`, `notOut`) VALUES
(29, 1, 1, 1, 'Xander', 'Lategang', 7, 15, 1, 0, 0),
(30, 1, 1, 2, 'Johan', 'Bergh', 69, 107, 11, 1, 0),
(31, 1, 1, 3, 'Von W', 'Louw', 1, 3, 0, 0, 0),
(32, 1, 1, 4, 'Xzander', 'Muller', 23, 19, 4, 1, 0),
(33, 1, 1, 5, 'Kian', 'Joubert', 0, 1, 0, 0, 0),
(34, 1, 1, 6, 'Steven', 'Steyl', 2, 14, 0, 0, 0),
(35, 1, 1, 7, 'Tiaan', 'Hartman', 8, 20, 1, 0, 0),
(36, 1, 1, 8, 'Marno', 'Botes', 5, 21, 0, 0, 0),
(37, 1, 1, 9, 'Tertius', 'Oosthuizen', 5, 17, 1, 0, 1),
(38, 1, 1, 10, 'Jurgens', 'Steyn', 1, 5, 0, 0, 0),
(39, 1, 1, 11, 'Stiaan', 'Groenewald', 1, 8, 0, 0, 0),
(40, 1, 2, 1, 'Ruben', 'le Grange', 2, 9, 0, 0, 0),
(41, 1, 2, 2, 'Marnus', 'Notnagel', 27, 70, 4, 0, 0),
(42, 1, 2, 3, 'Jan-Oscar', 'van Tonder', 13, 10, 1, 1, 0),
(43, 1, 2, 4, 'Noah', 'Jansen', 63, 77, 11, 0, 0),
(44, 1, 2, 6, 'Dane', 'Tolken', 3, 7, 0, 0, 1),
(45, 1, 2, 7, 'De Wet', 'Viljoen', 10, 8, 2, 0, 1),
(46, 9, 1, 1, 'Liam', 'Vermeulen', 8, 5, 2, 0, 0),
(47, 9, 1, 2, 'Cody', 'Niewoudt', 61, 41, 2, 4, 0),
(48, 9, 1, 3, 'Johan', 'Bergh', 91, 53, 5, 6, 1),
(49, 9, 1, 4, 'Keane', 'Solomons', 23, 21, 3, 0, 1),
(50, 13, 2, 1, 'Johan', 'Bergh', 138, 127, 11, 6, 0),
(51, 13, 2, 2, 'Darius', 'de Goede', 1, 11, 0, 0, 0),
(52, 13, 2, 3, 'Aldo', 'Botha', 0, 5, 0, 0, 0),
(53, 13, 2, 4, 'Jay-C', 'Dikella', 25, 53, 3, 0, 0),
(54, 13, 2, 5, 'Stiaan', 'Kotze', 10, 9, 0, 1, 0),
(55, 13, 2, 6, 'Krige', 'van Jaarsveld', 9, 23, 2, 0, 0),
(56, 13, 2, 7, 'Jean', 'le Roux', 1, 6, 0, 0, 0),
(57, 13, 2, 8, 'Kian', 'Joubert', 28, 42, 3, 1, 0),
(58, 13, 2, 9, 'Hein', 'Slabbert', 21, 10, 0, 2, 0),
(59, 13, 2, 10, 'Ruben', 'Botha', 21, 12, 2, 1, 1),
(60, 13, 2, 11, 'Tiaan', 'Hartman', 7, 6, 1, 0, 1),
(61, 13, 1, 1, 'Christiaan', 'Hattingh', 0, 14, 0, 0, 0),
(62, 13, 1, 2, 'Storm', 'Louw', 13, 18, 2, 0, 0),
(63, 13, 1, 3, 'Hiram', 'Ockhuis', 3, 12, 0, 0, 0),
(64, 13, 1, 4, 'Jean', 'Bester', 0, 3, 0, 0, 0),
(65, 13, 1, 5, 'Taige', 'van Niekerk', 5, 19, 0, 0, 0),
(66, 13, 1, 6, 'Josh', 'de Freitas', 24, 29, 5, 0, 0),
(67, 13, 1, 7, 'Arno', 'van Staden', 0, 1, 0, 0, 0),
(68, 13, 1, 8, 'Alan-Juan', 'Roberts', 18, 43, 3, 0, 0),
(69, 13, 1, 9, 'Jordan', 'Samuels', 1, 19, 0, 0, 0),
(70, 13, 1, 10, 'Pottas', 'Smit', 4, 2, 1, 0, 0),
(71, 13, 1, 11, 'Elijah', 'Robert', 4, 16, 1, 0, 1),
(72, 14, 2, 1, 'Johan', 'Bergh', 10, 21, 1, 0, 1),
(73, 14, 2, 2, 'Darius', 'de Goede', 1, 8, 0, 0, 0),
(74, 14, 2, 3, 'Aldo', 'Botha', 8, 27, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bowlers_scores`
--

CREATE TABLE `bowlers_scores` (
  `id` int(11) NOT NULL,
  `fixtureID` int(2) NOT NULL,
  `team` int(2) NOT NULL,
  `bowlPos` int(2) NOT NULL,
  `prevBowled` int(4) NOT NULL,
  `playerName` varchar(36) NOT NULL,
  `playerSurname` varchar(36) NOT NULL,
  `overs` float NOT NULL,
  `maidens` int(5) NOT NULL,
  `runs` int(5) NOT NULL,
  `wickets` int(5) NOT NULL,
  `noBalls` int(5) NOT NULL,
  `wides` int(5) NOT NULL,
  `byes` int(3) NOT NULL,
  `legByes` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bowlers_scores`
--

INSERT INTO `bowlers_scores` (`id`, `fixtureID`, `team`, `bowlPos`, `prevBowled`, `playerName`, `playerSurname`, `overs`, `maidens`, `runs`, `wickets`, `noBalls`, `wides`, `byes`, `legByes`) VALUES
(13, 1, 2, 1, 0, 'De Wet', 'Viljoen', 9, 1, 45, 1, 0, 8, 0, 0),
(14, 1, 2, 2, 0, 'Jean-Luc', 'Olivier', 10, 0, 40, 2, 2, 7, 0, 0),
(15, 1, 2, 3, 0, 'Simion', 'Kriel', 9, 2, 22, 4, 0, 4, 0, 0),
(16, 1, 2, 4, 0, 'Jan-Oscar', 'van Tonder', 9, 1, 45, 2, 1, 1, 0, 0),
(17, 1, 2, 5, 0, 'Marnus', 'Notnagel', 0.5, 0, 0, 1, 0, 0, 0, 0),
(18, 1, 1, 1, 30, 'Kian', 'Joubert', 6, 1, 27, 1, 1, 2, 0, 0),
(19, 1, 1, 2, 31, 'Xzander', 'Muller', 5.3, 2, 23, 1, 1, 2, 0, 0),
(20, 1, 1, 3, 0, 'Tiaan', 'Hartman', 5, 1, 19, 9, 9, 2, 0, 0),
(21, 1, 1, 4, 0, 'Steven', 'Steyl', 3, 0, 14, 0, 0, 2, 0, 0),
(22, 1, 1, 5, 0, 'Tertius', 'Oosthuizen', 5, 1, 17, 1, 0, 4, 0, 0),
(23, 1, 1, 6, 0, 'Xander', 'Lategan', 5, 0, 22, 1, 0, 0, 0, 0),
(24, 1, 1, 7, 0, 'Marno', 'Botes', 2, 0, 25, 1, 0, 4, 0, 0),
(25, 9, 2, 1, 14, 'Jody', 'Lawrence', 4, 0, 27, 1, 0, 3, 0, 0),
(26, 9, 2, 2, 13, 'Onke', 'Nyaku', 4, 0, 51, 0, 0, 3, 0, 0),
(27, 9, 2, 3, 12, 'Bradley', 'Peterson', 4, 0, 51, 1, 0, 0, 0, 0),
(28, 9, 2, 4, 11, 'Tashwin', 'Lukas', 4, 0, 51, 0, 0, 0, 0, 0),
(29, 9, 2, 5, 20, 'Leon', 'le Roux', 4, 1, 15, 0, 0, 0, 0, 0),
(30, 13, 1, 1, 0, 'Hiram', 'Ockhuis', 10, 2, 43, 2, 2, 5, 0, 0),
(31, 13, 1, 2, 0, 'Jean', 'Bester', 10, 1, 39, 2, 0, 2, 0, 0),
(32, 13, 1, 3, 0, 'Josh', 'de Freitas', 10, 0, 58, 1, 0, 7, 0, 0),
(33, 13, 1, 4, 0, 'Alan-Juan', 'Roberts', 9, 0, 64, 1, 0, 3, 0, 0),
(34, 13, 1, 5, 0, 'Taige', 'van Niekerk', 2, 0, 39, 0, 0, 6, 0, 0),
(35, 13, 1, 6, 0, 'Christiaan', 'Hattingh', 4, 0, 24, 0, 0, 5, 0, 0),
(36, 13, 1, 7, 49, 'Arno', 'van Staden', 3, 0, 34, 3, 2, 2, 0, 0),
(37, 13, 1, 8, 50, 'Pottas', 'Smit', 2, 0, 27, 0, 0, 3, 0, 0),
(38, 13, 2, 1, 0, 'Kian', 'Joubert', 6, 0, 22, 1, 0, 7, 0, 0),
(39, 13, 1, 2, 0, 'Jean', 'le Roux', 5.1, 0, 29, 3, 1, 8, 0, 0),
(40, 13, 2, 3, 0, 'Stiaan', 'Kotze', 0.5, 0, 11, 0, 0, 1, 0, 0),
(41, 13, 2, 4, 28, 'Jay-C', 'Dikella', 9, 0, 21, 3, 0, 4, 0, 0),
(42, 13, 2, 5, 0, 'Aldo', 'Botha', 5, 1, 11, 1, 0, 1, 0, 0),
(43, 13, 2, 6, 29, 'Tiaan', 'Hartman', 3.1, 1, 9, 2, 0, 0, 0, 0),
(44, 14, 1, 1, 9, 'AD', 'van der Westhuizen', 5.2, 3, 8, 1, 0, 1, 0, 0),
(45, 14, 1, 2, 8, 'Christiaan', 'Oosthuizen', 4, 0, 16, 0, 0, 4, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fixtures`
--

CREATE TABLE `fixtures` (
  `id` int(11) NOT NULL,
  `teamA` varchar(32) NOT NULL,
  `teamAID` int(4) NOT NULL,
  `teamB` varchar(32) NOT NULL,
  `teamBID` int(4) NOT NULL,
  `progress` int(1) NOT NULL,
  `status` varchar(64) NOT NULL,
  `datetime` datetime(6) NOT NULL,
  `venue` varchar(20) NOT NULL,
  `format` varchar(32) NOT NULL,
  `toss` varchar(64) NOT NULL,
  `capA` varchar(32) NOT NULL,
  `capB` varchar(32) NOT NULL,
  `wkA` varchar(32) NOT NULL,
  `wkB` varchar(32) NOT NULL,
  `leagueID` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fixtures`
--

INSERT INTO `fixtures` (`id`, `teamA`, `teamAID`, `teamB`, `teamBID`, `progress`, `status`, `datetime`, `venue`, `format`, `toss`, `capA`, `capB`, `wkA`, `wkB`, `leagueID`) VALUES
(1, 'HS Bellville U15A', 1, 'HS Durbanville U15A', 2, 4, 'HS Durbanville U15A won by 5 Wicket/s', '2023-10-21 09:00:00.000000', 'HS Bellville B-Field', 'Limited Overs (50)', 'HS Bellville U15A (Bat)', 'Johan Bergh', 'Ruben le Grange', 'Johan Bergh', 'Noah Jansen', 1),
(2, 'MI Backyard', 3, 'Royal Challengers Backyard', 4, 1, 'Fixture', '2025-01-03 16:00:00.000000', 'Backyard Lords', 'Backyard', 'TBD', 'None', 'None', 'None', 'None', 2),
(3, 'Backyard Super Kings', 5, 'Rajasthan Pavements', 6, 1, 'Fixture', '2025-01-03 17:00:00.000000', 'Backyard Lords', 'Backyard', 'TBD', 'None', 'None', 'None', 'None', 2),
(4, 'Rajasthan Pavements', 6, 'MI Backyard', 3, 1, 'Fixture', '2025-01-04 16:00:00.000000', 'Backyard Lords', 'Backyard', 'TBD', 'None', 'None', 'None', 'None', 2),
(5, 'Backyard Super Kings', 5, 'Royal Challengers Backyard', 4, 1, 'Fixture', '2025-01-04 17:00:00.000000', 'Backyard Lords', 'Backyard', 'TBD', 'None', 'None', 'None', 'None', 2),
(6, 'MI Backyard', 3, 'Backyard Super Kings', 5, 1, 'Fixture', '2025-01-05 16:00:00.000000', 'Backyard Lords', 'Backyard', 'TBD', 'None', 'None', 'None', 'None', 2),
(7, 'Rajasthan Pavements', 6, 'Royal Challengers Backyard', 4, 1, 'Fixture', '2025-01-05 17:00:00.000000', 'Backyard Lords', 'Backyard', 'TBD', 'None', 'None', 'None', 'None', 2),
(8, 'Team #1', 0, 'Team #2', 0, 1, 'Fixture', '2024-12-09 17:00:00.000000', 'Backyard Lords', 'Backyard', 'TBD', 'None', 'None', 'None', 'None', 2),
(9, 'Hollywoodbets Bellville CC', 7, 'Durbanville CC', 8, 2, 'Durbanville CC need 190 run/s from 120 balls', '2024-12-14 16:00:00.000000', 'Bellville A', '20/20 Overs', 'Durbanville CC (Bowl)', 'Cody Niewoudt', 'Fritz de Beer', 'Keane Solomons', 'Fritz de Beer', 3),
(10, 'CDA Royals U19', 9, 'CDA Spartans U19', 10, 2, 'CDA Spartans U19 won the toss and elected to bat first', '2024-12-21 09:00:00.000000', 'HS Brackenfell A', 'Limited Overs (50)', 'CDA Spartans U19 (Bat)', 'None', 'None', 'None', 'None', 3),
(11, 'CDA Phantoms U15', 11, 'CDA Guardians U15', 12, 2, '39 over/s remaining', '2024-12-21 09:00:00.000000', 'HS Brackenfell B', 'Limited Overs (50)', 'CDA Guardians U15 (Bowl)', 'None', 'None', 'None', 'None', 3),
(13, 'HS Brackenfell 2nd XI', 20, 'HS Bellville 2nd XI', 19, 4, 'HS Bellville 2nd XI won by 230 run/s', '2025-02-22 09:00:00.000000', 'HS Brackenfell B-Fie', 'Limited Overs (50)', 'HS Brackenfell 2nd XI (Bowl)', 'Jean Bester', 'Kian Joubert', 'Taige van Niekerk', 'Johan Bergh', 1),
(14, 'HS Bellville 1st XI', 13, 'HS Bellville 2nd XI', 19, 2, '40.4 over/s remaining', '2025-03-15 09:00:00.000000', 'HS Bellville A', 'Limited Overs (50)', 'HS Bellville 2nd XI (Bat)', 'Ruald Coetzee', 'Kian Joubert', 'Gustav Maass', 'Johan Bergh', 3);

-- --------------------------------------------------------

--
-- Table structure for table `leagues`
--

CREATE TABLE `leagues` (
  `id` int(11) NOT NULL,
  `leagueName` varchar(32) NOT NULL,
  `structure` varchar(32) NOT NULL,
  `region` varchar(32) NOT NULL,
  `season` varchar(32) NOT NULL,
  `totalTeams` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leagues`
--

INSERT INTO `leagues` (`id`, `leagueName`, `structure`, `region`, `season`, `totalTeams`) VALUES
(1, 'WP Schools', 'Schools', 'Western Province', '2023/2024', '0'),
(2, 'Backyard Premier League', 'Backyard', 'Western Province', '2024/2025', '4'),
(3, 'Club Friendlies', 'Club', 'Western Province', '2024/2025', '0'),
(4, 'Khaya Majola Week U19', 'Domestic', 'Western Province', '2024/2025', '4');

-- --------------------------------------------------------

--
-- Table structure for table `league_standings`
--

CREATE TABLE `league_standings` (
  `id` int(11) NOT NULL,
  `leagueID` int(4) NOT NULL,
  `teamName` varchar(32) NOT NULL,
  `teamID` int(4) NOT NULL,
  `matches` int(2) NOT NULL,
  `bonusPoints` int(2) NOT NULL,
  `win` int(2) NOT NULL,
  `loss` int(2) NOT NULL,
  `draw` int(2) NOT NULL,
  `tied` int(2) NOT NULL,
  `noResult` int(2) NOT NULL,
  `penalty` int(2) NOT NULL,
  `rr` int(2) NOT NULL,
  `nrr` int(2) NOT NULL,
  `totalPoints` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `league_standings`
--

INSERT INTO `league_standings` (`id`, `leagueID`, `teamName`, `teamID`, `matches`, `bonusPoints`, `win`, `loss`, `draw`, `tied`, `noResult`, `penalty`, `rr`, `nrr`, `totalPoints`) VALUES
(1, 2, 'MI Backyard', 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 2, 'Royal Challengers Backyard', 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 2, 'Backyard Super Kings', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 2, 'Rajasthan Pavements ', 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 4, 'Boland U19', 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 4, 'Western Province U19', 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 4, 'Lions U19', 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 4, 'Titans U19', 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `live_games`
--

CREATE TABLE `live_games` (
  `id` int(11) NOT NULL,
  `fixtureID` int(5) NOT NULL,
  `currentTeamInnings` int(1) NOT NULL,
  `firstTeamInnings` int(1) NOT NULL,
  `teamAScore` int(4) NOT NULL,
  `teamAWkts` int(2) NOT NULL,
  `teamAOvers` float NOT NULL,
  `teamAExtras` int(3) NOT NULL,
  `teamBScore` int(4) NOT NULL,
  `teamBWkts` int(2) NOT NULL,
  `teamBOvers` float NOT NULL,
  `teamBExtras` int(3) NOT NULL,
  `target` int(4) NOT NULL,
  `totalOvers` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `live_games`
--

INSERT INTO `live_games` (`id`, `fixtureID`, `currentTeamInnings`, `firstTeamInnings`, `teamAScore`, `teamAWkts`, `teamAOvers`, `teamAExtras`, `teamBScore`, `teamBWkts`, `teamBOvers`, `teamBExtras`, `target`, `totalOvers`) VALUES
(1, 1, 2, 1, 158, 10, 37.5, 36, 159, 5, 31.3, 38, 159, 50),
(2, 9, 2, 1, 189, 2, 20, 6, 0, 0, 0, 0, 190, 20),
(3, 10, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50),
(4, 11, 1, 1, 54, 3, 11, 5, 0, 0, 0, 0, 0, 50),
(6, 13, 1, 2, 108, 10, 29.1, 36, 338, 9, 50, 77, 339, 50),
(7, 14, 2, 2, 0, 0, 0, 0, 24, 1, 9.2, 5, 0, 50);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `teamName` varchar(32) NOT NULL,
  `teamLogo` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `teamName`, `teamLogo`) VALUES
(1, 'HS Bellville U15A', 'bellville_hs.png'),
(2, 'HS Durbanville U15A', 'durbanville_hs.png'),
(3, 'MI Backyard', 'mi_backyard.png'),
(4, 'Royal Challengers Backyard', 'royal_challengers_backyard.png'),
(5, 'Backyard Super Kings', 'backyard_super_kings.png'),
(6, 'Rajasthan Pavements', 'rajasthan_pavements.png'),
(7, 'Hollywoodbets Bellville CC', 'bellville_cc.png'),
(8, 'Durbanville Cricket Club', 'durbanville_cc.png'),
(9, 'CDA Royals U19', 'cda.png'),
(10, 'CDA Spartans U19', 'cda.png'),
(11, 'CDA Phantoms U15', 'cda.png'),
(12, 'CDA Guardians U15', 'cda.png'),
(13, 'HS Bellville 1st XI', 'bellville_hs.png'),
(14, 'HS Durbanville 1st XI', 'durbanville_hs.png'),
(15, 'Boland U19', 'boland.png'),
(16, 'Western Province U19', 'wp.png'),
(17, 'Lions U19', 'lions.png'),
(18, 'Titans U19', 'titans.png'),
(19, 'HS Bellville 2nd XI', 'bellville_hs.png'),
(20, 'HS Brackenfell 2nd XI', 'brackenfell_hs.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `batsmen_dismassals`
--
ALTER TABLE `batsmen_dismassals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `batsmen_scores`
--
ALTER TABLE `batsmen_scores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bowlers_scores`
--
ALTER TABLE `bowlers_scores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fixtures`
--
ALTER TABLE `fixtures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leagues`
--
ALTER TABLE `leagues`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `league_standings`
--
ALTER TABLE `league_standings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `live_games`
--
ALTER TABLE `live_games`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `batsmen_dismassals`
--
ALTER TABLE `batsmen_dismassals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `batsmen_scores`
--
ALTER TABLE `batsmen_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `bowlers_scores`
--
ALTER TABLE `bowlers_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `fixtures`
--
ALTER TABLE `fixtures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `leagues`
--
ALTER TABLE `leagues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `league_standings`
--
ALTER TABLE `league_standings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `live_games`
--
ALTER TABLE `live_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
