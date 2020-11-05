DELIMITER //
USE salaroo_uk //
DROP PROCEDURE IF EXISTS `create_leave_entry` //
CREATE PROCEDURE create_leave_entry (IN date_from DATE, IN date_to DATE, IN leave_type INT, IN emp_id VARCHAR(45))
BEGIN	
/*
	1. get the emp's payroll freq
    2. get the payroll_dates.id

*/
END//
DELIMITER ;