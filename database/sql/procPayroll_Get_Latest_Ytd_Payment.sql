CREATE DEFINER=`root`@`localhost` PROCEDURE `payroll_get_latest_ytd_payment`(
	IN payFreqId INT,
    IN taxYear VARCHAR(4))
BEGIN
	-- Get the most upto data YTD payments for all employees with 
    -- payroll frequency: payFreqId
    -- tax year: taxYear 
	SELECT 
		* 
	FROM 
		payroll_payment_ytd p_ytd 
        INNER JOIN (
			SELECT MAX(id) AS latest_id
			FROM payroll_payment_ytd
			WHERE 
				payroll_run_payroll_frequency_id = payFreqId
			AND
				payroll_run_tax_year_id = taxYear
			GROUP BY payroll_run_tax_year_id, employee_payroll_id, payroll_run_payroll_frequency_id
    ) AS l_ytd ON l_ytd.latest_id = p_ytd.id
    ORDER BY p_ytd.employee_payroll_id;
END