-- MySQL Script generated by MySQL Workbench
-- Qui 13 Abr 2017 19:24:13 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema scholar
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `scholar` ;

-- -----------------------------------------------------
-- Schema scholar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `scholar` DEFAULT CHARACTER SET utf8 ;
USE `scholar` ;

-- -----------------------------------------------------
-- Table `scholar`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`users` ;

CREATE TABLE IF NOT EXISTS `scholar`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `user_type` ENUM('Aluno', 'Funcionário', 'Professor') NOT NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`students` ;

CREATE TABLE IF NOT EXISTS `scholar`.`students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `rg` VARCHAR(20) NULL,
  `cpf` VARCHAR(15) NULL,
  `telephone` VARCHAR(20) NULL,
  `responsible_name` VARCHAR(255) NULL,
  `responsible_telephone` VARCHAR(20) NULL,
  `father_name` VARCHAR(255) NULL,
  `father_telephone` VARCHAR(20) NULL,
  `mother_name` VARCHAR(255) NULL,
  `mother_telephone` VARCHAR(20) NULL,
  `address` VARCHAR(255) NULL,
  `address_number` VARCHAR(10) NULL,
  `address_complement` VARCHAR(255) NULL,
  `address_zip_code` VARCHAR(10) NULL,
  `email` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_students_user_key` (`user_id` ASC),
  CONSTRAINT `fk_students_user_key`
    FOREIGN KEY (`user_id`)
    REFERENCES `scholar`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`modalities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`modalities` ;

CREATE TABLE IF NOT EXISTS `scholar`.`modalities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `min_modality_hour` INT NULL,
  `min_modality_days` INT NULL,
  `is_by_days` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`courses` ;

CREATE TABLE IF NOT EXISTS `scholar`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `modality_id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `course_hour_duration` INT NULL,
  `lesson_hour_duration` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_courses_modality_key` (`modality_id` ASC),
  CONSTRAINT `fk_courses_modality_key`
    FOREIGN KEY (`modality_id`)
    REFERENCES `scholar`.`modalities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`classrooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`classrooms` ;

CREATE TABLE IF NOT EXISTS `scholar`.`classrooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `day_shift` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_programs_course_key` (`course_id` ASC),
  CONSTRAINT `fk_programs_course_key`
    FOREIGN KEY (`course_id`)
    REFERENCES `scholar`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`calendars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`calendars` ;

CREATE TABLE IF NOT EXISTS `scholar`.`calendars` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`seasons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`seasons` ;

CREATE TABLE IF NOT EXISTS `scholar`.`seasons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `classroom_id` INT NOT NULL,
  `calendar_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `num_days` INT NULL,
  `is_finished` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_seasons_class_key` (`classroom_id` ASC),
  INDEX `idx_seasons_calendar_key` (`calendar_id` ASC),
  CONSTRAINT `fk_seasons_program_key`
    FOREIGN KEY (`classroom_id`)
    REFERENCES `scholar`.`classrooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seasons_calendar_key`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `scholar`.`calendars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`matriculations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`matriculations` ;

CREATE TABLE IF NOT EXISTS `scholar`.`matriculations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `season_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `date` DATE NULL,
  `is_canceled` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_matriculations_student_key` (`student_id` ASC),
  INDEX `idx_matriculations_season_key` (`season_id` ASC),
  CONSTRAINT `fk_matriculations_student_key`
    FOREIGN KEY (`student_id`)
    REFERENCES `scholar`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matriculations_season_key`
    FOREIGN KEY (`season_id`)
    REFERENCES `scholar`.`seasons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`subjects` ;

CREATE TABLE IF NOT EXISTS `scholar`.`subjects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `subject_hour_duration` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`professors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`professors` ;

CREATE TABLE IF NOT EXISTS `scholar`.`professors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `rg` VARCHAR(20) NULL,
  `cpf` VARCHAR(15) NULL,
  `telephone` VARCHAR(45) NULL,
  `address` VARCHAR(255) NULL,
  `address_number` VARCHAR(10) NULL,
  `address_complement` VARCHAR(255) NULL,
  `address_zip_code` VARCHAR(10) NULL,
  `email` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_professors_user_key` (`user_id` ASC),
  CONSTRAINT `fk_professors_user_key`
    FOREIGN KEY (`user_id`)
    REFERENCES `scholar`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`lessons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`lessons` ;

CREATE TABLE IF NOT EXISTS `scholar`.`lessons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `subjects_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `season_id` INT NOT NULL,
  `topic` VARCHAR(255) NULL,
  `description` TEXT NULL,
  `date` DATE NULL,
  `num_extra_lessons` INT NULL,
  `is_extra` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_lessons_subject_key` (`subjects_id` ASC),
  INDEX `idx_lessons_professor_key` (`professor_id` ASC),
  INDEX `idx_lessons_season_key` (`season_id` ASC),
  CONSTRAINT `fk_lessons_subject_key`
    FOREIGN KEY (`subjects_id`)
    REFERENCES `scholar`.`subjects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lessons_professor_key`
    FOREIGN KEY (`professor_id`)
    REFERENCES `scholar`.`professors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lessons_season_key`
    FOREIGN KEY (`season_id`)
    REFERENCES `scholar`.`seasons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`frequencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`frequencies` ;

