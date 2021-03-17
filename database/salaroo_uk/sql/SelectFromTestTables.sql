SELECT * FROM test;
SELECT * FROM test_result;
SELECT * FROM test_data_student_loan;
SELECT * FROM test_data_salary;
SELECT * FROM test_data_ytd;
SELECT * FROM test_result_expected;

CALL get_all_test_data_for_test_nums('1');
CALL get_test_data_for_table_and_test_num('test_data_student_loan',1);
CALL run_error_report_for_category('AEO','CTAEO');
CALL diff_expected_and_actual_result(17, false);
CALL get_emp_record_included_in_test(7);