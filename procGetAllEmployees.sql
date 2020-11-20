DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS getAllEmployees $$
CREATE PROCEDURE getAllEmployees ()
BEGIN
	SELECT 
		epd.payroll_id, epd.employee_id, epd.commision_percentage, epd.gets_blind_allowance, epd.nic, 
        epd.pay_frequency, epd.rate_of_pay, epd.tax_rate, epd.tax_code, epd.avg_hours_per_week,
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
		epd.employee_id = et.employee_id;
        
        /*
	SELECT 
		e.first_name, e.last_name, hr.ni_number 
	FROM 
		employee e 
		INNER JOIN 	
			employee_hr hr ON e.id = hr.employee_id;*/
END$$
DELIMITER ;