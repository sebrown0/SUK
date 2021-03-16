CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_pension_details`(IN empPenId VARCHAR(45))
BEGIN
	SELECT * FROM employee_pension
    WHERE employee_pension_id = empPenId;
END