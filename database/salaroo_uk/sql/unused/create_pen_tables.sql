-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema salaroo_uk_pension
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salaroo_uk_pension
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salaroo_uk_pension` DEFAULT CHARACTER SET utf8 ;
USE `salaroo_uk_pension` ;

-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`postponement_approach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`postponement_approach` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id`, `description`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`eligibility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`eligibility` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(5) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `code`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`assessment_reason`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`assessment_reason` (
  `id` VARCHAR(45) NOT NULL,
  `assessment_description` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`pension_scheme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`pension_scheme` (
  `id` VARCHAR(20) NOT NULL,
  `scheme_name` VARCHAR(45) NOT NULL,
  `scheme_description` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`employee_pension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`employee_pension` (
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `employee_id` VARCHAR(20) NOT NULL,
  `pension_scheme_id` VARCHAR(20) NOT NULL,
  `group` INT NULL,
  `payment_source` VARCHAR(45) NULL,
  `is_overseas_national_awaiting_ni_num` TINYINT NOT NULL DEFAULT 0,
  `unique_identifier` VARCHAR(45) NULL,
  PRIMARY KEY (`employee_pension_id`, `employee_id`),
  UNIQUE INDEX `employee_pension_id_UNIQUE` (`employee_pension_id` ASC) VISIBLE,
  INDEX `fk_employee_pension_pension_scheme1_idx` (`pension_scheme_id` ASC) VISIBLE,
  UNIQUE INDEX `employee_payroll_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_pension_pension_scheme1`
    FOREIGN KEY (`pension_scheme_id`)
    REFERENCES `salaroo_uk_pension`.`pension_scheme` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `salaroo_uk_pension`.`employee_payroll_details` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`employee_eligibility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`employee_eligibility` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `date_acheived` DATE NOT NULL,
  `eligibility_code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`, `employee_pension_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employee_eligibility_eligibility1_idx` (`eligibility_code` ASC) VISIBLE,
  INDEX `fk_employee_eligibility_employee_pension1_idx` (`employee_pension_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_eligibility_eligibility1`
    FOREIGN KEY (`eligibility_code`)
    REFERENCES `salaroo_uk_pension`.`eligibility` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_eligibility_employee_pension1`
    FOREIGN KEY (`employee_pension_id`)
    REFERENCES `salaroo_uk_pension`.`employee_pension` (`employee_pension_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`notice_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`notice_type` (
  `id` TINYINT NOT NULL,
  `notice_description` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Using abbreviated version of NESTs notices.';


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`notices_due`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`notices_due` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `notice_type_id` TINYINT NOT NULL,
  `notice_due_by` DATE NULL,
  `notice_sent_on` DATE NULL,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `employee_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_notices_due_notice_type1_idx` (`notice_type_id` ASC) VISIBLE,
  INDEX `fk_notices_due_employee_pension1_idx` (`employee_pension_id` ASC, `employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_notices_due_notice_type1`
    FOREIGN KEY (`notice_type_id`)
    REFERENCES `salaroo_uk_pension`.`notice_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notices_due_employee_pension1`
    FOREIGN KEY (`employee_pension_id` , `employee_id`)
    REFERENCES `salaroo_uk_pension`.`employee_pension` (`employee_pension_id` , `employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`employee_postponement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`employee_postponement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `postponement_allowed` TINYINT NOT NULL,
  `is_postponed` TINYINT NOT NULL,
  `has_been_postponed` TINYINT NOT NULL,
  `date_of_postponement` DATE NOT NULL,
  `deferral_date` DATE NOT NULL,
  PRIMARY KEY (`id`, `employee_pension_id`),
  INDEX `fk_employee_postponement_employee_pension1_idx` (`employee_pension_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_postponement_employee_pension1`
    FOREIGN KEY (`employee_pension_id`)
    REFERENCES `salaroo_uk_pension`.`employee_pension` (`employee_pension_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`assessment_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`assessment_result` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `emp_pension_id` VARCHAR(40) NOT NULL,
  `assessment_date` VARCHAR(45) NOT NULL,
  `assessment_reason` VARCHAR(45) NOT NULL,
  `employee_eligibility_id` INT NOT NULL,
  `employee_postponement_id` INT NULL,
  `notices_due_id` INT NULL,
  PRIMARY KEY (`id`, `emp_pension_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employee_assessment_assessment_reason1_idx` (`assessment_reason` ASC) VISIBLE,
  INDEX `fk_assessment_result_employee_eligibility1_idx` (`employee_eligibility_id` ASC) VISIBLE,
  INDEX `fk_assessment_result_employee_pension1_idx` (`emp_pension_id` ASC) VISIBLE,
  INDEX `fk_assessment_result_notices_due1_idx` (`notices_due_id` ASC) VISIBLE,
  INDEX `fk_assessment_result_employee_postponement1_idx` (`employee_postponement_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_assessment_assessment_reason1`
    FOREIGN KEY (`assessment_reason`)
    REFERENCES `salaroo_uk_pension`.`assessment_reason` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assessment_result_employee_eligibility1`
    FOREIGN KEY (`employee_eligibility_id`)
    REFERENCES `salaroo_uk_pension`.`employee_eligibility` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assessment_result_employee_pension1`
    FOREIGN KEY (`emp_pension_id`)
    REFERENCES `salaroo_uk_pension`.`employee_pension` (`employee_pension_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assessment_result_notices_due1`
    FOREIGN KEY (`notices_due_id`)
    REFERENCES `salaroo_uk_pension`.`notices_due` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assessment_result_employee_postponement1`
    FOREIGN KEY (`employee_postponement_id`)
    REFERENCES `salaroo_uk_pension`.`employee_postponement` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`enrolment_criteria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`enrolment_criteria` (
  `id` VARCHAR(20) NOT NULL,
  `tax_year` VARCHAR(4) NOT NULL,
  `is_no_criteria` TINYINT NOT NULL,
  `is_worker_automatically_enroled` TINYINT NOT NULL,
  `is_there_opt_out_period` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `tax_year`),
  INDEX `fk_tax_year_id_idx` (`tax_year` ASC) VISIBLE,
  UNIQUE INDEX `id_tax_year_UNIQUE` (`id` ASC, `tax_year` ASC) VISIBLE,
  CONSTRAINT `fk_tax_year_id`
    FOREIGN KEY (`tax_year`)
    REFERENCES `salaroo_uk_pension`.`tax_year` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Lookup the criteria for an enrolment_type';


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`enrolment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`enrolment_type` (
  `id` VARCHAR(20) NOT NULL,
  `enrolment_description` VARCHAR(500) NOT NULL,
  `enrolment_criteria_id` VARCHAR(20) NOT NULL,
  `enrolment_criteria_tax_year` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`, `enrolment_criteria_id`, `enrolment_criteria_tax_year`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_enrolment_category_enrolment_criteria1_idx` (`enrolment_criteria_id` ASC, `enrolment_criteria_tax_year` ASC) VISIBLE,
  CONSTRAINT `fk_enrolment_category_enrolment_criteria1`
    FOREIGN KEY (`enrolment_criteria_id` , `enrolment_criteria_tax_year`)
    REFERENCES `salaroo_uk_pension`.`enrolment_criteria` (`id` , `tax_year`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`enrolment_criterion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`enrolment_criterion` (
  `criterion_id` VARCHAR(20) NOT NULL,
  `enrolment_criteria_id` VARCHAR(20) NOT NULL,
  `enrolment_criteria_tax_year` VARCHAR(4) NOT NULL,
  `age_min` TINYINT NULL,
  `age_max` TINYINT NULL,
  `earn_min` DECIMAL(5,0) NULL,
  `earn_max` DECIMAL(5,0) NULL,
  `is_under_spa` TINYINT NULL COMMENT 'Worker is under the state pension age',
  `is_spa` TINYINT NULL COMMENT 'Worker is state pension age or over',
  PRIMARY KEY (`criterion_id`, `enrolment_criteria_id`, `enrolment_criteria_tax_year`),
  INDEX `fk_enrolment_criterion_enrolment_criteria1_idx` (`enrolment_criteria_id` ASC, `enrolment_criteria_tax_year` ASC) VISIBLE,
  CONSTRAINT `fk_enrolment_criterion_enrolment_criteria1`
    FOREIGN KEY (`enrolment_criteria_id` , `enrolment_criteria_tax_year`)
    REFERENCES `salaroo_uk_pension`.`enrolment_criteria` (`id` , `tax_year`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Lookup one or more criterion that make up the overall list of criteria for an enrolment_type.\n\nIf a field has val -1 this indicates that it\'s a required field that has to be looked up, i.e. state pension age.';


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`state_pension_age_67_to_68`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`state_pension_age_67_to_68` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dob_from` DATE NOT NULL,
  `dob_to` DATE NOT NULL,
  `date_spa_reached` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`employee_enroled`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`employee_enroled` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `employee_id` VARCHAR(20) NOT NULL,
  `is_enroled` TINYINT NOT NULL,
  `enrolment_date` DATE NULL,
  `enrolment_type` VARCHAR(45) NULL,
  `enrolment_type_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`, `employee_pension_id`, `employee_id`),
  INDEX `fk_employee_enroled_employee_pension1_idx` (`employee_pension_id` ASC, `employee_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employee_enroled_enrolment_type1_idx` (`enrolment_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_enroled_employee_pension1`
    FOREIGN KEY (`employee_pension_id` , `employee_id`)
    REFERENCES `salaroo_uk_pension`.`employee_pension` (`employee_pension_id` , `employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_enroled_enrolment_type1`
    FOREIGN KEY (`enrolment_type_id`)
    REFERENCES `salaroo_uk_pension`.`enrolment_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension`.`contribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaroo_uk_pension`.`contribution` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_of_contribution` DATE NOT NULL,
  `employee_contribution` DECIMAL(8,2) NOT NULL,
  `employer_contribution` DECIMAL(8,2) NOT NULL,
  `assessment_result_id` INT NOT NULL,
  `assessment_result_emp_pension_id` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`, `assessment_result_id`, `assessment_result_emp_pension_id`),
  UNIQUE INDEX `idcontribution_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_contribution_assessment_result1_idx` (`assessment_result_id` ASC, `assessment_result_emp_pension_id` ASC) VISIBLE,
  CONSTRAINT `fk_contribution_assessment_result1`
    FOREIGN KEY (`assessment_result_id` , `assessment_result_emp_pension_id`)
    REFERENCES `salaroo_uk_pension`.`assessment_result` (`id` , `emp_pension_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- end attached script 
