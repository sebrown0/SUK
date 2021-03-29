CREATE DEFINER=`root`@`localhost` PROCEDURE `update_employee`(
	IN empId VARCHAR(45), 
    IN dob DATE)
BEGIN
	UPDATE employee
    SET 
        date_of_birth = dob
    WHERE 
		id = empId;
END