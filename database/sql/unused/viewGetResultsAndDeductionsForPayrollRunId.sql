CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `results_and_deductions_for_payroll_run_id` AS
    SELECT 
        `result`.`payroll_run_id` AS `payroll_run_id`,
        `result`.`employee_payroll_details_payroll_id` AS `result_payroll_id`,
        `result`.`gross_pay` AS `result_gross`,
        `result`.`basic_pay` AS `result_basic`,
        `result`.`bonus` AS `result_bonus`,
        `ded`.`paye_tax` AS `ded_paye_tax`,
        `ded`.`ni` AS `ded_ni`,
        `ded`.`total` AS `ded_total`
    FROM
        (`all_emp_results_for_payroll_run_id` `result`
        JOIN `all_emp_deductions_for_payroll_run_id` `ded` ON ((`result`.`employee_payroll_details_payroll_id` = `ded`.`employee_payroll_details_payroll_id`)))
    WHERE
        (`result`.`payroll_run_id` = GET_PAYROLL_RUN_ID_PARAM())