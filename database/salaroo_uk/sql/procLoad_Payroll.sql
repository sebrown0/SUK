CREATE DEFINER=`root`@`localhost` PROCEDURE `load_payroll`(
	IN taxYear VARCHAR(4),
    IN payFrequency VARCHAR(3))
BEGIN
	-- -----------------------------------------------------------------------------
    -- Get the necessary dato to run payroll and load into payroll_xxxx tables.
    -- The data comes from: 
    -- 		salary_data to make the emps' basic & gross.
    -- 		student_loan for the emps' loans (if any).
    -- 		employee_aeo for the emps' AEOs (if any).
    
    -- A new payroll run is added to payroll_run.
    -- This is one greater than the last run, i.e. it's sequential.
    
    -- payroll_data is a link table.
    -- It has all the emps that are included in the payroll with the payroll_run_id.
    -- The PK ID col of this table is a FK in all the payroll_xxxx tables.
    -- -----------------------------------------------------------------------------
	DECLARE payrollRunId INT; 
    DECLARE payrollNum INT; 
    DECLARE freqId INT;
    
    -- Get the frequency id for the frequency, i.e. 4 for M1
    SET freqId = getFrequencyId(payFrequency, taxYear);
     
	-- Load the payroll run and get the payroll_number & payroll_run_id.
    -- NOTE: There is no check on this side for valid payroll numbers!
    -- We could have some logic in the proc or probably better a table with a sequence for each payroll freq.
	CALL load_payroll_payroll_run(taxYear, freqId, @payrollNum, @payrollRunId);
    
    -- Load the data.
    CALL load_payroll_included_emps(@payrollRunId, freqId);
    CALL load_payroll_aeo(@payrollRunId);
    CALL load_payroll_student_loan(@payrollRunId);
         
    -- Update payroll_frequency 
    -- SHOULD THIS BE DONE AFTER PAYROLL HAS RUN ?? -- 
	UPDATE payroll_frequency SET last_payroll_run_number = @payrollNum WHERE id = freqId;
END