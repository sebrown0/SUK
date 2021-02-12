CREATE DEFINER=`root`@`localhost` PROCEDURE `update_deduction_results`(
	IN prRunId INT,
    IN prRunTaxYearId INT,
    IN prPayrollFrequencyId INT,
    IN employeeId VARCHAR(20),
    IN payeTax DECIMAL(7,2),
    IN empNi DECIMAL(7,2),
    IN empPension DECIMAL(7,2),
    IN aeoTotal DECIMAL(8,2), 
    IN studentLoanTotal DECIMAL(8,2),
    IN otherAmount DECIMAL(8,2),
    IN totalDeduction DECIMAL(8,2))
BEGIN
	INSERT INTO `salaroo_uk`.`payroll_result_deduction`(
		`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`,
		`employee_payroll_details_payroll_id`, `paye_tax`, `ni`, `pension`,
        `aeo_total`, `student_loan_total`, `other`, `total`)
	VALUES
		(prRunId, prRunTaxYearId, prPayrollFrequencyId, 
        employeeId, payeTax, empNi, empPension, 
        aeoTotal, studentLoanTotal, otherAmount, totalDeduction)
	ON DUPLICATE KEY UPDATE
		payroll_run_id = prRunId,
        payroll_run_tax_year_id = prRunTaxYearId,
        payroll_run_payroll_frequency_id = prPayrollFrequencyId,
		employee_payroll_details_payroll_id = employeeId,
        paye_tax = payeTax,
        ni = empNi,
        pension = empPension,
        aeo_total = aeoTotal, 
        student_loan_total = studentLoanTotal, 
        other = otherAmount,
        total = totalDeduction;
END