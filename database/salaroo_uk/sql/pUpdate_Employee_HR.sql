CREATE DEFINER=`root`@`localhost` PROCEDURE `update_employee_hr`(
	IN empId VARCHAR(45), 
    IN startingDeclaration VARCHAR(1),
    IN startDate DATE,
    IN martialStatus VARCHAR(1),
    IN employeeHoursNormallyWorked VARCHAR(1))
BEGIN
	UPDATE employee_hr 
    SET 
		starting_declaration = startingDeclaration,
        start_date = startDate,
        martial_status = martialStatus,
        employee_hours_normally_worked = employeeHoursNormallyWorked
    WHERE 
		employee_id = empId;
END