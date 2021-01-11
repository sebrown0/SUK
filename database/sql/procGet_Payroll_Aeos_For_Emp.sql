CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_aeos_for_emp`(
	IN taxYear VARCHAR(4),
    IN freqId INT,
    IN payrollNum INT,
    IN empPayrollId VARCHAR(45))
BEGIN	
	-- Get the payroll AEO data and join the last deduction for the AEO
	-- Return the RS ordered by the priority so that when the deductions occur
    -- in payroll we can be sure that they are in the correct order.    
	SELECT 	
		emp_aeo.id AS emp_aeo_id,
		pay_aeo.id AS pay_aeo_id, pay_aeo.payroll_data_id, pay_aeo.employee_aeo_id, pay_aeo.priority, pay_aeo.is_priority, 
		pay_aeo.deduction_amount, pay_aeo.deduction_type, pay_aeo.cumulative_unpaid, pay_aeo.pe_type, pay_aeo.pe_amount, 
        pay_aeo.deduct_admin_charge, pay_aeo.aeo_type_description, pay_aeo.order_date, pay_aeo.employee_id, 
		aeo_ded.id AS last_payroll_ded_id, 
		aeo_ded.employee_aeo_id AS emp_id,  
		aeo_ded.employee_aeo_employee_id AS aeo_emp_id, 
		aeo_ded.payroll_result_deduction_id AS res_ded_id, 
		aeo_ded.payroll_result_deduction_payroll_run_id AS res_ded_pay_run_id, 
		aeo_ded.payroll_result_deduction_payroll_run_tax_year_id AS res_ded_pay_tax_yr, 
		aeo_ded.payroll_result_deduction_payroll_run_payroll_frequency_id AS res_ded_pay_freq, 
		aeo_ded.amount_deducted, aeo_ded.amount_carried_forward, aeo_ded.pe_amount_carried_forward,
		aeo_ded.cumulative_carried_forward, aeo_ded.this_deduction_type, aeo_ded.ytd
	FROM payroll_data pay_data 
		INNER JOIN payroll_aeo pay_aeo ON pay_aeo.payroll_data_id = pay_data.id
			INNER JOIN employee_aeo emp_aeo ON emp_aeo.id = pay_aeo.employee_aeo_id
				-- Get the deduction from the last payroll
				LEFT JOIN aeo_deduction aeo_ded 
					ON aeo_ded.employee_aeo_id = 
						get_last_aeo_deduction_id(taxYear, freqId, get_payroll_data_id_for_pay_num(empPayrollId, taxYear, freqId, payrollNum), empPayrollId) 
	WHERE 
		emp_aeo.employee_id = getEmpId_ForPayrollId(empPayrollId) 
	AND 
		pay_data.id = salaroo_uk.get_payroll_data_id_for_pay_num(empPayrollId, taxYear, freqId, payrollNum)
	ORDER BY 
		pay_aeo.priority;
END