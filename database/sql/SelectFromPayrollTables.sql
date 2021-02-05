-- Payroll data
SELECT * FROM payroll_run ORDER BY payroll_frequency_id,payroll_number;
SELECT * FROM payroll_data;
SELECT * FROM payroll_salary_data;
SELECT * FROM payroll_aeo;
SELECT * FROM payroll_student_loan;
SELECT * FROM payroll_dates;
SELECT * FROM payroll_frequency; -- ISSUE:- payroll_frequency IS GETTING OUT OF SYNCH WITH payroll_run

-- Results
SELECT * FROM payroll_result_payment;
SELECT * FROM payroll_result_deduction; -- 
SELECT * FROM student_loan_deduction;
SELECT * FROM aeo_deduction; --
SELECT * FROM payroll_payment_ytd;
SELECT * FROM payroll_deduction_ytd;

-- Various
CALL delete_payroll_run('2021',4,4);
CALL get_payroll_ytd ('2021',4);
CALL get_emp_from_payroll_data_for_payroll_run(1,'NI123456B');
CALL get_payroll_run_id('2021','W1',2);
CALL get_payroll_aeos_for_emp('2021',4,1,"NI123456D");
CALL get_payroll_dates('2021','M1',1);

CALL get_included_emps_for_payroll(1);
CALL get_emp_records_included_in_payroll(1);

CALL get_payroll_ytd_for_emp('2021','W1','NI123456A');
CALL get_payroll_student_loans('2021','M1',1, 'NI123456D');
CALL get_payroll_salary_data_for_emp('NI123456A','W1');
CALL get_emp_record('NI123456A');
SELECT get_next_payroll_number('2021','M1');

SELECT 
	aeo.*, 
    ded.amount_deducted, ded.amount_carried_forward, ded.pe_amount_carried_forward, 
    ded.cumulative_carried_forward, ded.deduction_status, ded.ytd 
FROM aeo_deduction ded
JOIN employee_aeo aeo ON ded.employee_aeo_id = aeo.id;

CALL get_payroll_results_deductions_for_payroll_run_id(10, true);
