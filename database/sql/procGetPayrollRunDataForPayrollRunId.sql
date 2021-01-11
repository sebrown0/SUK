CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_run_data_for_payroll_run_id`(
	IN payRunId INT,
    IN displayRS BOOLEAN)
BEGIN	
	CALL get_all_emp_gross_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_aeos_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_s_loans_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_basic_for_payroll_run_id(payRunId, FALSE);    
   
	DROP TABLE IF EXISTS payroll_run_data_for_payroll_run_id;
    CREATE TEMPORARY TABLE payroll_run_data_for_payroll_run_id
    SELECT 
        `gross`.`payroll_run_id` AS `payroll_run_id`,
        `gross`.`employee_payroll_id` AS `employee_payroll_id`,
        `gross`.`commision` AS `gross_commision`,
        `gross`.`total_gross` AS `gross_total_gross`,
        `gross`.`bonus` AS `gross_bonus`,
        `gross`.`overtime` AS `gross_overtime`,
		`basic`.`units` AS `basic_units`,
        `basic`.`rate` AS `basic_rate`,
        `basic`.`total` AS `basic_total`,
        `loans`.`employee_id` AS `loan_employee_id`,
        `loans`.`student_loan_deduction_id` AS `loan_student_loan_deduction_id`,
        `loans`.`start_date` AS `loan_start_date`,
        `loans`.`original_amount` AS `loan_original_amount`,
        `loans`.`loan_type` AS `loan_loan_type`,
        `loans`.`current_amount` AS `loan_loan_current`,
        `loans`.`reason_for_deduction` AS `loan_reason_for_deduction`,
        `loans`.`stop_notice_received` AS `loan_stop_notice_received`,
        `aeos`.`date_added_to_payroll` AS `aeo_date_added_to_payroll`,
        `aeos`.`is_priority` AS `aeo_is_priority`,
        `aeos`.`priority` AS `aeo_priority`,
        `aeos`.`status` AS `aeo_status`,
        `aeos`.`frequency` AS `aeo_frequency`,
        `aeos`.`type` AS `aeo_type`,
        `aeos`.`agency` AS `aeo_agency`,
        `aeos`.`ytd` AS `aeo_ytd`,
        `aeos`.`start_date` AS `aeo_start_date`,
        `aeos`.`original_amount` AS `aeo_original_amount`,
        `aeos`.`current_amount` AS `aeo_current_amount`,
        `aeos`.`order_date` AS `aeo_order_date`,
        `aeos`.`apply_from` AS `aeo_apply_from`,
        `aeos`.`stop_order` AS `aeo_stop_order`,
        `aeos`.`ref_number` AS `aeo_ref_number`,
        `aeos`.`pe_type` AS `aeo_pe_type`,
        `aeos`.`pe_amount` AS `aeo_pe_amount`,
        `aeos`.`is_unpaid_bf` AS `aeo_is_unpaid_bf`,
        `aeos`.`deduction_type` AS `aeo_deduction_type`,
        `aeos`.`deduction_amount` AS `aeo_deduction_amount`
    FROM
        (((`all_emp_gross_for_payroll_run_id` `gross`
        LEFT JOIN `all_emp_basic_for_payroll_run_id` `basic` ON ((`basic`.`employee_payroll_id` = `gross`.`employee_payroll_id`)))
        LEFT JOIN `all_emp_s_loans_for_payroll_run_id` `loans` ON ((`loans`.`employee_payroll_id` = `gross`.`employee_payroll_id`)))
        LEFT JOIN `all_emp_aeos_for_payroll_run_id` `aeos` ON ((`aeos`.`employee_payroll_id` = `gross`.`employee_payroll_id`)))
    WHERE
        (`gross`.`payroll_run_id` = payRunId);
        
	IF displayRS = TRUE THEN
		SELECT * FROM payroll_run_data_for_payroll_run_id;
    END IF;
END