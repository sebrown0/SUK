CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_pension_details`(empId VARCHAR(20))
BEGIN
	SELECT * FROM employee_pension
    WHERE employee_id = empId;
END