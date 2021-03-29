CREATE DEFINER=`root`@`localhost` PROCEDURE `update_employement_type`(
	IN empId VARCHAR(45), 
    IN primaryEmployment TINYINT,
    IN isApprentice TINYINT,
    IN isCasualWorker TINYINT,
    IN employeeType ENUM('S', 'P', 'V'))
BEGIN
	UPDATE employment_type
    SET 
        primary_employment = primaryEmployment,
        is_apprentice = isApprentice,
        is_casual_worker = isCasualWorker,
        employee_type = employeeType
    WHERE 
		employee_id = empId;
END