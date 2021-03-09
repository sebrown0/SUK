CREATE DEFINER=`root`@`localhost` PROCEDURE `get_current_emp_eligibility`(IN empPenId VARCHAR(40))
BEGIN
	SELECT * FROM employee_eligibility 
	WHERE employee_pension_id = empPenId
	ORDER BY date_acheived DESC LIMIT 1;
END