CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_runs`(
	IN tax_year VARCHAR(4),
    IN pay_freq VARCHAR(3))
BEGIN
SELECT 
	pr.id, pr.payroll_run_on, pr.payroll_number, 
    pd.date_from, pd.date_to, pd.pay_emps_on
FROM 
	payroll_run pr
LEFT JOIN
	payroll_dates pd
ON
	pr.payroll_dates_id = pd.id
WHERE
	pr.tax_year_id = tax_year
AND
	pd.pay_frequency_id = pay_freq
ORDER BY
	pr.payroll_frequency_id, pr.payroll_number;
END