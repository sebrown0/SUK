CREATE DEFINER=`root`@`localhost` PROCEDURE `get_postponement_for_id`(IN id INT)
BEGIN
	SELECT * FROM employee_postponement WHERE employee_postponement.id = id;
END