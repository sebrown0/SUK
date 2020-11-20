
delete FROM payroll_leave where id != '';
delete FROM payroll_student_loan where id != '';
delete FROM payroll_aeo where id != '';
delete  FROM payroll_run where id !='';
delete from payroll_data where id != '';

UPDATE salaroo_uk.payroll_frequency set last_payroll_run_number = 0 WHERE id != -1;

-- SELECT * FROM payroll_run;

commit;