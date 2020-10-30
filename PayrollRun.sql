SELECT id, max(last_payroll_run_number) FROM payroll_frequency WHERE pay_frequency_id = "W1";

-- get payroll run details for frequency and payroll number
SELECT pr.id, pr.payroll_frequency_id, pr.tax_year_id FROM 
	payroll_run pr
LEFT JOIN 
	payroll_frequency pf
ON
	pr.payroll_frequency_id = pf.id
WHERE
	pf.pay_frequency_id = "W1"
AND
	pr.payroll_number = 1;
    
    
UPDATE payroll_run pr SET pr.payroll_run_on = now() WHERE pr.ID = 2;

SELECT * FROM employee_payroll_result WHERE payroll_run_id = 2 AND payroll_run_tax_year_id = "2020" AND payroll_run_payroll_frequency_id = 1;

UPDATE employee_payroll_result 
SET 
	payroll_run_id = 1, payroll_run_tax_year_id = "2020", payroll_run_payroll_frequency_id = 1, 
    employee_payroll_details_payroll_id = "NI123456B", gross_pay = 1000, basic_pay = 1223, net_pay = 161, bonus = 0
WHERE
	id = 2;
    
-- GET emp pay result for payroll run id
SELECT epr.* FROM employee_payroll_result epr
LEFT JOIN  payroll_run pr
ON epr.payroll_run_id = pr.id
WHERE pr.id = 2;

SELECT 
	epr.id
FROM 
	employee_payroll_result epr 
WHERE  
	epr.payroll_run_id = 1 
AND  
	epr.payroll_run_payroll_frequency_id =1 -- could just use payroll_run_id
AND 
	epr.payroll_run_tax_year_id = "2020"; -- could just use payroll_run_id

-- get a payroll run for pay frequency and payroll number - USE THE ID (fk_payroll_run_id) COL FOR GETTING PAYROLL RESULT WITH TAX YEAR 
SELECT pr.id FROM 
	payroll_run pr
LEFT JOIN 
	payroll_frequency pf
ON
	pr.payroll_frequency_id = pf.id
WHERE
	pf.pay_frequency_id = "W1"
AND
	pf.last_payroll_run_number = 0;
    
-- get the last payroll in pay frequency
SELECT max(pr.payroll_number) FROM 
	payroll_run pr
LEFT JOIN 
	payroll_frequency pf
ON
	pr.payroll_frequency_id = pf.id
WHERE
	pf.pay_frequency_id = "W1";
    
    