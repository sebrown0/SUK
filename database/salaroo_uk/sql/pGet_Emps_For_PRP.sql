CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emps_for_prp`(IN payFreq VARCHAR(2))
BEGIN
	SELECT payroll_id, employee_id 
	FROM salaroo_uk.employee_payroll_details
	WHERE pay_frequency = payFreq;
END