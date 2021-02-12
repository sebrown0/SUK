CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_from_payroll_data_for_payroll_run`(	
    IN payrollRunId INT,
    IN empPayrollID VARCHAR(45))
BEGIN
	-- Get all an employee's details required for a payroll run.
    -- get_emps_from_payroll_data_for_payroll_run does the same but for all emps in the payroll run.
	
	SELECT       
		pd.id AS payroll_data_id, pd.payroll_run_id, 
        epd.*,
		emp.first_name, emp.last_name, emp.gender, emp.date_of_birth, emp.employer_id,
        et.primary_employment AS is_primary_employment, et.is_apprentice, et.is_casual_worker, et.employee_type,
        hr.ni_number, hr.start_date, hr.martial_status, hr.employee_hours_normally_worked
    FROM payroll_data pd
		INNER JOIN employee_payroll_details epd 
        ON pd.employee_payroll_id = epd.payroll_id
			INNER JOIN employee emp
			ON emp.id = epd.employee_id 
				INNER JOIN employment_type et
				ON et.employee_id = epd.employee_id
					INNER JOIN employee_hr hr
					ON hr.ni_number = epd.payroll_id
    WHERE 
		pd.payroll_run_id = payrollRunId
	AND
		epd.payroll_id = empPayrollID;
END