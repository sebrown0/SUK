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