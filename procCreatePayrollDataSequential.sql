CREATE DEFINER=`root`@`localhost` PROCEDURE `create_payroll_data_sequential`(
	IN taxYear VARCHAR(4),
    IN payFrequencyId VARCHAR(2),
    IN testNum INT)
BEGIN
DECLARE freqId INT;
    DECLARE thisPayrollNumber INT;
    DECLARE payrollDateFrom DATE;
    DECLARE payrollDateTo DATE;
    DECLARE payrollRunId INT;
    
    SET freqId = getFrequencyId(payFrequencyId, taxYear);
    -- Get this (next) payroll number for the frequency and year (freqId above)
    SELECT pf.last_payroll_run_number + 1 INTO thisPayrollNumber FROM payroll_frequency pf WHERE pf.id = freqId;
    
    DROP TABLE IF EXISTS pay_dates_for_pay_num;
    CREATE TEMPORARY TABLE 
		pay_dates_for_pay_num
    SELECT * FROM 
		payroll_dates pd 
	WHERE pd.pay_frequency_id = freqId AND pd.tax_year = taxYear AND pd.payroll_number = thisPayrollNumber;    
    SELECT date_from INTO payrollDateFrom FROM pay_dates_for_pay_num; 
    SELECT date_to INTO payrollDateTo FROM pay_dates_for_pay_num; 
            
    -- Get employees with the pay frequency
    DROP TABLE IF EXISTS employees_to_include;
	CREATE TEMPORARY TABLE 	employees_to_include SELECT * FROM employee_payroll_details epd WHERE epd.pay_frequency = freqId;   
    
    -- Have to use another temp tbl because can't reference a temp table (employees_to_include) twice in MySQL!
    DROP TABLE IF EXISTS included_emps_payroll_id;
    CREATE TEMPORARY TABLE included_emps_payroll_id SELECT employees_to_include.payroll_id FROM employees_to_include;
    
    -- PTRANS
	INSERT INTO  payroll_run
		(payroll_number, tax_year_id, payroll_frequency_id, payroll_dates_id)
	Values
		(thisPayrollNumber, taxYear, freqId, getPayrollDateId_ForPayrollNum(payFrequencyId, taxYear, thisPayrollNumber));
    
    SELECT max(id) INTO payrollRunId FROM payroll_run; -- Created a new payroll run and this is the ID.

    -- PTRANS
    -- Insert a payroll data record for each included emp.
	CALL create_payroll_data_entry(payrollRunId);
 
    DROP TABLE IF EXISTS employee_leave_for_payroll;
    CREATE TEMPORARY TABLE 
		employee_leave_for_payroll
	SELECT lb.*, getDaysToInclude(lb.date_to, payrollDateTo, lb.num_days_booked) as days_included, eti.payroll_id  FROM 
		leave_booking lb
	INNER JOIN 
		employees_to_include eti
	ON
		lb.employee_id = eti.employee_id
	WHERE				
		(lb.date_from >= payrollDateFrom OR lb.date_to <= payrollDateTo) AND (lb.date_from <= payrollDateTo);
        
	-- CREATE TEST DATA
	CALL insert_test_data (taxYear, payFrequencyId, thisPayrollNumber, testNum);
	-- PTRANS
    -- DO THE INSERTS INTO ALL THE CHILD TABLES WITH FOR THE payroll_run.id AND payroll_data.id   	
    CALL insert_payroll_student_loans(payrollRunId);
    CALL insert_payroll_aeos(payrollRunId);
    CALL insert_payroll_leave(payrollRunId);         
    CALL insert_payroll_basic_and_gross(payrollRunId);
   
	-- PTRANS
	-- Update payroll_frequency
	UPDATE payroll_frequency SET last_payroll_run_number = thisPayrollNumber WHERE id = freqId;
END