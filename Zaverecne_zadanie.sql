-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: localhost:3306
-- Čas generovania: Pi 14.Máj 2021, 10:41
-- Verzia serveru: 8.0.23-0ubuntu0.20.04.1
-- Verzia PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `Zaverecne_zadanie`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `correct_answer`
--

CREATE TABLE `correct_answer` (
  `id` bigint UNSIGNED NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `correct_question_option`
--

CREATE TABLE `correct_question_option` (
  `id` bigint UNSIGNED NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `question_option_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `question`
--

CREATE TABLE `question` (
  `id` bigint UNSIGNED NOT NULL,
  `test_id` bigint UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `answer` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `type` enum('SHORT_ANSWER','CHOICE','PAIR','DRAW','MATH') NOT NULL,
  `max_points` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `question_option`
--

CREATE TABLE `question_option` (
  `id` bigint UNSIGNED NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `type` enum('CHOICE','PAIR') NOT NULL,
  `value1` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value2` text CHARACTER SET utf8 COLLATE utf8_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `question_student`
--

CREATE TABLE `question_student` (
  `id` bigint UNSIGNED NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `student_id` varchar(10) NOT NULL,
  `type` enum('SHORT_ANSWER','CHOICE','PAIR','DRAW','MATH') NOT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `answer` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `answer_photo` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `points` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `question_student_choice_option`
--

CREATE TABLE `question_student_choice_option` (
  `id` bigint UNSIGNED NOT NULL,
  `question_student_id` bigint UNSIGNED NOT NULL,
  `question_option_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `question_student_option`
--

CREATE TABLE `question_student_option` (
  `id` bigint UNSIGNED NOT NULL,
  `question_student_id` bigint UNSIGNED NOT NULL,
  `value1` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value2` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `student`
--

CREATE TABLE `student` (
  `id` varchar(10) NOT NULL,
  `name` varchar(128) NOT NULL,
  `surname` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `student_action`
--

CREATE TABLE `student_action` (
  `id` bigint UNSIGNED NOT NULL,
  `student_id` varchar(10) NOT NULL,
  `test_id` bigint UNSIGNED NOT NULL,
  `action` enum('WRITING','FINISHED','OUT_OF_TAB') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `teacher`
--

CREATE TABLE `teacher` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `surname` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `test`
--

CREATE TABLE `test` (
  `id` bigint UNSIGNED NOT NULL,
  `teacher_id` bigint UNSIGNED NOT NULL,
  `title` varchar(128) NOT NULL,
  `code` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `duration` int NOT NULL,
  `test_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `correct_answer`
--
ALTER TABLE `correct_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexy pre tabuľku `correct_question_option`
--
ALTER TABLE `correct_question_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_option_fk` (`question_option_id`),
  ADD KEY `question_fk` (`question_id`);

--
-- Indexy pre tabuľku `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexy pre tabuľku `question_option`
--
ALTER TABLE `question_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexy pre tabuľku `question_student`
--
ALTER TABLE `question_student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `question_id` (`question_id`,`student_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexy pre tabuľku `question_student_choice_option`
--
ALTER TABLE `question_student_choice_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_student_id` (`question_student_id`),
  ADD KEY `question_option_id` (`question_option_id`);

--
-- Indexy pre tabuľku `question_student_option`
--
ALTER TABLE `question_student_option`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_student_id` (`question_student_id`);

--
-- Indexy pre tabuľku `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `student_action`
--
ALTER TABLE `student_action`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexy pre tabuľku `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `correct_answer`
--
ALTER TABLE `correct_answer`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `correct_question_option`
--
ALTER TABLE `correct_question_option`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `question`
--
ALTER TABLE `question`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `question_option`
--
ALTER TABLE `question_option`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `question_student`
--
ALTER TABLE `question_student`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `question_student_choice_option`
--
ALTER TABLE `question_student_choice_option`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `question_student_option`
--
ALTER TABLE `question_student_option`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `student_action`
--
ALTER TABLE `student_action`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `test`
--
ALTER TABLE `test`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `correct_answer`
--
ALTER TABLE `correct_answer`
  ADD CONSTRAINT `correct_answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `correct_question_option`
--
ALTER TABLE `correct_question_option`
  ADD CONSTRAINT `question_fk` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `question_option_fk` FOREIGN KEY (`question_option_id`) REFERENCES `question_option` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `question_option`
--
ALTER TABLE `question_option`
  ADD CONSTRAINT `question_option_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `question_student`
--
ALTER TABLE `question_student`
  ADD CONSTRAINT `question_student_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `question_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `question_student_choice_option`
--
ALTER TABLE `question_student_choice_option`
  ADD CONSTRAINT `question_student_choice_option_ibfk_1` FOREIGN KEY (`question_student_id`) REFERENCES `question_student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `question_student_choice_option_ibfk_2` FOREIGN KEY (`question_option_id`) REFERENCES `question_option` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `question_student_option`
--
ALTER TABLE `question_student_option`
  ADD CONSTRAINT `question_student_option_ibfk_1` FOREIGN KEY (`question_student_id`) REFERENCES `question_student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `student_action`
--
ALTER TABLE `student_action`
  ADD CONSTRAINT `student_action_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `student_action_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Obmedzenie pre tabuľku `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `test_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
