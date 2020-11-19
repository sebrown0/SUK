-- Get employees with the pay frequency
DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS get_included_employees $$
CREATE PROCEDURE get_included_employees (
	IN taxYear VARCHAR(4),
    IN freq VARCHAR(2))
BEGIN	    
	SELECT 
		epd.payroll_id, epd.employee_id, epd.commision_percentage, epd.gets_blind_allowance, epd.nic, epd.pay_frequency, epd.rate_of_pay, epd.tax_rate,
        e.date_of_birth, e.employer_id, e.first_name, e.gender, e.last_name,
        hr.employee_hours_normally_worked, hr.martial_status, hr.ni_number, hr.start_date,
        et.employee_type, et.is_apprentice, et.is_casual_worker, et.primary_employment
	FROM 
		employee_payroll_details epd 
	INNER JOIN 
		employee e
	ON
		epd.employee_id = e.id
    INNER JOIN  
        employee_hr hr
	ON
		epd.employee_id = hr.employee_id
	INNER JOIN  
        employment_type et
	ON
		epd.employee_id = et.employee_id
	WHERE 
		epd.pay_frequency = freq;    
END $$
DELIMITER ;
