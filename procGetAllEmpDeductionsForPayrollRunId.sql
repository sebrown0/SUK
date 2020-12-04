CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_emp_deductions_for_payroll_run_id`(
	IN payrollRun INT,
    IN returnRs BOOLEAN)
BEGIN
	DROP TABLE IF EXISTS all_emp_deductions_for_payroll_run_id;
CREATE TABLE all_emp_deductions_for_payroll_run_id 
SELECT 
	prd.payroll_run_id, prd.employee_payroll_details_payroll_id,
    prd.paye_tax, prd.ni, prd.total 
FROM
    payroll_result_deduction prd
WHERE
    prd.payroll_run_id = payrollRun; 
        
	IF returnRs = TRUE THEN
		SELECT * FROM all_emp_deductions_for_payroll_run_id;
	END IF;
END