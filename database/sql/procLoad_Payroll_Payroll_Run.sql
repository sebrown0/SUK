CREATE DEFINER=`root`@`localhost` PROCEDURE `load_payroll_payroll_run`(
	IN taxYear VARCHAR(4),    
    IN freqId INT,
    OUT payrollNum INT,
    OUT payrollRunId INT)
BEGIN
	-- Load a new payroll run. 
    -- WARNING: THIS ROUTINE DELETES DATA FROM -
    -- payroll_result_deduction/employee_payroll_result/payroll_run tables.
    -- IF THERE HAS BEEN A PREVIOUS RUN FOR THE Freq, Year & Payroll Num.
	
    DECLARE thisPayrollNumber INT;         
    
    -- Get this (next) payroll number for the frequency and year (freqId above)
    SELECT last_payroll_run_number + 1 INTO thisPayrollNumber FROM payroll_frequency WHERE id = freqId;
    
    -- Delete the previous run if there was one. 
    -- This will also cascade to the payroll_result_deduction/employee_payroll_result tables.
    DELETE FROM payroll_run 
    WHERE payroll_number = thisPayrollNumber AND tax_year_id = taxYear AND payroll_frequency_id = freqId;
    
    -- Create a new payroll run and get the ID.    
	INSERT INTO  payroll_run
		(payroll_number, tax_year_id, payroll_frequency_id, payroll_dates_id)
	VALUES
		(
        thisPayrollNumber, taxYear, freqId, 
        getPayrollDateId_ForPayrollNum(get_frequency_for_freq_id(freqId), taxYear, thisPayrollNumber)
		);
        
	-- 'Return the payroll run id and payroll num from the new payroll run.
    SELECT MAX(id), payroll_number INTO payrollRunId, payrollNum 
    FROM payroll_run WHERE payroll_frequency_id = freqId
    GROUP BY payroll_frequency_id, payrollNum; 
END