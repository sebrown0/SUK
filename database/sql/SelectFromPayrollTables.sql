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

-- from code
select payroll_result_deduction_id,employee_aeo_id,employee_aeo_employee_id,payroll_result_deduction_payroll_run_id,
payroll_result_deduction_payroll_run_tax_year_id,payroll_result_deduction_payroll_run_payroll_frequency_id,amount_deducted,
amount_carried_forward,pe_amount_carried_forward,cumulative_carried_forward,this_deduction_type,ytd from aeo_deduction where 1=0

-- actual
id, employee_aeo_id, employee_aeo_employee_id, 
payroll_result_deduction_id, payroll_result_deduction_payroll_run_id, payroll_result_deduction_payroll_run_tax_year_id, payroll_result_deduction_payroll_run_payroll_frequency_id, amount_deducted, amount_carried_forward, pe_amount_carried_forward, cumulative_carried_forward, this_deduction_type, ytd
select * from aeo_deduction;