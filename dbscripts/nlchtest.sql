SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nlch
-- -----------------------------------------------------
-- This is the schema containing all the needed tables for nlch
CREATE SCHEMA IF NOT EXISTS `nlch` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `nlch` ;

-- -----------------------------------------------------
-- Table `nlch`.`child_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_address` (
  `child_address_pk` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NULL,
  `area` VARCHAR(100) NULL,
  `taluk` VARCHAR(100) NULL,
  `city_town` VARCHAR(100) NULL,
  `state` VARCHAR(100) NULL,
  `country` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`child_address_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`gen_genders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`gen_genders` (
  `gender_pk` INT NOT NULL AUTO_INCREMENT,
  `gender` VARCHAR(45) NULL,
  PRIMARY KEY (`gender_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`gen_languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`gen_languages` (
  `language_pk` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`language_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`gen_religions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`gen_religions` (
  `religion_pk` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`religion_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child` (
  `child_pk` INT NOT NULL AUTO_INCREMENT,
  `child_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `dob` DATE NOT NULL,
  `place_of_birth` VARCHAR(45) NOT NULL,
  `gender_fk` INT NOT NULL,
  `mother_tongue_fk` INT NOT NULL,
  `religion_fk` INT NOT NULL,
  `address_fk` INT NOT NULL,
  `physical_defects` VARCHAR(200) NULL,
  `reason` VARCHAR(255) NULL DEFAULT 'none',
  PRIMARY KEY (`child_pk`),
  INDEX `address_fk_idx` (`address_fk` ASC),
  UNIQUE INDEX `child_id_UNIQUE` (`child_id` ASC),
  INDEX `gender_fk_idx` (`gender_fk` ASC),
  INDEX `mother_tongue_fk_idx` (`mother_tongue_fk` ASC),
  INDEX `religion_fk_idx` (`religion_fk` ASC),
  CONSTRAINT `address_fk`
    FOREIGN KEY (`address_fk`)
    REFERENCES `nlch`.`child_address` (`child_address_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `gender_fk`
    FOREIGN KEY (`gender_fk`)
    REFERENCES `nlch`.`gen_genders` (`gender_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mother_tongue_fk`
    FOREIGN KEY (`mother_tongue_fk`)
    REFERENCES `nlch`.`gen_languages` (`language_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `religion_fk`
    FOREIGN KEY (`religion_fk`)
    REFERENCES `nlch`.`gen_religions` (`religion_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_identify_marks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_identify_marks` (
  `identify_marks_pk` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `mark` VARCHAR(200) NULL,
  PRIMARY KEY (`identify_marks_pk`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_parent_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_parent_status` (
  `parent_status_pk` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(200) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`parent_status_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_parents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_parents` (
  `parent_pk` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `name` VARCHAR(200) NULL,
  `status_fk` INT NULL,
  `occupation` VARCHAR(45) NULL,
  PRIMARY KEY (`parent_pk`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  INDEX `status_fk_idx` (`status_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_fk`
    FOREIGN KEY (`status_fk`)
    REFERENCES `nlch`.`nlch_parent_status` (`parent_status_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`gen_yn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`gen_yn` (
  `yn_pk` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`yn_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_siblings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_siblings` (
  `siblings_pk` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `current_program_fk` INT NOT NULL,
  `details` VARCHAR(45) NULL,
  PRIMARY KEY (`siblings_pk`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  INDEX `current_program_fk_idx` (`current_program_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `current_program_fk`
    FOREIGN KEY (`current_program_fk`)
    REFERENCES `nlch`.`gen_yn` (`yn_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_fiscal_years`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_fiscal_years` (
  `fiscal_year_pk` INT NOT NULL AUTO_INCREMENT,
  `year` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`fiscal_year_pk`),
  UNIQUE INDEX `year_UNIQUE` (`year` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_programs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_programs` (
  `programs_pk` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`programs_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_document_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_document_type` (
  `document_type_pk` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`document_type_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_documents` (
  `documents_id` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `date` DATE NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `path` VARCHAR(45) NOT NULL,
  `type_fk` INT NOT NULL,
  PRIMARY KEY (`documents_id`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  INDEX `document_fk_idx` (`type_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `document_fk`
    FOREIGN KEY (`type_fk`)
    REFERENCES `nlch`.`nlch_document_type` (`document_type_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_sponsors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_sponsors` (
  `sponsors_pk` INT NOT NULL,
  `child_fk` INT NOT NULL,
  `type_fk` INT NOT NULL,
  `category_fk` INT NOT NULL,
  `active_fk` INT NOT NULL,
  `date` DATE NULL,
  `child_sponsor_detailscol` VARCHAR(45) NULL,
  PRIMARY KEY (`sponsors_pk`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_photos` (
  `photos_pk` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `date` VARCHAR(45) NULL,
  `photo_path` VARCHAR(200) NULL,
  `meta` VARCHAR(45) NULL,
  PRIMARY KEY (`photos_pk`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`gen_month`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`gen_month` (
  `month_pk` INT NOT NULL AUTO_INCREMENT,
  `month_name` VARCHAR(60) NULL,
  PRIMARY KEY (`month_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_finance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_finance` (
  `finance_pk` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `month_fk` INT NOT NULL,
  `fiscal_year_fk` INT NOT NULL,
  `date` VARCHAR(45) NULL,
  `comments` VARCHAR(100) NULL,
  `active_fk` INT NULL,
  PRIMARY KEY (`finance_pk`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  INDEX `month_fk_idx` (`month_fk` ASC),
  INDEX `fiscal_year_fk_idx` (`fiscal_year_fk` ASC),
  INDEX `active_fk_idx` (`active_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `month_fk`
    FOREIGN KEY (`month_fk`)
    REFERENCES `nlch`.`gen_month` (`month_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fiscal_year_fk`
    FOREIGN KEY (`fiscal_year_fk`)
    REFERENCES `nlch`.`nlch_fiscal_years` (`fiscal_year_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `active_fk`
    FOREIGN KEY (`active_fk`)
    REFERENCES `nlch`.`gen_yn` (`yn_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`finance_sponsor_amount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`finance_sponsor_amount` (
  `sponsor_amount_pk` INT NOT NULL AUTO_INCREMENT,
  `finance_fk` INT NOT NULL,
  `sponsor_name` VARCHAR(45) NULL,
  `sponsor_amount` INT NULL,
  PRIMARY KEY (`sponsor_amount_pk`),
  INDEX `finance_fk_idx` (`finance_fk` ASC),
  CONSTRAINT `finance_fk`
    FOREIGN KEY (`finance_fk`)
    REFERENCES `nlch`.`child_finance` (`finance_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`finance_expense_amount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`finance_expense_amount` (
  `expense_amount_pk` INT NOT NULL,
  `finance_fk` INT NOT NULL,
  `expense_name` VARCHAR(45) NOT NULL,
  `amount` FLOAT NOT NULL,
  PRIMARY KEY (`expense_amount_pk`),
  INDEX `finance_fk_idx` (`finance_fk` ASC),
  CONSTRAINT `finance_fk`
    FOREIGN KEY (`finance_fk`)
    REFERENCES `nlch`.`child_finance` (`finance_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_locations` (
  `location_pk` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`location_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_staff` (
  `staff_pk` INT NOT NULL AUTO_INCREMENT,
  `staff_id` VARCHAR(45) NULL,
  `name` VARCHAR(100) NOT NULL,
  `designation` VARCHAR(45) NOT NULL,
  `location_fk` INT NULL,
  `address` VARCHAR(200) NULL,
  `comments` VARCHAR(200) NULL,
  PRIMARY KEY (`staff_pk`),
  INDEX `location_fk_idx` (`location_fk` ASC),
  UNIQUE INDEX `staff_id_UNIQUE` (`staff_id` ASC),
  CONSTRAINT `location_fk`
    FOREIGN KEY (`location_fk`)
    REFERENCES `nlch`.`nlch_locations` (`location_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_student_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_student_status` (
  `status_pk` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`status_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_program` (
  `program_pk` INT NOT NULL AUTO_INCREMENT,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `child_fk` INT NOT NULL,
  `type_fk` INT NOT NULL,
  `location_fk` INT NOT NULL,
  `pc_fk` INT NOT NULL,
  `tl_fk` INT NULL,
  `status_fk` INT NOT NULL,
  `fiscal_year_fk` INT NOT NULL,
  PRIMARY KEY (`program_pk`),
  INDEX `child_fk_idx` (`child_fk` ASC),
  INDEX `program_type_fk_idx` (`type_fk` ASC),
  INDEX `location_fk_idx` (`location_fk` ASC),
  INDEX `pc_fk_idx` (`pc_fk` ASC),
  INDEX `tl_fk_idx` (`tl_fk` ASC),
  INDEX `status_fk_idx` (`status_fk` ASC),
  INDEX `fiscal_year_fk_idx` (`fiscal_year_fk` ASC),
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `program_type_fk`
    FOREIGN KEY (`type_fk`)
    REFERENCES `nlch`.`nlch_programs` (`programs_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location_fk`
    FOREIGN KEY (`location_fk`)
    REFERENCES `nlch`.`nlch_locations` (`location_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pc_fk`
    FOREIGN KEY (`pc_fk`)
    REFERENCES `nlch`.`nlch_staff` (`staff_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tl_fk`
    FOREIGN KEY (`tl_fk`)
    REFERENCES `nlch`.`nlch_staff` (`staff_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `status_fk`
    FOREIGN KEY (`status_fk`)
    REFERENCES `nlch`.`nlch_student_status` (`status_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fiscal_year_fk`
    FOREIGN KEY (`fiscal_year_fk`)
    REFERENCES `nlch`.`nlch_fiscal_years` (`fiscal_year_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_comments` (
  `comment_pk` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `comment` VARCHAR(1000) NOT NULL,
  `active_fk` INT NOT NULL,
  `fiscal_year_fk` INT NOT NULL,
  PRIMARY KEY (`comment_pk`),
  INDEX `active_fk_idx` (`active_fk` ASC),
  INDEX `child_fk_idx` (`child_fk` ASC),
  INDEX `fiscal_year_fk_idx` (`fiscal_year_fk` ASC),
  CONSTRAINT `active_fk`
    FOREIGN KEY (`active_fk`)
    REFERENCES `nlch`.`gen_yn` (`yn_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `child_fk`
    FOREIGN KEY (`child_fk`)
    REFERENCES `nlch`.`child` (`child_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fiscal_year_fk`
    FOREIGN KEY (`fiscal_year_fk`)
    REFERENCES `nlch`.`nlch_fiscal_years` (`fiscal_year_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_medical` (
  `medical_pk` INT NOT NULL AUTO_INCREMENT,
  `child_fk` INT NOT NULL,
  `checkup_date` DATE NOT NULL,
  `treatment` VARCHAR(100) NULL,
  `details` VARCHAR(1000) NULL,
  PRIMARY KEY (`medical_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_academics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_academics` (
  `academic_pk` INT NOT NULL AUTO_INCREMENT,
  `fiscal_year_fk` INT NOT NULL,
  `active_fk` INT NOT NULL,
  `year` VARCHAR(45) NULL,
  `class` VARCHAR(45) NULL,
  `final_grade` VARCHAR(45) NULL,
  `comments` VARCHAR(1000) NULL,
  PRIMARY KEY (`academic_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`gen_countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`gen_countries` (
  `country_pk` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(100) NOT NULL,
  `country_code` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`country_pk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_sponsor_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_sponsor_details` (
  `sponsor_details_pk` INT NOT NULL AUTO_INCREMENT,
  `sponsor_fk` INT NOT NULL,
  `active_fk` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `country_fk` INT NOT NULL,
  `entry_date` DATE NULL,
  `exit_date` DATE NULL,
  `amount` VARCHAR(45) NULL,
  PRIMARY KEY (`sponsor_details_pk`),
  INDEX `sponsor_fk_idx` (`sponsor_fk` ASC),
  INDEX `active_fk_idx` (`active_fk` ASC),
  INDEX `country_fk_idx` (`country_fk` ASC),
  CONSTRAINT `sponsor_fk`
    FOREIGN KEY (`sponsor_fk`)
    REFERENCES `nlch`.`child_sponsors` (`sponsors_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `active_fk`
    FOREIGN KEY (`active_fk`)
    REFERENCES `nlch`.`gen_yn` (`yn_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `country_fk`
    FOREIGN KEY (`country_fk`)
    REFERENCES `nlch`.`gen_countries` (`country_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`nlch_correspondance_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`nlch_correspondance_types` (
  `correspondance_type_pk` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(200) NULL,
  `description` VARCHAR(45) NULL,
  `active_fk` INT NULL DEFAULT 0,
  PRIMARY KEY (`correspondance_type_pk`),
  INDEX `active_fk_idx` (`active_fk` ASC),
  CONSTRAINT `active_fk`
    FOREIGN KEY (`active_fk`)
    REFERENCES `nlch`.`gen_yn` (`yn_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nlch`.`child_correspondance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nlch`.`child_correspondance` (
  `correspondance_pk` INT NOT NULL AUTO_INCREMENT,
  `type_fk` INT NOT NULL,
  `child_fk` INT NULL,
  `path` VARCHAR(1000) NULL,
  `date` DATE NULL,
  PRIMARY KEY (`correspondance_pk`),
  INDEX `type_fk_idx` (`type_fk` ASC),
  CONSTRAINT `type_fk`
    FOREIGN KEY (`type_fk`)
    REFERENCES `nlch`.`nlch_correspondance_types` (`correspondance_type_pk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE USER 'nlch' IDENTIFIED BY 'nlch';

GRANT ALL ON `nlch`.* TO 'nlch';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
