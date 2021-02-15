-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema salaroo_uk_pension_test_test
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salaroo_uk_pension_test_test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `salaroo_uk_pension_test` ;

-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`assessment_reason`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`assessment_reason` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`assessment_reason` (
  `id` VARCHAR(45) NOT NULL,
  `assessment_description` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`eligibility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`eligibility` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`eligibility` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(5) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `code`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`pension_scheme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`pension_scheme` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`pension_scheme` (
  `id` VARCHAR(20) NOT NULL,
  `scheme_name` VARCHAR(45) NOT NULL,
  `scheme_description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`employee_pension`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`employee_pension` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`employee_pension` (
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `employee_id` VARCHAR(20) NOT NULL,
  `emp_payroll_id` VARCHAR(20) NOT NULL,
  `pension_scheme_id` VARCHAR(20) NOT NULL,
  `group` INT(11) NULL DEFAULT NULL,
  `payment_source` VARCHAR(45) NULL DEFAULT NULL,
  `is_overseas_national_awaiting_ni_num` TINYINT(4) NOT NULL DEFAULT '0',
  `unique_identifier` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`employee_pension_id`, `employee_id`, `emp_payroll_id`),
  UNIQUE INDEX `employee_pension_id_UNIQUE` (`employee_pension_id` ASC) VISIBLE,
  UNIQUE INDEX `employee_payroll_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  INDEX `fk_employee_pension_pension_scheme1_idx` (`pension_scheme_id` ASC) VISIBLE,
  UNIQUE INDEX `emp_payroll_id_UNIQUE` (`emp_payroll_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_payroll_details` (`employee_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_employee_pension_pension_scheme1`
    FOREIGN KEY (`pension_scheme_id`)
    REFERENCES `salaroo_uk_pension_test`.`pension_scheme` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`employee_eligibility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`employee_eligibility` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`employee_eligibility` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `date_acheived` DATE NOT NULL,
  `eligibility_code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`, `employee_pension_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employee_eligibility_eligibility1_idx` (`eligibility_code` ASC) VISIBLE,
  INDEX `fk_employee_eligibility_employee_pension1_idx` (`employee_pension_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_eligibility_eligibility1`
    FOREIGN KEY (`eligibility_code`)
    REFERENCES `salaroo_uk_pension_test`.`eligibility` (`code`),
  CONSTRAINT `fk_employee_eligibility_employee_pension1`
    FOREIGN KEY (`employee_pension_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_pension` (`employee_pension_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`employee_postponement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`employee_postponement` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`employee_postponement` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `emp_pension_id` VARCHAR(40) NOT NULL,
  `postponement_allowed` TINYINT(4) NOT NULL,
  `is_postponed` TINYINT(4) NOT NULL,
  `has_been_postponed` TINYINT(4) NOT NULL,
  `date_of_postponement` DATE NOT NULL,
  `deferral_date` DATE NULL,
  PRIMARY KEY (`id`, `emp_pension_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employee_postponement_employee_pension1_idx` (`emp_pension_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_postponement_employee_pension1`
    FOREIGN KEY (`emp_pension_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_pension` (`employee_pension_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`notice_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`notice_type` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`notice_type` (
  `id` TINYINT(4) NOT NULL,
  `notice_description` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Using abbreviated version of NESTs notices.';


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`notices_due`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`notices_due` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`notices_due` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `notice_type_id` TINYINT(4) NOT NULL,
  `notice_due_by` DATE NULL DEFAULT NULL,
  `notice_sent_on` DATE NULL DEFAULT NULL,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `employee_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_notices_due_notice_type1_idx` (`notice_type_id` ASC) VISIBLE,
  INDEX `fk_notices_due_employee_pension1_idx` (`employee_pension_id` ASC, `employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_notices_due_employee_pension1`
    FOREIGN KEY (`employee_pension_id` , `employee_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_pension` (`employee_pension_id` , `employee_id`),
  CONSTRAINT `fk_notices_due_notice_type1`
    FOREIGN KEY (`notice_type_id`)
    REFERENCES `salaroo_uk_pension_test`.`notice_type` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`assessment_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`assessment_result` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`assessment_result` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `emp_pension_id` VARCHAR(40) NOT NULL,
  `assessment_date` VARCHAR(45) NOT NULL,
  `assessment_reason` VARCHAR(45) NOT NULL,
  `employee_eligibility_id` INT(11) NOT NULL,
  `employee_postponement_id` INT(11) NULL DEFAULT NULL,
  `notices_due_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `emp_pension_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employee_assessment_assessment_reason1_idx` (`assessment_reason` ASC) VISIBLE,
  INDEX `fk_assessment_result_employee_eligibility1_idx` (`employee_eligibility_id` ASC) VISIBLE,
  INDEX `fk_assessment_result_employee_pension1_idx` (`emp_pension_id` ASC) VISIBLE,
  INDEX `fk_assessment_result_notices_due1_idx` (`notices_due_id` ASC) VISIBLE,
  INDEX `fk_assessment_result_employee_postponement1_idx` (`employee_postponement_id` ASC) VISIBLE,
  CONSTRAINT `fk_assessment_result_employee_eligibility1`
    FOREIGN KEY (`employee_eligibility_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_eligibility` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_assessment_result_employee_pension1`
    FOREIGN KEY (`emp_pension_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_pension` (`employee_pension_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_assessment_result_employee_postponement1`
    FOREIGN KEY (`employee_postponement_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_postponement` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_assessment_result_notices_due1`
    FOREIGN KEY (`notices_due_id`)
    REFERENCES `salaroo_uk_pension_test`.`notices_due` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_employee_assessment_assessment_reason1`
    FOREIGN KEY (`assessment_reason`)
    REFERENCES `salaroo_uk_pension_test`.`assessment_reason` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`contribution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`contribution` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`contribution` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_of_contribution` DATE NOT NULL,
  `employee_contribution` DECIMAL(8,2) NOT NULL,
  `employer_contribution` DECIMAL(8,2) NOT NULL,
  `assessment_result_id` INT(11) NOT NULL,
  `assessment_result_emp_pension_id` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`, `assessment_result_id`, `assessment_result_emp_pension_id`),
  UNIQUE INDEX `idcontribution_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_contribution_assessment_result1_idx` (`assessment_result_id` ASC, `assessment_result_emp_pension_id` ASC) VISIBLE,
  CONSTRAINT `fk_contribution_assessment_result1`
    FOREIGN KEY (`assessment_result_id` , `assessment_result_emp_pension_id`)
    REFERENCES `salaroo_uk_pension_test`.`assessment_result` (`id` , `emp_pension_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`enrolment_criteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`enrolment_criteria` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`enrolment_criteria` (
  `id` VARCHAR(20) NOT NULL,
  `tax_year` VARCHAR(4) NOT NULL,
  `is_no_criteria` TINYINT(4) NOT NULL,
  `is_worker_automatically_enroled` TINYINT(4) NOT NULL,
  `is_there_opt_out_period` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`, `tax_year`),
  UNIQUE INDEX `id_tax_year_UNIQUE` (`id` ASC, `tax_year` ASC) VISIBLE,
  INDEX `fk_tax_year_id_idx` (`tax_year` ASC) VISIBLE,
  CONSTRAINT `fk_tax_year_id`
    FOREIGN KEY (`tax_year`)
    REFERENCES `salaroo_uk_pension_test`.`tax_year` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Lookup the criteria for an enrolment_type';


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`enrolment_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`enrolment_type` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`enrolment_type` (
  `id` VARCHAR(20) NOT NULL,
  `enrolment_description` VARCHAR(500) NOT NULL,
  `enrolment_criteria_id` VARCHAR(20) NOT NULL,
  `enrolment_criteria_tax_year` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`, `enrolment_criteria_id`, `enrolment_criteria_tax_year`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_enrolment_category_enrolment_criteria1_idx` (`enrolment_criteria_id` ASC, `enrolment_criteria_tax_year` ASC) VISIBLE,
  CONSTRAINT `fk_enrolment_category_enrolment_criteria1`
    FOREIGN KEY (`enrolment_criteria_id` , `enrolment_criteria_tax_year`)
    REFERENCES `salaroo_uk_pension_test`.`enrolment_criteria` (`id` , `tax_year`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`employee_enroled`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`employee_enroled` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`employee_enroled` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `employee_id` VARCHAR(20) NOT NULL,
  `is_enroled` TINYINT(4) NOT NULL,
  `enrolment_date` DATE NULL DEFAULT NULL,
  `enrolment_type` VARCHAR(45) NULL DEFAULT NULL,
  `enrolment_type_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`, `employee_pension_id`, `employee_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employee_enroled_employee_pension1_idx` (`employee_pension_id` ASC, `employee_id` ASC) VISIBLE,
  INDEX `fk_employee_enroled_enrolment_type1_idx` (`enrolment_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_enroled_employee_pension1`
    FOREIGN KEY (`employee_pension_id` , `employee_id`)
    REFERENCES `salaroo_uk_pension_test`.`employee_pension` (`employee_pension_id` , `employee_id`),
  CONSTRAINT `fk_employee_enroled_enrolment_type1`
    FOREIGN KEY (`enrolment_type_id`)
    REFERENCES `salaroo_uk_pension_test`.`enrolment_type` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`enrolment_criterion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`enrolment_criterion` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`enrolment_criterion` (
  `criterion_id` VARCHAR(20) NOT NULL,
  `enrolment_criteria_id` VARCHAR(20) NOT NULL,
  `enrolment_criteria_tax_year` VARCHAR(4) NOT NULL,
  `age_min` TINYINT(4) NULL DEFAULT NULL,
  `age_max` TINYINT(4) NULL DEFAULT NULL,
  `earn_min` DECIMAL(5,0) NULL DEFAULT NULL,
  `earn_max` DECIMAL(5,0) NULL DEFAULT NULL,
  `is_under_spa` TINYINT(4) NULL DEFAULT NULL COMMENT 'Worker is under the state pension age',
  `is_spa` TINYINT(4) NULL DEFAULT NULL COMMENT 'Worker is state pension age or over',
  PRIMARY KEY (`criterion_id`, `enrolment_criteria_id`, `enrolment_criteria_tax_year`),
  INDEX `fk_enrolment_criterion_enrolment_criteria1_idx` (`enrolment_criteria_id` ASC, `enrolment_criteria_tax_year` ASC) VISIBLE,
  CONSTRAINT `fk_enrolment_criterion_enrolment_criteria1`
    FOREIGN KEY (`enrolment_criteria_id` , `enrolment_criteria_tax_year`)
    REFERENCES `salaroo_uk_pension_test`.`enrolment_criteria` (`id` , `tax_year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Lookup one or more criterion that make up the overall list of criteria for an enrolment_type.\\\\\\\\n\\\\\\\\nIf a field has val -1 this indicates that it\'s a required field that has to be looked up, i.e. state pension age.';


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`postponement_approach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`postponement_approach` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`postponement_approach` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id`, `description`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`state_pension_age_67_to_68`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`state_pension_age_67_to_68` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`state_pension_age_67_to_68` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `dob_from` DATE NOT NULL,
  `dob_to` DATE NOT NULL,
  `date_spa_reached` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`pay_reference_period`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`pay_reference_period` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`pay_reference_period` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tax_year` VARCHAR(4) NOT NULL,
  `pay_frequency` ENUM('W1', 'W2', 'W4', 'M1', 'M3', 'M6', 'MA', 'IO', 'IR') NOT NULL COMMENT 'W1 = weekly\\nW2 = foretnightly\\nW4 = fourweekly\\nM1 = monthly\\nM3 = quarterly\\nM6 = twice a year\\nMA = annually\\nIO = one off payment\\nIR = irregular payments',
  `prp_number` TINYINT(4) NOT NULL,
  `date_from` DATE NOT NULL,
  `date_to` DATE NOT NULL,
  `run_payroll_on` DATE NOT NULL,
  `pay_emps_on` DATE NOT NULL,
  PRIMARY KEY (`id`, `tax_year`, `pay_frequency`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `pay_freq_IDX` (`pay_frequency` ASC) INVISIBLE,
  INDEX (`tax_year` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test`.`pay_reference_period_qual_earnings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test`.`pay_reference_period_qual_earnings` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test`.`pay_reference_period_qual_earnings` (
  `pay_reference_period_id` INT(11) NOT NULL,
  `employee_pension_id` VARCHAR(40) NOT NULL,
  `record_date` DATE NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `prp_tax_year` VARCHAR(4) NOT NULL,
  `prp_pay_frequency` ENUM('W1', 'W2', 'W4', 'M1', 'M3', 'M6', 'MA', 'IO', 'IR') NOT NULL,
  PRIMARY KEY (`pay_reference_period_id`, `employee_pension_id`, `record_date`),
  UNIQUE INDEX `prp_id_emp_pension_id_UNIQUE` (`pay_reference_period_id` ASC, `employee_pension_id` ASC) VISIBLE,
  INDEX `fk_prp_id_tax_year_pay_freq_idx` (`pay_reference_period_id` ASC, `prp_tax_year` ASC, `prp_pay_frequency` ASC) VISIBLE,
  CONSTRAINT `fk_prp_id_tax_year_pay_freq`
    FOREIGN KEY (`pay_reference_period_id` , `prp_tax_year` , `prp_pay_frequency`)
    REFERENCES `salaroo_uk_pension_test`.`pay_reference_period` (`id` , `tax_year` , `pay_frequency`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `salaroo_uk_pension_test_test` ;

-- -----------------------------------------------------
-- Table `salaroo_uk_pension_test_test`.`pension_test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salaroo_uk_pension_test_test`.`pension_test` ;

CREATE TABLE IF NOT EXISTS `salaroo_uk_pension_test_test`.`pension_test` (
  `test_num` INT(11) NOT NULL,
  PRIMARY KEY (`test_num`),
  UNIQUE INDEX `test_num_UNIQUE` (`test_num` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `salaroo_uk_pension_test` ;

-- -----------------------------------------------------
-- procedure create_all_enrolment_type_data
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`create_all_enrolment_type_data`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_all_enrolment_type_data`()
BEGIN

	DROP TABLE IF EXISTS temp_all_enrolment_type_data;

    CREATE TEMPORARY TABLE temp_all_enrolment_type_data

	SELECT 

		e_type.id AS type_id, e_type.enrolment_criteria_tax_year AS tax_year, e_type.enrolment_description, 

		criteria.is_no_criteria, criteria.is_worker_automatically_enroled, criteria.is_there_opt_out_period,

		criterion.criterion_id, criterion.age_min, criterion.age_max, criterion.earn_min, criterion.earn_max, criterion.is_under_spa, criterion.is_spa 

	FROM 

		enrolment_type e_type

		JOIN enrolment_criteria criteria

		ON e_type.enrolment_criteria_id = criteria.id

			LEFT JOIN enrolment_criterion criterion

			ON criteria.id = criterion.enrolment_criteria_id;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure create_prp_dates
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`create_prp_dates`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_prp_dates`(IN tax_year varchar(4))
BEGIN	
	DECLARE payNum INT;
    DECLARE dateFrom DATE;
    DECLARE dateTo DATE;
    DECLARE runPayrollOn DATE;
    DECLARE payEmpsOn DATE;
    DECLARE endDate DATE;
    DECLARE lastDay DATE;
    
    DELETE FROM pay_reference_period WHERE id != '' AND pay_reference_period.tax_year = tax_year;
    
    SET endDate = DATE(concat(tax_year,'-04-05'));
    
    -- M1
    SET payNum = 1;
    SET dateFrom = concat(tax_year,'-04-06');
    SET dateTo = concat(tax_year,'-05-05');
    SET runPayrollOn = date_add(dateFrom, INTERVAL 28 DAY);
    SET payEmpsOn = runPayrollOn;
    
    WHILE payNum <= 12 DO		
		INSERT INTO 
			`pay_reference_period` (`tax_year`, `pay_frequency`, `prp_number`, `date_from`, `date_to`, `run_payroll_on`, `pay_emps_on`) 
		VALUES 
			(tax_year, 'M1', payNum, dateFrom, dateTo, runPayrollOn, payEmpsOn);
		SET dateFrom = date_add(dateFrom, INTERVAL 1 MONTH);
        SET dateTo = date_add(dateTo, INTERVAL 1 MONTH);
        SET runPayrollOn = date_add(dateFrom, INTERVAL 28 DAY);
		SET payEmpsOn = runPayrollOn;
		SET payNum = payNum + 1;        
    END WHILE;
    
    -- W1
    SET payNum = 1;    
    SET dateFrom = concat(tax_year,'-04-06');
    SET dateTo = date_add(dateFrom, INTERVAL 6 DAY);
    SET runPayrollOn = date_add(dateFrom, INTERVAL 5 DAY);
    SET payEmpsOn = runPayrollOn;
    
    WHILE payNum <= 52 DO 
		INSERT INTO 
			`pay_reference_period` (`tax_year`, `pay_frequency`, `prp_number`,  `date_from`, `date_to`, `run_payroll_on`, `pay_emps_on`) 
		VALUES 
			(tax_year, 'W1', payNum, dateFrom, dateTo, runPayrollOn, payEmpsOn);
            
		SET dateFrom = date_add(dateTo, INTERVAL 1 DAY);
        SET dateTo = date_add(dateFrom, INTERVAL 6 DAY);
        SET runPayrollOn = date_add(dateFrom, INTERVAL 5 DAY);
		SET payEmpsOn = runPayrollOn;
		SET payNum = payNum + 1;        
    END WHILE;
    
    -- set week 53 if there is one
    SET lastDay = dateFrom;
    WHILE lastDay <= endDate DO
		SET lastDay = date_add(lastDay, INTERVAL 1 DAY);
        SET runPayrollOn = lastDay;
		SET payEmpsOn = lastDay;
    END WHILE;
    
    INSERT INTO 
		`pay_reference_period` (`tax_year`, `pay_frequency`, `prp_number`,  `date_from`, `date_to`, `run_payroll_on`, `pay_emps_on`)  
	VALUES 
		(tax_year, 'W1', payNum, dateFrom, lastDay, runPayrollOn, payEmpsOn);
    	
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure date_spa_reached_for_emp
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`date_spa_reached_for_emp`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `date_spa_reached_for_emp`(

	IN empId VARCHAR(45))
BEGIN

	DECLARE empDOB DATE;

    DECLARE dobFrom DATE;

    DECLARE dobTo DATE;

    DECLARE dateSpaReached DATE;

    DECLARE spaYear INT DEFAULT 0;

        

	SELECT date_of_birth INTO empDOB FROM employee WHERE id = empId;

    

    IF empDOB <= "1977-04-04" THEN

		SET dateSpaReached = DATE_ADD(empDOB, INTERVAL 67 YEAR);

        SET spaYear = 67;

	ELSEIF empDOB >= "1978-04-06" THEN

		SET dateSpaReached = DATE_ADD(empDOB, INTERVAL 68 YEAR);

        SET spaYear = 68;

	ELSE

		SELECT date_spa_reached INTO dateSpaReached FROM state_pension_age_67_to_68

		WHERE dob_from <= empDOB AND dob_to >= empDOB;

        SET spaYear = 68;

    END IF;



    SELECT empDOB AS emp_dob, spaYear AS spa_year, dateSpaReached AS date_spa_reached;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_all_enrolment_type_data
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_all_enrolment_type_data`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_enrolment_type_data`()
BEGIN

	CALL create_all_enrolment_type_data();

    SELECT * FROM temp_all_enrolment_type_data;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_all_postponement_types
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_all_postponement_types`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_postponement_types`()
BEGIN

	SELECT * FROM postponement_approach ORDER BY id;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_enrolment_type_data_for_tax_year
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_enrolment_type_data_for_tax_year`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enrolment_type_data_for_tax_year`(IN taxYear VARCHAR(4))
BEGIN

	CALL create_all_enrolment_type_data();

    SELECT * FROM temp_all_enrolment_type_data

    WHERE tax_year = taxYear;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_enrolment_type_data_for_type
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_enrolment_type_data_for_type`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enrolment_type_data_for_type`(

	IN taxYear VARCHAR(4),

    IN enrolmentType VARCHAR(20))
BEGIN

	CALL create_all_enrolment_type_data();

    SELECT * FROM temp_all_enrolment_type_data

    WHERE tax_year = taxYear and type_id = enrolmentType;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function get_prp_id_for_freq_and_date
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP function IF EXISTS `salaroo_uk_pension_test`.`get_prp_id_for_freq_and_date`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_prp_id_for_freq_and_date`(payFreq VARCHAR(2), forDate DATE) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE returnId INT(11);
    
	SELECT 
		id 
	INTO
		returnId
	FROM 
		pay_reference_period 
	WHERE 
		pay_frequency = payFreq
	AND 
		forDate BETWEEN date_from AND date_to;
        
	RETURN returnId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_emp_pension_details
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_emp_pension_details`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_pension_details`(empId VARCHAR(20))
BEGIN
	SELECT * FROM employee_pension
    WHERE employee_id = empId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_last_assessment_for_emp
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_last_assessment_for_emp`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_last_assessment_for_emp`(IN empPenId VARCHAR(40))
BEGIN
	SELECT * FROM assessment_result WHERE emp_pension_id = empPenId
	ORDER BY assessment_date LIMIT 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_last_postponement_for_emp
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_last_postponement_for_emp`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_last_postponement_for_emp`(IN empPenId VARCHAR(40))
BEGIN
	SELECT * FROM employee_postponement WHERE emp_pension_id = empPenId
	ORDER BY date_of_postponement LIMIT 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_all_schemes
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_all_schemes`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_schemes`()
BEGIN
	SELECT * FROM salaroo_uk_pension_test.pension_scheme;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_prp_data_for_emp
-- -----------------------------------------------------

USE `salaroo_uk_pension_test`;
DROP procedure IF EXISTS `salaroo_uk_pension_test`.`get_prp_data_for_emp`;

DELIMITER $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prp_data_for_emp`(
	IN empPensionId VARCHAR(40),
    IN payFreq VARCHAR(2),
    IN forDate DATE)
BEGIN
	-- Get the prp (dates, prp number etc).
    -- If there's any prp earnings return those as well.
	DECLARE prpId INT DEFAULT 0;
    SET prpId = get_prp_id_for_freq_and_date(payFreq, forDate);
    
	WITH prp_qe AS(
		SELECT * FROM 
			pay_reference_period_qual_earnings 
		WHERE 
			pay_reference_period_id = prpId
		AND
			employee_pension_id = empPensionId
		ORDER BY record_date DESC LIMIT 1
		) 
		SELECT 
			prp.pay_frequency, prp.prp_number, prp.date_from, prp.date_to, prp.run_payroll_on, prp.pay_emps_on,
			prp_qe.pay_reference_period_id, prp_qe.employee_pension_id, prp_qe.record_date, prp_qe.amount, prp_qe.prp_tax_year	
			FROM 
				prp_qe
				RIGHT JOIN pay_reference_period prp 
				ON prp.id = prp_qe.pay_reference_period_id
				WHERE prp.id = prpId; 
END$$

DELIMITER ;
USE `salaroo_uk_pension_test`;

DELIMITER $$

USE `salaroo_uk_pension_test`$$
DROP TRIGGER IF EXISTS `salaroo_uk_pension_test`.`employee_pension_BEFORE_INSERT` $$
USE `salaroo_uk_pension_test`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `salaroo_uk_pension_test`.`employee_pension_BEFORE_INSERT`
BEFORE INSERT ON `salaroo_uk_pension_test`.`employee_pension`
FOR EACH ROW
BEGIN
	SET NEW.employee_pension_id = concat(NEW.employee_id,'_',NEW.pension_scheme_id);
END$$


USE `salaroo_uk_pension_test`$$
DROP TRIGGER IF EXISTS `salaroo_uk_pension_test`.`employee_pension_BEFORE_UPDATE` $$
USE `salaroo_uk_pension_test`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `salaroo_uk_pension_test`.`employee_pension_BEFORE_UPDATE`
BEFORE UPDATE ON `salaroo_uk_pension_test`.`employee_pension`
FOR EACH ROW
BEGIN
	SET NEW.employee_pension_id = concat(NEW.employee_id,'_',NEW.pension_scheme_id);
END$$


USE `salaroo_uk_pension_test`$$
DROP TRIGGER IF EXISTS `salaroo_uk_pension_test`.`assessment_result_BEFORE_INSERT` $$
USE `salaroo_uk_pension_test`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `salaroo_uk_pension_test`.`assessment_result_BEFORE_INSERT`
BEFORE INSERT ON `salaroo_uk_pension_test`.`assessment_result`
FOR EACH ROW
BEGIN
	SET NEW.assessment_date = now();
END$$


USE `salaroo_uk_pension_test`$$
DROP TRIGGER IF EXISTS `salaroo_uk_pension_test`.`pay_reference_period_qual_earnings_BEFORE_INSERT` $$
USE `salaroo_uk_pension_test`$$
CREATE DEFINER = CURRENT_USER TRIGGER `salaroo_uk_pension_test`.`pay_reference_period_qual_earnings_BEFORE_INSERT` BEFORE INSERT ON `pay_reference_period_qual_earnings` FOR EACH ROW
BEGIN
	DECLARE prpId INT(11);
    SET prpId =  get_prp_id_for_freq_and_date(NEW.prp_pay_frequency, NEW.record_date);
    SET NEW.pay_reference_period_id = prpId;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- begin attached script 'InitialData'
USE salaroo_uk_pension_test;
SET foreign_key_checks = 0;

CALL create_prp_dates("2021");

TRUNCATE pension_scheme;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\pension_scheme.csv'
INTO TABLE pension_scheme 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee_pension;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\employee_pension.csv'
INTO TABLE employee_pension 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE postponement_approach;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\postponement_approach.csv'
INTO TABLE postponement_approach 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE eligibility;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\eligibility.csv'
INTO TABLE eligibility 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE assessment_reason;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\assessment_reason.csv'
INTO TABLE assessment_reason 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE notice_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\notice_type.csv'
INTO TABLE notice_type 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE enrolment_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\enrolment_type.csv'
INTO TABLE enrolment_type 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE enrolment_criteria;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\enrolment_criteria.csv'
INTO TABLE enrolment_criteria 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE enrolment_criterion;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\enrolment_criterion.csv'
INTO TABLE enrolment_criterion 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE state_pension_age_67_to_68;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\pension\\state_pension_age_67_to_68.csv'
INTO TABLE state_pension_age_67_to_68 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET foreign_key_checks = 1;
-- end attached script 'InitialData'
