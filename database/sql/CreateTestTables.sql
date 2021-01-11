SET foreign_key_checks = 0;

drop TABLE if EXISTS `salaroo_uk`.`test_data_salary`;
CREATE TABLE IF NOT EXISTS `salaroo_uk`.`test_data_salary` (
  `salary_test_num` INT NOT NULL,
  `description` VARCHAR(245) NOT NULL DEFAULT 'ENTER DESC',
  `tax_code` VARCHAR(10) NOT NULL,
  `basic_amount` DECIMAL(10,2) NOT NULL,
  `basic_hours` INT NOT NULL DEFAULT 40,
  `basic_rate` VARCHAR(45) NOT NULL,
  `basic_units` INT NULL DEFAULT -1 COMMENT 'If the units are -1 then the emp is treated as FT or PT. So there basic salary is that in basic_amount\nIf the units are not -1 then the emp is variable hours so the basic_amount is basic_rate * basic_units',
  `overtime_15` INT NOT NULL DEFAULT 0 COMMENT 'The number of hours OT @ 1.5 rate',
  `bonus` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `commission` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `expenses` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `salary_sacrifice_total` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `pension_total` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `annual_leave_for_period` TINYINT NOT NULL DEFAULT 0,
  `annual_leave_for_ytd` TINYINT NOT NULL DEFAULT 0,
  `mat_leave_for_period` TINYINT NOT NULL DEFAULT 0,
  `mat_leave_for_ytd` TINYINT NOT NULL DEFAULT 0,
  `pat_leave_for_period` TINYINT NOT NULL DEFAULT 0,
  `pat_leave_for_ytd` TINYINT NOT NULL DEFAULT 0,
  `sick_leave_for_period` TINYINT NOT NULL DEFAULT 0,
  `sick_leave_for_ytd` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`salary_test_num`),
  UNIQUE INDEX `idpayroll_test_data_UNIQUE` (`salary_test_num` ASC))
ENGINE = InnoDB;

select * from test_data_salary;

drop TABLE IF EXISTS `salaroo_uk`.`test_data_aeo`;
CREATE TABLE IF NOT EXISTS `salaroo_uk`.`test_data_aeo` (
  `aeo_test_num` INT NOT NULL AUTO_INCREMENT COMMENT 'There is only one test but it can have multiple records (AEOs)',
  `aeo_rec_num` INT NOT NULL COMMENT 'An AEO in a test',
  `description` VARCHAR(245) NOT NULL DEFAULT 'ENTER DECSCRIPTION',
  `is_priority` TINYINT NOT NULL,
  `priority` TINYINT NOT NULL,
  `deduction_amount` DECIMAL(7,2) NOT NULL,
  `deduction_type` ENUM('T', 'V', 'D') NOT NULL,
  `cumulative_unpaid` DECIMAL(8,2) NOT NULL DEFAULT 0 COMMENT 'The cumulative amount for this AEO that has not been deducted because of PEs',
  `pe_type` ENUM('P', 'A', 'N', 'D') NOT NULL COMMENT 'P = PERCENTAGE \nN = NONE \nV = VALUE\nD = DAILY',
  `pe_amount` DECIMAL(7,2) NOT NULL DEFAULT 0,
  `deduct_admin_charge` TINYINT NOT NULL DEFAULT 0,
  `aeo_type_description` VARCHAR(100) NOT NULL,
  `order_date` DATE NOT NULL,
  `pe_amount_carried_forward` DECIMAL(7,2) NOT NULL DEFAULT 0 COMMENT 'Unused protected earnings carried forward.\nThis only applies to certain AEOs.',
  PRIMARY KEY (`aeo_test_num`, `aeo_rec_num`),
  UNIQUE INDEX `test_num_rec_num_UNIQUE` (`aeo_test_num` ASC, `aeo_rec_num` ASC))
ENGINE = InnoDB;

select * from test_data_aeo;

drop TABLE IF EXISTS `salaroo_uk`.`test_data_student_loan`;
CREATE TABLE IF NOT EXISTS `salaroo_uk`.`test_data_student_loan` (
  `loan_test_num` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `current_amount` DECIMAL(7,2) NOT NULL,
  `loan_type` ENUM('1', '2', '3') NOT NULL COMMENT '1 = loan 1\n2 = loan 2\n3 = postgrad',
  `reason_for_deduction` ENUM('ER', 'GR', 'P45', 'SC', 'SR') NOT NULL COMMENT 'ER = Employee indicates they have a loan\nGR = Generic request from HMRC\nP45 = Emp P45 indicates loan should continue\nSC = Emp has filled in starter check list with loan\nSR = Start notice received from HMRC',
  `stop_notice_received` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`loan_test_num`),
  UNIQUE INDEX `emp_id_loan_type_UNIQUE` (`loan_type` ASC))
ENGINE = InnoDB;

select * from `salaroo_uk`.`test_data_student_loan`;

drop TABLE IF EXISTS `salaroo_uk`.`test`;
CREATE TABLE IF NOT EXISTS `salaroo_uk`.`test` (
  `id` INT NOT NULL COMMENT 'W1 = weekly\nW2 = foretnightly\nW4 = fourweekly\nM1 = monthly\nM3 = quarterly\nM6 = twice a year\nMA = annually\nIO = one off payment\nIR = irregular payments',
  `description` VARCHAR(245) NOT NULL DEFAULT 'DESC',
  `salary_test_num` INT NOT NULL,
  `aeo_test_num` INT NOT NULL DEFAULT -1,
  `loan_test_num` INT NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `id_aeo_test_num_aeo_rec_num_UNIQUE` (`id` ASC),
  INDEX `fk_test_test_data_salary1_idx` (`salary_test_num` ASC),
  INDEX `fk_test_test_data_aeo1_idx` (`aeo_test_num` ASC),
  INDEX `fk_test_test_data_student_loan1_idx` (`loan_test_num` ASC),
  CONSTRAINT `fk_test_test_data_salary1`
    FOREIGN KEY (`salary_test_num`)
    REFERENCES `salaroo_uk`.`test_data_salary` (`salary_test_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_test_test_data_aeo1`
    FOREIGN KEY (`aeo_test_num`)
    REFERENCES `salaroo_uk`.`test_data_aeo` (`aeo_test_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_test_test_data_student_loan1`
    FOREIGN KEY (`loan_test_num`)
    REFERENCES `salaroo_uk`.`test_data_student_loan` (`loan_test_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

select * from `salaroo_uk`.`test`;

SET foreign_key_checks = 1;