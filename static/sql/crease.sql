-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 17, 2026 at 10:19 AM
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
-- Database: `crease_v2`
--

-- --------------------------------------------------------

--
-- Table structure for table `batsmen_dismissals`
--

CREATE TABLE `batsmen_dismissals` (
  `id` int(10) NOT NULL,
  `innings_id` int(10) NOT NULL,
  `batting_innings_id` int(10) NOT NULL COMMENT 'the dismissed batter''s row in batting_innings - one dismissal per batting line',
  `player_id` int(10) NOT NULL COMMENT 'the batter dismissed (denormalised from batting_innings for convenient joins)',
  `fow_runs` int(5) NOT NULL COMMENT 'team score at the moment this wicket fell',
  `dismissal_type` enum('bowled','caught','lbw','run_out','stumped','hit_wicket','retired_out','obstructing_field') NOT NULL,
  `bowler_id` int(10) DEFAULT NULL COMMENT 'NULL for run_out / obstructing_field - no bowler is credited with those',
  `fielder_id` int(10) DEFAULT NULL COMMENT 'catcher / run-out fielder / stumping keeper, where applicable'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `batting_innings`
--

CREATE TABLE `batting_innings` (
  `id` int(10) NOT NULL,
  `innings_id` int(10) NOT NULL,
  `player_id` int(10) NOT NULL,
  `bat_position` int(2) NOT NULL,
  `runs` int(5) NOT NULL,
  `balls_faced` int(5) NOT NULL,
  `fours` int(3) NOT NULL,
  `sixes` int(3) NOT NULL,
  `is_not_out` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bowling_innings`
--

CREATE TABLE `bowling_innings` (
  `id` int(10) NOT NULL,
  `innings_id` int(10) NOT NULL,
  `player_id` int(10) NOT NULL,
  `bowl_position` int(3) NOT NULL,
  `overs_bowled` decimal(4,1) NOT NULL,
  `maidens` int(4) NOT NULL,
  `runs_conceded` int(5) NOT NULL,
  `wickets` int(2) NOT NULL,
  `wides` int(5) NOT NULL,
  `no_balls` int(5) NOT NULL,
  `last_bowled_over` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fixtures`
--

CREATE TABLE `fixtures` (
  `id` int(10) NOT NULL,
  `league_id` int(10) NOT NULL,
  `team_a_id` int(10) NOT NULL,
  `team_b_id` int(10) NOT NULL,
  `venue` varchar(64) NOT NULL,
  `match_format` varchar(32) NOT NULL,
  `overs_limit` int(4) DEFAULT NULL,
  `scheduled_at` datetime NOT NULL,
  `progress` varchar(128) NOT NULL,
  `status_text` varchar(128) DEFAULT NULL,
  `toss_text` varchar(128) DEFAULT NULL,
  `toss_won_by_id` int(10) DEFAULT NULL,
  `captain_a_id` int(10) NOT NULL,
  `captain_b_id` int(11) NOT NULL,
  `wk_a_id` int(10) NOT NULL,
  `wk_b_id` int(10) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `innings`
--

CREATE TABLE `innings` (
  `id` int(10) NOT NULL,
  `fixture_id` int(10) NOT NULL,
  `innings_no` int(1) NOT NULL,
  `batting_team_id` int(10) NOT NULL,
  `bowling_team_id` int(5) NOT NULL,
  `runs` int(5) NOT NULL,
  `wickets` int(2) NOT NULL,
  `overs_bowled` decimal(4,1) NOT NULL,
  `byes` int(4) NOT NULL,
  `leg_byes` int(4) NOT NULL,
  `wides` int(4) NOT NULL,
  `no_balls` int(4) NOT NULL,
  `penalty_runs` int(4) NOT NULL,
  `target` int(5) DEFAULT NULL,
  `is_declared` tinyint(1) NOT NULL,
  `is_complete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leagues`
--

CREATE TABLE `leagues` (
  `id` int(10) NOT NULL,
  `league_name` varchar(64) NOT NULL,
  `structure` varchar(32) NOT NULL,
  `region` varchar(64) NOT NULL,
  `season` varchar(16) NOT NULL,
  `has_table` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(10) NOT NULL,
  `team_name` varchar(64) NOT NULL,
  `short_name` varchar(5) DEFAULT NULL,
  `team_logo` varchar(128) NOT NULL DEFAULT 'default_1.png',
  `parent_team_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `batsmen_dismissals`
--
ALTER TABLE `batsmen_dismissals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_dismissal_batting_innings` (`batting_innings_id`),
  ADD KEY `innings_id` (`innings_id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `bowler_id` (`bowler_id`),
  ADD KEY `fielder_id` (`fielder_id`);

--
-- Indexes for table `batting_innings`
--
ALTER TABLE `batting_innings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `innings_id` (`innings_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `bowling_innings`
--
ALTER TABLE `bowling_innings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `innings_id` (`innings_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `fixtures`
--
ALTER TABLE `fixtures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `league_id` (`league_id`),
  ADD KEY `team_a_id` (`team_a_id`),
  ADD KEY `team_b_id` (`team_b_id`),
  ADD KEY `captain_a_id` (`captain_a_id`),
  ADD KEY `captain_b_id` (`captain_b_id`),
  ADD KEY `wk_a_id` (`wk_a_id`),
  ADD KEY `wk_b_id` (`wk_b_id`),
  ADD KEY `toss_won_by_id` (`toss_won_by_id`);

--
-- Indexes for table `innings`
--
ALTER TABLE `innings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fixture_id` (`fixture_id`),
  ADD KEY `batting_team_id` (`batting_team_id`),
  ADD KEY `bowling_team_id` (`bowling_team_id`);

--
-- Indexes for table `leagues`
--
ALTER TABLE `leagues`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
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
-- AUTO_INCREMENT for table `batsmen_dismissals`
--
ALTER TABLE `batsmen_dismissals`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `batting_innings`
--
ALTER TABLE `batting_innings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bowling_innings`
--
ALTER TABLE `bowling_innings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fixtures`
--
ALTER TABLE `fixtures`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `innings`
--
ALTER TABLE `innings`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leagues`
--
ALTER TABLE `leagues`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `batsmen_dismissals`
--
ALTER TABLE `batsmen_dismissals`
  ADD CONSTRAINT `fk_dismissal_batting_innings` FOREIGN KEY (`batting_innings_id`) REFERENCES `batting_innings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dismissal_bowler` FOREIGN KEY (`bowler_id`) REFERENCES `players` (`id`),
  ADD CONSTRAINT `fk_dismissal_fielder` FOREIGN KEY (`fielder_id`) REFERENCES `players` (`id`),
  ADD CONSTRAINT `fk_dismissal_innings` FOREIGN KEY (`innings_id`) REFERENCES `innings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dismissal_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
