
delete FROM payroll_leave where id != '';
delete FROM payroll_student_loan where id != '';
delete FROM payroll_aeo where id != '';
delete FROM payroll_data where id != '';
delete FROM employee_payroll_result where id != '';
delete FROM payroll_result_deduction where id != '';
delete FROM payroll_run where id !='';

UPDATE salaroo_uk.payroll_frequency set last_payroll_run_number = 0 WHERE id != -1;
