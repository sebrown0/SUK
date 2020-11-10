DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS initialise_employer $$
CREATE PROCEDURE initialise_employer (
	IN employer_id VARCHAR(45),
    IN employer_name VARCHAR(45),
    IN employer_hmrc_office_number VARCHAR(45),
    IN employer_paye_reference VARCHAR(45),
    IN employer_id_accounts_office_reference VARCHAR(45),
    IN employer_tax_year VARCHAR(4))
BEGIN	
    SET foreign_key_checks = 0;
    
	/*Employer*/
	DELETE FROM employer WHERE id = employer_id;
	INSERT INTO  employer
		(id, `name`, hmrc_office_number, paye_reference, accounts_office_reference) 
	VALUES 
		(employer_id, employer_name, employer_hmrc_office_number, employer_paye_reference, employer_id_accounts_office_reference); 
	
	/* Tax Year */
    DELETE FROM tax_year WHERE id =employer_tax_year AND tax_year.employer_id = employer_id;
	INSERT INTO  tax_year
		(id, employer_id) 
	VALUES 
		(employer_tax_year, employer_id);
	
    /*Payroll Frequency*/
	DELETE FROM payroll_frequency WHERE tax_year_id = employer_tax_year;    
	INSERT INTO  payroll_frequency
		(id, tax_year_id, pay_frequency_id, last_payroll_run_number)
	Values
		(1, employer_tax_year, "W1", 0),
		(2, employer_tax_year, "W2", 0),
		(3, employer_tax_year, "W4", 0),
		(4, employer_tax_year, "M1", 0),
		(5, employer_tax_year, "M3", 0),
		(6, employer_tax_year, "M6", 0),
		(7, employer_tax_year, "MA", 0),
		(8, employer_tax_year, "IO", 0),
		(9, employer_tax_year, "IR", 0);
    
    SET foreign_key_checks = 1;         
END $$

