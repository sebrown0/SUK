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
		(employee_id, payroll_id, tax_rate, rate_of_pay, commision_percentage, gets_blind_allowance, nic, pay_frequency, tax_code, avg_hours_per_week)
	VALUES
		("MS1","NI123456B", 40, 4333.33, 0.00, 0, "A", "M1", "1250M1", 40),
		("BS1","NI123456C", 20, 8.83, 0.00, 0, "A", "M1", "1250L", 40),
		("LS1","NI123456D", 45, 10000.00, 0.00, 0, "H", "M1", "1250L", 40),
		("TR1","NI123456F", 20, 1500.00, 0.00, 0, "A", "M1", "1250L", 50),
		("CE1","NI123456G", 20, 2400.00, 0.00, 0, "C", "M1", "1250L", 40),
		("BM1","NI123456I", 45, 13000.00, 0.00, 0, "A", "M1", "1250L", 20),
		("QE2","NI123456J", 40, 5000.00, 0.00, 0, "C", "M1", "NT", 5),
		("HS1","NI123456A", 20, 2000, 0.00, 0, "A", "W1", "1250L", 40),
		("MAS1","NI123456E", 40, 4000, 0.00, 0, "Z", "W1", "1250L", 20),
		("SW1","NI123456H", 20, 3000.00, 0.00, 1, "A", "W1", "K1000", 60);

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
		
END$$    
 
-- Leave
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
        
	DELETE FROM `leave_booking` WHERE id != '';   
	INSERT INTO 
		`leave_booking` (`leave_type_id`, `num_days_booked`, `employee_id`, `date_from`, `date_to`) 
	VALUES 
		(1, 8, 'MAS1', '2021-04-09', '2021-04-16'),
		(1, 1, 'LS1', '2021-04-06', '2021-04-06'),
        (2, 2, 'LS1', '2021-05-06', '2021-05-07'),
        (3, 3, 'LS1', '2021-06-16', '2021-06-18'),
        (1, 1, 'MS1', '2021-04-06', '2021-04-06'),
        (2, 2, 'MS1', '2021-05-06', '2021-05-07'),
        (3, 3, 'MS1', '2021-06-16', '2021-06-18'),
        (1, 1, 'HS1', '2021-04-06', '2021-04-06'),
        (2, 3, 'HS1', '2021-04-11', '2021-04-13'),
        (3, 3, 'HS1', '2021-06-16', '2021-06-18'),
        (4, 3, 'HS1', '2021-07-16', '2021-07-18'),
        (1, 1, 'TR1', '2021-06-06', '2021-06-06'),
        (2, 7, 'TR1', '2021-07-10', '2021-07-17'),
        (1, 3, 'BM1', '2021-05-06', '2021-05-08'),
        (2, 4, 'BM1', '2021-07-10', '2021-07-14');
END $$
DELIMITER ;