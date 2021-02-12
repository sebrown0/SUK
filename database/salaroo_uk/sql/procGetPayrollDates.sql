CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_dates`(
	IN taxYr VARCHAR(4), 
    IN freq VARCHAR(3),
    IN payNum INT)
BEGIN
	SELECT 
		pd.date_from, pd.date_to, pd.run_payroll_on, 
        pd.pay_emps_on, pd.payroll_number 
	FROM 
		payroll_dates pd
	WHERE
		pd.tax_year = taxYr
	AND
		pd.pay_frequency_id = freq
	AND
		pd.payroll_number = payNum;
END