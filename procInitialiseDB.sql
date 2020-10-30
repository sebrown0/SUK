DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS `initialise_db` $$
CREATE PROCEDURE initialise_db
BEGIN
	
    DELIMITER ££    
	SET foreign_key_checks = 0££   
    
	/* Tax Year */
    DELETE FROM tax_year WHERE id !=''££
	INSERT INTO  tax_year
		(id, employer_id) 
	VALUES 
		("2020", "DAK1")££    
    
	/* Employee */
	DELETE FROM employee WHERE id !=''££
	INSERT INTO employee 
		(id, first_name, last_name, gender, date_of_birth, initials, employer_id) 
	VALUES 
		("MS1","Marge","Simpson","F","1985/05/12", "MS", "DAK1"),
		("BS1","Bart","Simpson","M","1996/12/25", "BS", "DAK1"),
		("LS1","Lisa","Simpson","F","1995/06/12", "LS", "DAK1"),
		("TR1","The","Rock","M","1980/01/01", "TR", "DAK1"),
		("CE1","Clint","Eastwood","M","1950/03/22", "CE", "DAK1"),
		("BM1","Bat","Man","M","1980/06/15", "BM", "DAK1"),
		("QE2","Queen Liz","The II","F","1920/09/27", "QE", "DAK1"),
		("HS1","Homer","Simpson","M","1980/04/01", "HS", "DAK1"),
		("MAS1","Maggie","Simpson","F","1998/05/06", "MAS", "DAK1"),
		("SW1","Stevie","Wonder","M","1970/01/01", "SW", "DAK1")££
		
	/* Address */
	DELETE FROM address WHERE id !=''££
	INSERT INTO address 
		(employee_id, number_or_name, street, district, city, post_code, country ) 
	VALUES 
		("MS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("BS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("LS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("TR1","12","Rocky Ave", "Ashton Vale","Bristol","BS3 7PQ", "England"),
		("CE1","99","Make My Day St", "Horfield","Newcastle","HR12 3PA", "England"),
		("BM1","Wayne Manor","1 Bat Cave Ave", "","Gotham","GT123", "England"),
		("QE2","Buck House","Strand", "Westminster","London","SW1A 1AA", "England"),
		("HS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("MAS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
		("SW1","4","Blues Rd", "Motown","Detroit","MT321", "England")££

	/*Employee HR*/
	DELETE FROM employee_hr WHERE id !=''££
	INSERT INTO employee_hr 
		(employee_id, ni_number, start_date, martial_status, employee_hours_normally_worked, starting_declaration) 
	VALUES 
		("MS1","NI123456B","2020/01/01","M", "D", "B"),
		("BS1","NI123456C","2020/01/01","S", "B", "B"),
		("LS1","NI123456D","2020/01/01","S", "D", "B"),
		("TR1","NI123456F","2020/05/01","S", "D", "B"),
		("CE1","NI123456G","2020/01/01","M", "D", "B"),
		("BM1","NI123456I","2020/01/01","S", "D", "B"),
		("QE2","NI123456J","2020/01/01","M", "A", "B"),
		("HS1","NI123456A","2016/02/13","M", "D", "B"),
		("MAS1","NI123456E","2020/01/01","S", "D", "B"),
		("SW1","NI123456H","2020/01/01","M", "D", "B")££
		
	/*Employee Payroll Details*/
	DELETE FROM employee_payroll_details WHERE id !=''££
	INSERT INTO employee_payroll_details 
		(employee_id, payroll_id, tax_rate, rate_of_pay, commision_percentage, gets_blind_allowance, nic, pay_frequency) 
	VALUES 
		("MS1","NI123456B", 0, 4333.33, 0.00, 0, "A", "M1"),
		("BS1","NI123456C", 0, 8.83, 0.00, 0, "A", "M1"),
		("LS1","NI123456D", 0, 10000.00, 0.00, 0, "H", "M1"),
		("TR1","NI123456F", 0, 1500.00, 0.00, 0, "A", "M1"),
		("CE1","NI123456G", 0, 2400.00, 0.00, 0, "C", "M1"),
		("BM1","NI123456I", 0, 13000.00, 0.00, 0, "A", "M1"),
		("QE2","NI123456J", 0, 5000.00, 0.00, 0, "C", "M1"),
		("HS1","NI123456A", 0, 2000, 0.00, 0, "A", "W1"),
		("MAS1","NI123456E", 0, 4000, 0.00, 0, "Z", "W1"),
		("SW1","NI123456H", 0, 3000.00, 0.00, 1, "A", "W1")££

	/*Employement Type*/
	DELETE FROM employment_type WHERE id !=''££
	INSERT INTO  employment_type
		(employee_id, primary_employment, is_apprentice, is_casual_worker, employee_type) 
	VALUES 
		("MS1", 1, 0, 0, "S"),
		("BS1", 1, 1, 0, "V"),
		("LS1", 0, 0, 0, "S"),
		("TR1", 1, 0, 0, "S"),
		("CE1", 1, 0, 0, "S"),
		("BM1", 1, 0, 0, "S"),
		("QE2", 1, 0, 0, "P"),
		("HS1", 1, 0, 0, "S"),
		("MAS1", 0, 0, 0, "S"),
		("SW1", 1, 0, 0, "S")££

	/*Student Loan*/
	DELETE FROM student_loan WHERE id !=''££
	INSERT INTO  student_loan
		(employee_id, start_date, amount, loan_type) 
	VALUES 
		("LS1", "2020/01/01", 1000, 1),
		("LS1", "2020/01/01", 4000, 2),
		("LS1", "2020/01/01", 3000, 3)££
    
    /****************
    * PAYROLL START *
    ****************/
    /*Payroll Frequency*/
	DELETE FROM payroll_frequency WHERE id !=''££
	INSERT INTO  payroll_frequency
		(id, tax_year_id, pay_frequency_id, last_payroll_run_number) 
	VALUES 
		(1, "2020", "W1", 0),
		(2, "2020", "W2", 0),
		(3, "2020", "W4", 0),
		(4, "2020", "M1", 0),
		(5, "2020", "M3", 0),
		(6, "2020", "M6", 0),
		(7, "2020", "MA", 0),
		(8, "2020", "IO", 0),
		(9, "2020", "IR", 0)££
		
	/*Payroll Run*/
	DELETE FROM payroll_run WHERE id !=''££
	INSERT INTO  payroll_run
		(payroll_number, tax_year_id, payroll_frequency_id) 
	VALUES 
		(1, "2020", 1)££
		
	/*Employee Basic*/
	/* 
		Units = number of hours etc (default is 1)
		Rate = rate of pay    
	*/
	DELETE FROM employee_basic WHERE id !='';
	INSERT INTO  employee_basic
		(employee_payroll_details_payroll_id, rate) 
	VALUES 
		("NI123456B", 4333.33)££

	DELETE FROM `salaroo_uk`.`employee_payroll_result` WHERE id !=''££
     -- SET payrollRunId = 8££
    /*SELECT pr.id INTO payrollRunId FROM 
		payroll_run pr
	LEFT JOIN 
		payroll_frequency pf
	ON
		pr.payroll_frequency_id = pf.id
	WHERE
		pf.pay_frequency_id = "W1"
	AND
		pf.last_payroll_run_number = 0££*/
    
	INSERT INTO `salaroo_uk`.`employee_payroll_result` 
		(`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_details_payroll_id`, `gross_pay`, `basic_pay`, `net_pay`, `bonus`) 
	VALUES 
		((SELECT pr.id FROM 
		payroll_run pr
	LEFT JOIN 
		payroll_frequency pf
	ON
		pr.payroll_frequency_id = pf.id
	WHERE
		pf.pay_frequency_id = "W1"
	AND
		pf.last_payroll_run_number = 0), "2020", 1, "NI123456B", 1200, 1000, 800, 0)££
    
    SET foreign_key_checks = 1££
     
END $$
DELIMITER ;