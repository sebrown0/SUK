CREATE DEFINER=`root`@`localhost` PROCEDURE `get_postponement_for_id`(IN ppmntId INT)
BEGIN
	SELECT * FROM employee_postponement WHERE id = ppmntId;
END