CREATE DEFINER=`root`@`localhost` FUNCTION `get_payroll_data_id_for_pay_num`(
	empPayrollId VARCHAR(45),
    txYr VARCHAR(4),
    payFreqId INT,
    payNum INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE r_id INT;
    
	-- get payroll data id
	SELECT 
		pay_data.id
	INTO
		r_id
	FROM 
		payroll_run pay_run
		INNER JOIN payroll_data pay_data ON pay_data.payroll_run_id = pay_run.id
	WHERE 
		employee_payroll_id = empPayrollId
	AND
		tax_year_id = txYr
	AND
		payroll_frequency_id = payFreqId
	AND
		payroll_number = payNum;

	RETURN r_id;
END