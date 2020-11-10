DELIMITER $$
USE salaroo_uk $$
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
DELIMITER ;