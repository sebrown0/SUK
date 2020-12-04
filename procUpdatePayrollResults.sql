CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payroll_results`(
	IN prRunId INT,
    IN prRunTaxYearId INT,
    IN prPayrollFrequencyId INT,
    IN employeeId VARCHAR(20),
    IN grossPay DECIMAL(9,2),
    IN basicPay DECIMAL(9,2),
    IN netPay DECIMAL(9,2),
    IN bonus DECIMAL(8,2))
BEGIN
	INSERT INTO `salaroo_uk`.`employee_payroll_result`(	
		`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`,
		`employee_payroll_details_payroll_id`, `gross_pay`, `basic_pay`, `net_pay`, `bonus`)
	VALUES
		(prRunId, prRunTaxYearId, prPayrollFrequencyId, employeeId, grossPay, basicPay, netPay, bonus)
	ON DUPLICATE KEY UPDATE
		payroll_run_id = prRunId,
        payroll_run_tax_year_id = prRunTaxYearId,
        payroll_run_payroll_frequency_id = prPayrollFrequencyId,
		employee_payroll_details_payroll_id = employeeId,
        gross_pay = grossPay,
        basic_pay = basicPay,
        net_pay = netPay,
        bonus = bonus;
END