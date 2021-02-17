CREATE DEFINER=`root`@`localhost` PROCEDURE `get_last_assessment_for_emp`(IN empPenId VARCHAR(40))
BEGIN
	SELECT * FROM employee_assessment WHERE emp_pension_id = empPenId
	ORDER BY assessment_date LIMIT 1;
END