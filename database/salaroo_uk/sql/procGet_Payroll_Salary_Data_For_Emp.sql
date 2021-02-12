CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_salary_data_for_emp`(
	IN payrollId VARCHAR(25),
	IN payFrequency VARCHAR(3))
BEGIN
	SELECT 
		sal_data.*
	FROM (
		SELECT 
			MAX(date_added) AS date_added , emp_payroll_id
			FROM salaroo_uk.payroll_salary_data GROUP BY emp_payroll_id) AS latest
				 INNER JOIN payroll_salary_data sal_data 
					ON latest.date_added = sal_data.date_added 
					AND latest.emp_payroll_id = sal_data.emp_payroll_id
	WHERE 
		sal_data.emp_payroll_id = payrollId
	AND
		sal_data.pay_frequency = payFrequency;
END