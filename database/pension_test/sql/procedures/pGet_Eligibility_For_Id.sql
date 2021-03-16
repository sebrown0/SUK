CREATE DEFINER=`root`@`localhost` PROCEDURE `get_eligibility_for_id`(IN id INT)
BEGIN
	SELECT * FROM employee_eligibility WHERE employee_eligibility.id = id;
END