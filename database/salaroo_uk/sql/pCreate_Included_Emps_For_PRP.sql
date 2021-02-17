CREATE DEFINER=`root`@`localhost` PROCEDURE `create_included_emps_for_prp`(
	IN payFreq VARCHAR(2))
BEGIN
	DROP TABLE IF EXISTS temp_included_emps;
    CREATE TEMPORARY TABLE temp_included_emps
	SELECT payroll_id
	FROM salaroo_uk.employee_payroll_details
	WHERE pay_frequency = payFreq;
END