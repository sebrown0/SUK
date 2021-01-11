CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_results_deductions_for_payroll_run_id`(
	IN payRunId INT,
    IN displayRS BOOLEAN)
BEGIN
	CALL get_all_emp_deductions_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_results_for_payroll_run_id(payRunId, FALSE);
    
    DROP TABLE IF EXISTS payroll_results_and_deductions;
    CREATE TEMPORARY TABLE payroll_results_and_deductions
    SELECT 
        `result`.`payroll_run_id` AS `payroll_run_id`,
        `result`.`employee_payroll_details_payroll_id` AS `result_payroll_id`,
        `result`.`gross_pay` AS `result_gross`,
        `result`.`basic_pay` AS `result_basic`,
        `result`.`bonus` AS `result_bonus`,
        `result`.`net_pay` AS `result_net`,
        `ded`.`paye_tax` AS `ded_paye_tax`,
        `ded`.`ni` AS `ded_ni`,
        `ded`.`total` AS `ded_total`
    FROM
        `all_emp_results_for_payroll_run_id` `result`
	JOIN 
        `all_emp_deductions_for_payroll_run_id` `ded` 
	ON 
		`result`.`employee_payroll_details_payroll_id` = `ded`.`employee_payroll_details_payroll_id`
    WHERE
        `result`.`payroll_run_id` = payRunId;
        
	IF displayRS = TRUE THEN
		SELECT * FROM payroll_results_and_deductions;
    END IF;
END