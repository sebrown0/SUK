SELECT * FROM salaroo_uk.test;
SELECT * FROM salaroo_uk.test_data_payroll_params;
SELECT * FROM salaroo_uk.test_result;
SELECT * FROM salaroo_uk.test_data_payroll_params;
SELECT * FROM salaroo_uk.test_data_employee;
SELECT * FROM salaroo_uk.test_data_salary;
SELECT * FROM salaroo_uk.test_data_ytd;
SELECT * FROM salaroo_uk.test_result_expected;

CALL get_all_test_data_for_test_nums('1');
CALL get_test_data_for_table_and_test_num('test_data_employee',1);
CALL run_error_report_for_category('AEO','CTAEO');
CALL diff_expected_and_actual_result(17, false);
CALL get_included_emp_for_test(7);
CALL get_emp_record_included_in_test(7);