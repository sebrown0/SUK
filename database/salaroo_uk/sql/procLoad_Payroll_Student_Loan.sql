CREATE DEFINER=`root`@`localhost` PROCEDURE `load_payroll_student_loan`(
	IN payrollRunId INT)
BEGIN
	-- Get the student loans that are active from the
    -- student_loan table and load them into payroll.
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE payrollDataId INT;        
    DECLARE empPayrollId VARCHAR(45);
    DECLARE loanType INT;
    DECLARE loanAmount DECIMAL(9,2);
    DECLARE studentloanId INT;
    
	DECLARE curLoan 
    CURSOR FOR SELECT 
		pd.id AS payroll_data_id, pd.employee_payroll_id,
        sl.id AS student_loan_id, sl.current_amount, sl.loan_type        
	FROM 
		student_loan sl
		INNER JOIN 
			payroll_data pd ON sl.employee_id = pd.employee_id		
	WHERE
		pd.payroll_run_id = payrollRunId AND stop_notice_received = 0
	ORDER BY
		pd.employee_payroll_id, sl.loan_type;   
	
	DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET finished = 1;
    
	OPEN curLoan;
    load_payroll_loan: LOOP
		FETCH curLoan         
        INTO    	        
		payrollDataId, empPayrollId ,studentloanId,	loanAmount, loanType;
        IF finished = 1 THEN LEAVE load_payroll_loan; END IF;                   
        
		INSERT INTO 
			payroll_student_loan (`payroll_data_id`, `student_loan_id`, `emp_payroll_id`, `loan_type`, `amount`) 
        VALUES 
			(payrollDataId, studentloanId, empPayrollId , loanType, loanAmount);
	END LOOP;    
END