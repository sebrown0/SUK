CREATE DEFINER=`root`@`localhost` PROCEDURE `get_last_postponement_for_emp`(IN empPenId VARCHAR(40))
BEGIN
	SELECT * FROM employee_postponement WHERE emp_pension_id = empPenId
	ORDER BY date_of_postponement LIMIT 1;
END