-- Make sure that the CSV files are in SELECT @@global.secure_file_priv;.

USE salaroo_uk;
SET foreign_key_checks = 0;

-- Set the tax year (for this script) & create payroll dates for the year.
SET @employer_tax_year= '2021';
CALL create_payroll_dates(@employer_tax_year);

-- PAYROLL BELOW
TRUNCATE tax_year;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\tax_year.csv'
INTO TABLE tax_year 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE minimum_wage;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\minimum_wage.csv'
INTO TABLE minimum_wage 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE student_loan;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\student_loan.csv'
INTO TABLE student_loan 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE leave_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\leave_type.csv'
INTO TABLE leave_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE leave_booking;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\leave_booking.csv'
INTO TABLE leave_booking 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employment_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\employment_type.csv'
INTO TABLE employment_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employer;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\employer.csv'
INTO TABLE employer 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee_payroll_details;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\employee_payroll_details.csv'
INTO TABLE employee_payroll_details 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE salary_sacrifice;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\salary_sacrifice.csv'
INTO TABLE salary_sacrifice 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee_salary_sacrifice;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\employee_salary_sacrifice.csv'
INTO TABLE employee_salary_sacrifice 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE aeo_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\aeo_type.csv'
INTO TABLE aeo_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE aeo_agency;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\aeo_agency.csv'
INTO TABLE aeo_agency 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE address;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\emp_address.csv'
INTO TABLE address 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\emp.csv'
INTO TABLE employee 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee_hr;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\employee_hr.csv'
INTO TABLE employee_hr 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee_aeo;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\emp_aeo_data.csv'
INTO TABLE employee_aeo 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE payroll_frequency;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll\\payroll_frequency.csv'
INTO TABLE payroll_frequency 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET foreign_key_checks = 1;
-- ----------------------------- --
-- LOAD SALARY DATA FOR ALL EMPS --
-- ----------------------------- --
DELIMITER $$
DROP PROCEDURE IF EXISTS `load_salary_data`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `load_salary_data`(
	IN forEmpPayrollId VARCHAR(45),
    IN commission DECIMAL(8,2), 
    IN bonus DECIMAL(10,2), 
    IN expenses DECIMAL(8,2), 
    IN pension DECIMAL(8,2), 
    IN otHours DECIMAL(5,2),
    IN basicUnits DECIMAL(6,2))
BEGIN
	/* 	HAVE TO LOAD THIS MANUALLY UNTIL FIGURED OUT WHY 
		THERE'S A SYNTAX ERROR IN WORKBENCH ROUTINES */
        
	-- -------------------------------------------------------------------- --
	-- Take an emp's salary data and load it into payroll_salary_data.	    --
    -- The data is modified as necessary to calc OT, basic etc depending on --
    -- the emp type salaried/variable/PT.									--
    -- -------------------------------------------------------------------- --
    DECLARE salSacPension DECIMAL(10,2) DEFAULT 0.00;
    DECLARE salSacOther DECIMAL(10,2) DEFAULT 0.00;
    DECLARE salSacTotal DECIMAL(10,2) DEFAULT 0.00;    
	DECLARE basicRate DECIMAL(10,2) DEFAULT 0.00;
    DECLARE hoursWorked DECIMAL(6,2) DEFAULT 0.00;
    DECLARE otRate DECIMAL(5,2) DEFAULT 1.5;
    DECLARE otAmount DECIMAL(6,2) DEFAULT 0.00;
    DECLARE employeeType ENUM('S', 'P', 'V');
    DECLARE basicTotal DECIMAL(9,2) DEFAULT 0.00;
    DECLARE grossTotal DECIMAL(10,2) DEFAULT 0.00;
        
    -- Get the salary sacrifice totals
    CALL get_sal_sac_totals(forEmpPayrollId, salSacPension, salSacOther);
    SET salSacTotal = salSacPension + salSacOther;
    
    -- Calculate the differences between variable/salaried/pt emps.
    SET employeeType = getEmpType_ForPayrollId(forEmpPayrollId);
	IF NOT employeeType = 'V' THEN			
		SET basicUnits = 1; -- Always set the units to one unless the emp is variable hours.            
		SET otHours = 0; 	-- Only variable emps can have OT.
        SET otAmount = 0;
        SET otRate = 0;
		SET hoursWorked = get_emp_avg_hours_week(forEmpPayrollId); -- Can not have variable hours
		SET basicTotal = get_emp_rate_of_pay(forEmpPayrollId);
	ELSE
		SET hoursWorked = basicUnits + otHours;
        SET basicRate = get_emp_rate_of_pay(forEmpPayrollId);
		SET basicTotal = basicRate * basicUnits;
		-- We are just using the one OT rate of time and a half.
		-- This could be expanded to other rates, i.e. pass the rate as a param.
		SET otAmount = (basicRate * otRate) * otHours;
	END IF;
	SET grossTotal = basicTotal + otAmount + bonus + pension + commission;
    
    INSERT INTO payroll_salary_data (
		`emp_payroll_id`, `emp_id`, `pay_frequency`, `nic`, `tax_code`, `tax_rate`, 
        `basic_rate`, `notional_salary`,
        `basic_units`, `hours_worked`, `basic_amount`,
		`pension_total`, `commission`, `bonus`, `expenses`,
         `ot_hours`, `ot_rate`, `ot_amount`, `total_gross`, 
        `date_added`, `salary_sacrifice_pension`,`salary_sacrifice_total`
        )   
		WITH 
		emp_payroll_details AS (
			SELECT 
				payroll_id, employee_id, pay_frequency, nic, tax_code, tax_rate, 
				rate_of_pay, notional_rate_of_pay			
			FROM 
				employee_payroll_details 
			WHERE
				payroll_id = forEmpPayrollId
		), 
		inputed_data AS (
			SELECT forEmpPayrollId, basicUnits, otHours, pension, commission, bonus, expenses
		) 	SELECT 
				epd.*, 
				basicUnits, hoursWorked, basicTotal, inp.pension, inp.commission, inp.bonus, inp.expenses,
				otHours, otRate, otAmount, grossTotal, now(), salSacPension, salSacTotal
			FROM 
				emp_payroll_details epd 
			JOIN 
				inputed_data inp ON inp.forEmpPayrollId = epd.payroll_id;    
END$$
DELIMITER ;

-- LOAD SALARY DATA FOR EACH EMP.
-- forEmpPayrollId, commission, bonus, expenses, pension, OT hours, basic hours
CALL load_salary_data('NI123456A', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456B', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456C', 0, 0, 0, 0, 10, 40);
CALL load_salary_data('NI123456D', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456E', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456F', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456G', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456H', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456I', 0, 0, 0, 0, 0, 0);
CALL load_salary_data('NI123456J', 0, 0, 0, 0, 0, 0);