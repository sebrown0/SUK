/*
    
    .Name = EmployeeDataRow.Offset(0, 1)
    .Gender = EmployeeDataRow.Offset(0, 2)
    .NINumber = EmployeeDataRow.Offset(0, 3)
    .DOB = EmployeeDataRow.Offset(0, 4)
    .StartDate = EmployeeDataRow.Offset(0, 5)
    .MartialStatus = EmployeeDataRow.Offset(0, 6)
    
    .EmployeeType = EmployeeDataRow.Offset(0, 8)
    .AvgHourPerWeek = EmployeeDataRow.Offset(0, 9)
    .CasualWorker = CBool(EmployeeDataRow.Offset(0, 12))
    .PrimaryEmployment = CBool(EmployeeDataRow.Offset(0, 13))
    .Apprentice = CBool(EmployeeDataRow.Offset(0, 14))
    
    'Calculated flds
    .Age = SetAge(EmployeeDataRow.Offset(0, 4))
    .UpdateTaxCode EmployeeDataRow.Offset(0, 11)
    
    SetEmployeeStudentLoans
    SetPayPeriod
*/

-- Get employees with the pay frequency
DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS rollCall $$
CREATE PROCEDURE rollCall (
	IN taxYear VARCHAR(4),
    IN freq VARCHAR(2),
    IN payrollNum INT) -- THIS IS TEST NUM AS WELL
BEGIN	
	DECLARE freqId INT;
	
    -- Load payroll/test data
    CALL salaroo_uk.create_payroll_data(taxYear, freq, 1);
        	
    SET freqId = getFrequencyId(freq, taxYear);
    
    DROP TABLE IF EXISTS included_loans;
    CREATE TEMPORARY TABLE included_loans 
	SELECT 
		pd.employee_payroll_id, pd.payroll_run_id, 		
		psl.amount, psl.loan_type, psl.student_loan_id,
        sl.start_date, sl.original_amount, sl.current_amount
	FROM 
		payroll_data pd
		LEFT JOIN payroll_run pr ON pd.payroll_run_id = pr.id		
		INNER JOIN payroll_student_loan psl ON pd.ID = psl.payroll_data_id
        LEFT JOIN student_loan sl ON psl.student_loan_id = sl.id		
	WHERE		
		pr.payroll_number = 1 -- payrollNum 
	AND 
		pr.tax_year_id = taxYear 
	AND 
		pr.payroll_frequency_id = 4; -- freqId;
	-- AND
		-- pd.employee_payroll_id = empPayrollId;	

	DROP TABLE IF EXISTS roll_call;
    CREATE TEMPORARY TABLE roll_call 
	SELECT 
		epd.payroll_id, epd.employee_id, epd.tax_rate, epd.rate_of_pay, epd.commision_percentage, epd.gets_blind_allowance, epd.nic, epd.pay_frequency 
    FROM 
		employee_payroll_details epd 
	WHERE 
		epd.pay_frequency = freq;    
    
    DROP TABLE IF EXISTS roll_call_with_data;
    CREATE TEMPORARY TABLE roll_call_with_data 
	SELECT 
		rc.*,
        ptd.basic_hours, ptd.bonus, ptd.commission, ptd.expenses, ptd.overtime_15,
        il.amount, il.loan_type, il.start_date, il.original_amount, il.current_amount
	FROM 
		roll_call rc
	INNER JOIN
		payroll_test_data ptd
	ON
		rc.payroll_id = ptd.emp_payroll_id
	LEFT JOIN 
		included_loans il
	ON
		rc.payroll_id = il.employee_payroll_id;
        
 select * from roll_call_with_data;
END $$
DELIMITER ;

CALL RollCall('2021','M1', 1);