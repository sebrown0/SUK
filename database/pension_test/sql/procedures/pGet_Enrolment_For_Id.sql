CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enrolment_for_id`(IN id INT)
BEGIN
	SELECT * FROM employee_enroled WHERE employee_enroled.id = id;
END