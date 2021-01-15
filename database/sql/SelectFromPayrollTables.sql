-- Payroll data
SELECT * FROM payroll_run;
SELECT * FROM payroll_data;
SELECT * FROM payroll_basic;
SELECT * FROM payroll_gross;
SELECT * FROM payroll_aeo;
SELECT * FROM payroll_student_loan;

-- Results
SELECT * FROM employee_payroll_result;
SELECT * FROM payroll_result_deduction;
SELECT * FROM student_loan_deduction;
SELECT * FROM payroll_payment_ytd;

SELECT 
	aeo.*, 
    ded.amount_deducted, ded.amount_carried_forward, ded.pe_amount_carried_forward, 
    ded.cumulative_carried_forward, ded.deduction_status, ded.ytd 
FROM aeo_deduction ded
JOIN employee_aeo aeo ON ded.employee_aeo_id = aeo.id;

CALL get_payroll_results_deductions_for_payroll_run_id(10, true);

CALL get_emps_from_payroll_data_for_payroll_run(2);
