CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_payroll_student_loans`(IN payRunId INT)
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE payrollDataId INT;        
    DECLARE loanType INT;
    DECLARE loanAmount DECIMAL(9,2);
    DECLARE studentloanId INT;
    -- DECLARE empPayrollId VARCHAR(45);
    
    DECLARE loansCur CURSOR FOR SELECT 
		sl.id as student_loan_id, sl.current_amount, sl.loan_type, 
        -- eti.payroll_id,
        pd.id AS payroll_data_id
	FROM 
		student_loan sl
	INNER JOIN 
		employees_to_include eti ON sl.employee_id = eti.employee_id
	INNER JOIN 
		payroll_data pd ON pd.employee_payroll_id = eti.payroll_id
	WHERE
		pd.payroll_run_id = payRunId
	ORDER BY
		eti.payroll_id, sl.loan_type;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN loansCur;
    read_loop: LOOP
		FETCH loansCur INTO studentloanId, loanAmount, loanType, payrollDataId;
		IF done THEN
			LEAVE read_loop;
		END IF;
        INSERT INTO `payroll_student_loan` (`payroll_data_id`, `student_loan_id`, `loan_type`, `amount`) VALUES (payrollDataId, studentloanId, loanType, loanAmount);
    END LOOP;
    CLOSE loansCur;    
END