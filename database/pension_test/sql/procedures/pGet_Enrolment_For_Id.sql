CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enrolment_for_id`(IN enrlId INT)
BEGIN
	SELECT * FROM employee_enroled WHERE id = enrlId;
END