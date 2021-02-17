CREATE DEFINER=`root`@`localhost` PROCEDURE `get_eligibility_for_id`(IN eligibilityId INT)
BEGIN
	SELECT * FROM employee_eligibility WHERE id = eligibilityId;
END