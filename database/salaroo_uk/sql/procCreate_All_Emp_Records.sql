CREATE DEFINER=`root`@`localhost` PROCEDURE `create_all_emp_records`()
BEGIN
	-- --------------------------------------------------------------------------
    -- Create a temp table with all fields required to create an employee record.
    -- This procedure can then be called by others procs and 
    -- fields/records can be picked from the temp table.
    -- --------------------------------------------------------------------------
    
	DROP TABLE IF EXISTS temp_all_emp_recs;
    CREATE TEMPORARY TABLE temp_all_emp_recs
	SELECT 
		epd.employee_id,epd.payroll_id, epd.tax_rate, epd.tax_code, epd.rate_of_pay, epd.notional_rate_of_pay, 
		epd.commision_percentage, epd.gets_blind_allowance, epd.nic, epd.pay_frequency, epd.avg_hours_per_week,  
		emp.first_name, emp.last_name, emp.date_of_birth, emp.gender, emp.employer_id,
		hr.ni_number, hr.start_date ,hr.martial_status , hr.employee_hours_normally_worked,
		et.employee_type, et.primary_employment AS is_primary_employment, et.is_apprentice, et.is_casual_worker,
        get_employees_age(epd.employee_id) AS emp_age
	FROM employee_hr hr 
		JOIN employee_payroll_details epd ON hr.ni_number = epd.payroll_id
			JOIN employee emp ON epd.employee_id = emp.id
				JOIN employment_type et ON epd.employee_id = et.employee_id;
END