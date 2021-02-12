CREATE DEFINER=`root`@`localhost` PROCEDURE `create_temp_tables_used_in_views`()
BEGIN
	CREATE TABLE all_emp_gross_for_payroll_run_id  SELECT 1=0;
	CREATE TABLE all_emp_basic_for_payroll_run_id  SELECT 1=0;
    CREATE TABLE all_emp_results_for_payroll_run_id  SELECT 1=0;  
    CREATE TABLE all_emp_deductions_for_payroll_run_id  SELECT 1=0;  
END