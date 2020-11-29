CREATE PROCEDURE `insert_payroll_student_loans` (IN payRunId INT)
BEGIN
DECLARE numLoansForEmp INT;
    DECLARE payrollDataId INT;
    DECLARE idx INT;
    DECLARE idx1 INT;
    DECLARE totalNumLoans INT;
    DECLARE empPayrollId VARCHAR(45);
    DECLARE loanType INT;
    DECLARE loanAmount DECIMAL(9,2);
    DECLARE studentloanId INT;
            
    DROP TABLE IF EXISTS student_loans;
    CREATE TEMPORARY TABLE 
		student_loans
    SELECT 
		sl.id as student_loan_id, sl.current_amount, sl.loan_type, eti.payroll_id FROM student_loan sl
	INNER JOIN 
		employees_to_include eti ON sl.employee_id = eti.employee_id;	
    
    SELECT count(*) INTO totalNumLoans FROM student_loans;    
    SET idx = 0;
    SET idx1 = 0;    
    WHILE idx < totalNumLoans DO    
		SELECT payroll_id INTO empPayrollId FROM student_loans LIMIT idx,1;                
        -- GET THE payroll_data.id FOR THE EMP AND payroll_run
        SELECT id INTO payrollDataId FROM payroll_data WHERE employee_payroll_id = empPayrollId AND payroll_run_id = payRunId;
		
        DROP TABLE IF EXISTS loan;
		CREATE TEMPORARY TABLE loan	SELECT * FROM student_loans WHERE payroll_id = empPayrollId;
    
		SELECT count(*) INTO numLoansForEmp FROM loan;    
        WHILE idx1 < numLoansForEmp DO
			SELECT loan.loan_type, loan.current_amount, student_loan_id INTO loanType, loanAmount, studentloanId FROM loan LIMIT idx1,1;
			INSERT INTO `payroll_student_loan` (`payroll_data_id`, `student_loan_id`, `loan_type`, `amount`) VALUES (payrollDataId, studentloanId, loanType, loanAmount);
			SET idx1 = idx1 + 1;
        END WHILE;
        SET idx = idx + 1;
	END WHILE;  
END