CREATE TABLE IF NOT EXISTS `scholar`.`frequencies` (
  `matriculation_id` INT NOT NULL,
  `lesson_id` INT NOT NULL,
  `num_missed` INT NULL,
  PRIMARY KEY (`matriculation_id`, `lesson_id`),
  INDEX `idx_frequencies_lesson_key` (`lesson_id` ASC),
  INDEX `idx_frequencies_matriculation_season_key` (`matriculation_id` ASC),
  CONSTRAINT `fk_frequencies_lesson_key`
    FOREIGN KEY (`lesson_id`)
    REFERENCES `scholar`.`lessons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_frequencies_matriculation_season_key`
    FOREIGN KEY (`matriculation_id`)
    REFERENCES `scholar`.`matriculations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`schedules` ;

CREATE TABLE IF NOT EXISTS `scholar`.`schedules` (
  `subject_id` INT NOT NULL,
  `season_id` INT NOT NULL,
  `num_lessons` INT NULL,
  `day_week` VARCHAR(45) NULL,
  PRIMARY KEY (`subject_id`, `season_id`),
  INDEX `idx_schedules_subject_key` (`subject_id` ASC),
  INDEX `idx_schedules_season_key` (`season_id` ASC),
  CONSTRAINT `fk_schedules_subject_key`
    FOREIGN KEY (`subject_id`)
    REFERENCES `scholar`.`subjects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedules_season_key`
    FOREIGN KEY (`season_id`)
    REFERENCES `scholar`.`seasons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`vacations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`vacations` ;

CREATE TABLE IF NOT EXISTS `scholar`.`vacations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calendar_id` INT NOT NULL,
  `start_date` DATE NULL,
  `num_days` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_vacations_calendar_key` (`calendar_id` ASC),
  CONSTRAINT `fk_vacations_calendar_key`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `scholar`.`calendars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`holidays`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`holidays` ;

CREATE TABLE IF NOT EXISTS `scholar`.`holidays` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `num_days` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`calendar_holidays`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`calendar_holidays` ;

CREATE TABLE IF NOT EXISTS `scholar`.`calendar_holidays` (
  `calendar_id` INT NOT NULL,
  `holiday_id` INT NOT NULL,
  `start_day` INT NULL,
  `start_month` INT NULL,
  PRIMARY KEY (`calendar_id`, `holiday_id`),
  INDEX `idx_calendar_holidays_holiday_key` (`holiday_id` ASC),
  INDEX `idx_calendar_holidays_calendar_key` (`calendar_id` ASC),
  CONSTRAINT `fk_calendar_holidays_calendar_key`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `scholar`.`calendars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendar_holidays_holiday_key`
    FOREIGN KEY (`holiday_id`)
    REFERENCES `scholar`.`holidays` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scholar`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scholar`.`employees` ;

CREATE TABLE IF NOT EXISTS `scholar`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `rg` VARCHAR(20) NULL,
  `cpf` VARCHAR(15) NULL,
  `telephone` VARCHAR(45) NULL,
  `address` VARCHAR(255) NULL,
  `address_number` VARCHAR(10) NULL,
  `address_complement` VARCHAR(255) NULL,
  `address_zip_code` VARCHAR(10) NULL,
  `email` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_employees_user_key` (`user_id` ASC),
  CONSTRAINT `fk_employees_user_key`
    FOREIGN KEY (`user_id`)
    REFERENCES `scholar`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `scholar`;

DELIMITER $$

USE `scholar`$$
DROP TRIGGER IF EXISTS `scholar`.`students_AFTER_DELETE` $$
USE `scholar`$$
CREATE DEFINER = CURRENT_USER TRIGGER `scholar`.`students_AFTER_DELETE` AFTER DELETE ON `students` FOR EACH ROW
BEGIN

END
$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
