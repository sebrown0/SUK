CREATE DEFINER = CURRENT_USER TRIGGER `salaroo_uk`.`employee_payroll_result_AFTER_INSERT` AFTER INSERT ON `employee_payroll_result` FOR EACH ROW
BEGIN
	INSERT INTO payroll_payment_ytd (
		`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, 
        `employee_payroll_id`, `gross_pay`, `net_pay`, `commission`, `overtime`, `pension`, `expenses`) 
	VALUES (
		NEW.payroll_run_id, NEW.payroll_run_tax_year_id, 
        NEW.payroll_run_payroll_frequency_id, NEW.employee_payroll_details_payroll_id, 
		'NI123456D', NEW.gross_pay, NEW.net_pay, 0, 0, 0);
END
