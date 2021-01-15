CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emps_from_payroll_data_for_payroll_run`(	
    IN payrollRunId INT)
BEGIN
	-- Get all the employee details required for a payroll run.
    -- Only the emps that are in the payroll_data for the payrollRunId (payroll run) are included.
	SELECT       
		pd.id AS payroll_data_id, pd.payroll_run_id, 
        epd.employee_id, epd.payroll_id,        
        epd.tax_rate, epd.rate_of_pay, epd.commision_percentage, epd.gets_blind_allowance, 
        epd.nic, epd.pay_frequency, epd.tax_code, epd.avg_hours_per_week,        
        hr.ni_number, hr.start_date, hr.martial_status, hr.employee_hours_normally_worked,
        emp.first_name, emp.last_name, emp.gender, emp.date_of_birth,
        et.primary_employment, et.is_apprentice, et.is_casual_worker, et.employee_type
    FROM payroll_data pd
		INNER JOIN employee_payroll_details epd 
        ON pd.employee_payroll_id = epd.payroll_id
			INNER JOIN employee_hr hr
			ON hr.employee_id = epd.employee_id 
				INNER JOIN employee emp
				ON emp.id = hr.employee_id 
					INNER JOIN employment_type et
					ON et.employee_id = hr.employee_id 
    WHERE 
		pd.payroll_run_id = payrollRunId;
END