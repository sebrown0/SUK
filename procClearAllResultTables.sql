CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_all_result_tables`(
	IN payrollRunId INT,
    IN taxYear VARCHAR(4),
    IN payFrequencyId INT)
BEGIN
    CALL clear_result_table(payrollRunId, taxYear, payFrequencyId, 'payroll_result_deduction');
    CALL clear_result_table(payrollRunId, taxYear, payFrequencyId, 'employee_payroll_result');
END