DROP PROCEDURE IF EXISTS initialise_employee $$
CREATE PROCEDURE initialise_employee (IN employer_id VARCHAR(45))
BEGIN	
    SET foreign_key_checks = 0;

	/* Employee */
	DELETE FROM employee WHERE id !='';
	INSERT INTO employee
		(`id`, `first_name`, `last_name`, `gender`, `date_of_birth`, `initials`, `employer_id`)
	Values
		("MS1","Marge","Simpson","F","1985/05/12", "MS", employer_id),
		("BS1","Bart","Simpson","M","1996/12/25", "BS", employer_id),
		("LS1","Lisa","Simpson","F","1995/06/12", "LS", employer_id),
		("TR1","The","Rock","M","1980/01/01", "TR", employer_id),
		("CE1","Clint","Eastwood","M","1950/03/22", "CE", employer_id),
		("BM1","Bat","Man","M","1980/06/15", "BM", employer_id),
		("QE2","Queen Liz","The II","F","1920/09/27", "QE", employer_id),
		("HS1","Homer","Simpson","M","1980/04/01", "HS", employer_id),
		("MAS1","Maggie","Simpson","F","1998/05/06", "MAS", employer_id),
		("SW1","Stevie","Wonder","M","1970/01/01", "SW", employer_id);
		
	  /* Address */
	DELETE FROM address WHERE id !='';
	INSERT INTO address
		(employee_id, number_or_name, street, district, city, post_code, country )
	Values
		("MS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("BS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("LS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("TR1","12","Rocky Ave", "Ashton Vale","Bristol","BS3 7PQ", "England"),
		("CE1","99","Make My Day St", "Horfield","Newcastle","HR12 3PA", "England"),
		("BM1","Wayne Manor","1 Bat Cave Ave", "","Gotham","GT123", "England"),
		("QE2","Buck House","Strand", "Westminster","London","SW1A 1AA", "England"),
		("HS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("MAS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("SW1","4","Blues Rd", "Motown","Detroit","MT321", "England");

	  /*Employee HR*/
	DELETE FROM employee_hr WHERE id !='';
	INSERT INTO employee_hr
		(employee_id, ni_number, start_date, martial_status, employee_hours_normally_worked, starting_declaration)
	Values
		("MS1","NI123456B","2020/01/01","M", "D", "B"),
		("BS1","NI123456C","2020/01/01","S", "B", "B"),
		("LS1","NI123456D","2020/01/01","S", "D", "B"),
		("TR1","NI123456F","2020/05/01","S", "D", "B"),
		("CE1","NI123456G","2020/01/01","M", "D", "B"),
		("BM1","NI123456I","2020/01/01","S", "D", "B"),
		("QE2","NI123456J","2020/01/01","M", "A", "B"),
		("HS1","NI123456A","2016/02/13","M", "D", "B"),
		("MAS1","NI123456E","2020/01/01","S", "D", "B"),
		("SW1","NI123456H","2020/01/01","M", "D", "B");
		
	  /*Employee Payroll Details*/
	DELETE FROM employee_payroll_details WHERE id !='';
	INSERT INTO employee_payroll_details
		(employee_id, payroll_id, tax_rate, rate_of_pay, commision_percentage, gets_blind_allowance, nic, pay_frequency)
	Values
		("MS1","NI123456B", 0, 4333.33, 0.00, 0, "A", "M1"),
		("BS1","NI123456C", 0, 8.83, 0.00, 0, "A", "M1"),
		("LS1","NI123456D", 0, 10000.00, 0.00, 0, "H", "M1"),
		("TR1","NI123456F", 0, 1500.00, 0.00, 0, "A", "M1"),
		("CE1","NI123456G", 0, 2400.00, 0.00, 0, "C", "M1"),
		("BM1","NI123456I", 0, 13000.00, 0.00, 0, "A", "M1"),
		("QE2","NI123456J", 0, 5000.00, 0.00, 0, "C", "M1"),
		("HS1","NI123456A", 0, 2000, 0.00, 0, "A", "W1"),
		("MAS1","NI123456E", 0, 4000, 0.00, 0, "Z", "W1"),
		("SW1","NI123456H", 0, 3000.00, 0.00, 1, "A", "W1");

	/*Employement Type*/
	DELETE FROM employment_type WHERE id !='';
	INSERT INTO  employment_type
		(employee_id, primary_employment, is_apprentice, is_casual_worker, employee_type)
	Values
		("MS1", 1, 0, 0, "S"),
		("BS1", 1, 1, 0, "V"),
		("LS1", 0, 0, 0, "S"),
		("TR1", 1, 0, 0, "S"),
		("CE1", 1, 0, 0, "S"),
		("BM1", 1, 0, 0, "S"),
		("QE2", 1, 0, 0, "P"),
		("HS1", 1, 0, 0, "S"),
		("MAS1", 0, 0, 0, "S"),
		("SW1", 1, 0, 0, "S");
    
END $$

DROP PROCEDURE IF EXISTS initialise_aeo $$
CREATE PROCEDURE initialise_aeo (IN employer_tax_year VARCHAR(4))
BEGIN	
	DECLARE loan_start DATE;
	SET loan_start = date(concat(year(date_sub(concat(employer_tax_year,'-01-01'), INTERVAL 1 YEAR)),'-01-01'));

	/* AEO Type */
	DELETE FROM aeo_type WHERE id !='';
	INSERT INTO 
		`aeo_type` (`id`,`type_name`, `deduction_type`, `pe_type`, `unpaid_bf`, `priority_order`, `description`) 
	VALUES 
		(1, "DEA", "T", "P", true, false, "Department of Work and Pensions"),
		(2, "DEO", "V", "A", true, true, "Child support"),
		(3, "CTAEO", "T", "N", false, true, "Council tax"),
		(4, "CMA", "D", "D", false, true, "Current maintenance agreement"),
		(5, "AEO", "T", "N", false, true, "Magistrates court AEO");
		
	/*Student Loan*/
	DELETE FROM student_loan WHERE id !='';
	INSERT INTO  student_loan
		(employee_id, start_date, original_amount, loan_type, current_amount)
	VALUES
		("LS1", loan_start, 1000, 1, 1000),
		("LS1", loan_start, 4000, 2, 4000),
		("LS1", loan_start, 3000, 3, 3000);
END$$
    
DROP PROCEDURE IF EXISTS initialise_payroll $$
CREATE PROCEDURE initialise_payroll (IN employer_tax_year VARCHAR(4))
BEGIN	
	SET foreign_key_checks = 0;
    
    CALL create_payroll_dates(employer_tax_year);

	-- Payroll Frequency
	DELETE FROM payroll_frequency WHERE id !='' AND tax_year_id = employer_tax_year;
	INSERT INTO  payroll_frequency
		(id, tax_year_id, pay_frequency_id, last_payroll_run_number)
	Values
		(1, employer_tax_year, "W1", 0),
		(2, employer_tax_year, "W2", 0),
		(3, employer_tax_year, "W4", 0),
		(4, employer_tax_year, "M1", 0),
		(5, employer_tax_year, "M3", 0),
		(6, employer_tax_year, "M6", 0),
		(7, employer_tax_year, "MA", 0),
		(8, employer_tax_year, "IO", 0),
		(9, employer_tax_year, "IR", 0);
		
	-- Payroll Run
	DELETE FROM payroll_run WHERE id !='' AND tax_year_id = employer_tax_year;
	INSERT INTO  payroll_run
		(payroll_number, tax_year_id, payroll_frequency_id, payroll_dates_id)
	Values
		(1, employer_tax_year, 1, getPayrollDateId_ForPayrollNum("W1",employer_tax_year,1)),
		(1, employer_tax_year, 4, getPayrollDateId_ForPayrollNum("M1",employer_tax_year,1));

	-- Employee Payroll Result
	DELETE FROM `employee_payroll_result` WHERE id !='';
	INSERT INTO `employee_payroll_result`
		(`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_details_payroll_id`, `gross_pay`, `basic_pay`, `net_pay`, `bonus`)
	Values
		((SELECT pr.id FROM
		payroll_run pr
	  Left Join
		payroll_frequency pf
	  ON
		pr.payroll_frequency_id = pf.Id
	  WHERE
		pf.pay_frequency_id = "W1"
	  AND
		pf.last_payroll_run_number = 0), employer_tax_year, 1, "NI123456D", 1200, 1000, 800, 0);
			
	-- Payroll Result Deduction
	DELETE FROM `payroll_result_deduction` WHERE id != '';    
	INSERT INTO `payroll_result_deduction`
		(`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_details_payroll_id`, `paye_tax`, `ni`, `pension`, `total`)
	  Values
		((SELECT pr.id FROM
		payroll_run pr
	  Left Join
		payroll_frequency pf
	  ON
		pr.payroll_frequency_id = pf.Id
	  WHERE
		pf.pay_frequency_id = "W1"
	  AND
		pf.last_payroll_run_number = 0), employer_tax_year, 1, "NI123456D", 123.45, 43.21, 0, 0);
	  
	-- Student Loan Deduction
	DELETE FROM `salaroo_uk`.`student_loan_deduction` WHERE id != '';
		
	SELECT max(prd.id) INTO @max_id FROM payroll_result_deduction prd;
	SELECT sl.id INTO @student_loan_id FROM student_loan sl WHERE sl.loan_type = 1 AND sl.employee_id = "LS1";
		
	INSERT INTO `salaroo_uk`.`student_loan_deduction`
		(`payroll_result_deduction_id`, `amount`, `loan_type`, `student_loan_id`, `student_loan_employee_id`)
	Values
		(@max_id, 50.12, 1, @student_loan_id, "LS1");
END$$
    
    
DROP PROCEDURE IF EXISTS `insert_payroll_data` $$
CREATE PROCEDURE insert_payroll_data (IN pay_id VARCHAR(14), IN basic_units INT, IN freq_id VARCHAR(3), IN tax_yr VARCHAR(4))
BEGIN	
	DECLARE salary_type VARCHAR(2);    
	DECLARE basic_amount DECIMAL(8,2);    
	DECLARE emp_rate DECIMAL(10,2);
	DECLARE bDone INT;
	DECLARE loan_amount DECIMAL(9,2);
	DECLARE the_loan_type ENUM('1', '2', '3');
	DECLARE payroll_data_id INT;
		
	/* 	Using current amount but this will have to change to the actual calculated amount.
		Probably from a temporary table
	*/
	DECLARE loan_cursor CURSOR FOR SELECT loan_type, current_amount FROM student_loan WHERE employee_id =  getEmpId_ForPayrollId(pay_id);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone=1;
	
	-- Insert the data
	INSERT INTO `payroll_data` (`payroll_run_id`, `employee_payroll_id`, `commission`) VALUES (getPayrollRunId(freq_id, tax_yr), pay_id, 0);
			
	-- Get the id to use in the child tables, i.e. employee_basic
	SELECT max(id) INTO payroll_data_id FROM payroll_data;
	
	-- Insert employee basic
	SET salary_type = getEmpType_ForPayrollId(pay_id);
	-- SELECT rate INTO basic_rate FROM employee_basic WHERE employee_payroll_details_payroll_id = pay_id;
	SELECT rate_of_pay INTO emp_rate FROM employee_payroll_details WHERE payroll_id = pay_id;
	
	IF salary_type = 'V' THEN
		SET basic_amount = emp_rate * basic_units;
	ELSE
		SET basic_amount = emp_rate;
	END IF;
	
	INSERT INTO employee_basic (`payroll_data_id`, `units`, `rate`, `total`) VALUES (payroll_data_id, basic_units, emp_rate, basic_amount);
	
	-- Insert a row for each loan
	OPEN loan_cursor;
	SET bDone = 0;
	read_loan_loop: LOOP
		FETCH loan_cursor INTO the_loan_type, loan_amount;
		IF bDone THEN
			LEAVE read_loan_loop;
		END IF;
		INSERT INTO payroll_student_loan (`payroll_data_id`, `loan_type`, `amount`) VALUES (payroll_data_id, the_loan_type, loan_amount); 
	END LOOP;
	CLOSE loan_cursor;
	
	-- Insert a row for each AEO
	-- etc, etc.........
END$$

DROP PROCEDURE IF EXISTS `initialise_leave` $$
CREATE PROCEDURE initialise_leave (IN employer_tax_year VARCHAR(4))
BEGIN	
	-- Leave 
	DELETE FROM `leave_type` WHERE id != '' AND tax_year_id = employer_tax_year;        
	INSERT INTO 
		`leave_type` (`leave_name`, `max_days`, `tax_year_id`) 
	VALUES 
		("Annual Leave", 27, employer_tax_year),
		("Sick Leave", 21, employer_tax_year),
		("Maternity Leave", 30, employer_tax_year),
		("Paternity Leave", 30, employer_tax_year);
END $$

DROP PROCEDURE IF EXISTS `create_payroll_dates` $$
CREATE PROCEDURE create_payroll_dates (IN tax_year varchar(4))
BEGIN	
	DECLARE pay_num INT;
    DECLARE date_from DATE;
    DECLARE date_to DATE;
    DECLARE end_date DATE;
    DECLARE last_day DATE;
    
    DELETE FROM payroll_dates WHERE id != '' AND payroll_dates.tax_year = tax_year;
    
    -- SET tax_year = year(date_sub(concat(tax_year,'-01-01'), INTERVAL 1 YEAR));
    SET end_date = DATE(concat(tax_year,'-04-05'));
    
    -- M1
    SET pay_num = 1;
    SET date_from = concat(tax_year,'-04-06');
    SET date_to = concat(tax_year,'-05-05');
    WHILE pay_num <= 12 DO
		SET date_from = date_add(date_from, INTERVAL 1 MONTH);
        SET date_to = date_add(date_to, INTERVAL 1 MONTH);
		INSERT INTO 
			`payroll_dates` (`tax_year`, `pay_frequency_id`, `payroll_number`, `date_from`, `date_to`) 
		VALUES 
			(tax_year, 'M1', pay_num, date_from, date_to);
		SET pay_num = pay_num + 1;        
    END WHILE;
    
    -- W1
    SET pay_num = 1;    
    SET date_from = concat(tax_year,'-04-06');
    SET date_to = date_add(date_from, INTERVAL 6 DAY);
    
    WHILE pay_num <= 52 DO 
		INSERT INTO 
			`payroll_dates` (`tax_year`, `pay_frequency_id`, `payroll_number`, `date_from`, `date_to`) 
		VALUES 
			(tax_year, 'W1', pay_num, date_from, date_to);
            
		SET date_from = date_add(date_to, INTERVAL 1 DAY);
        SET date_to = date_add(date_from, INTERVAL 6 DAY);
		SET pay_num = pay_num + 1;        
    END WHILE;
    
    -- set week 53 if there is one
    SET last_day = date_from;
    WHILE last_day <= end_date DO
		SET last_day = date_add(last_day, INTERVAL 1 DAY);
    END WHILE;
    
    INSERT INTO 
			`payroll_dates` (`tax_year`, `pay_frequency_id`, `payroll_number`, `date_from`, `date_to`) 
		VALUES 
			(tax_year, 'W1', pay_num, date_from, last_day);
    	
END$$
DELIMITER ;