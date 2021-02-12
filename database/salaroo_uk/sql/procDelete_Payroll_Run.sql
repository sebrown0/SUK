CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_payroll_run`(
	IN taxYr VARCHAR(4),
    IN payFreqId INT,
    IN payrollNumber INT)
BEGIN
	DELETE FROM 
		payroll_run
    WHERE 
		payroll_number = payrollNumber
	AND
		tax_year_id = taxYr
	AND
		payroll_frequency_id = payFreqId;
END