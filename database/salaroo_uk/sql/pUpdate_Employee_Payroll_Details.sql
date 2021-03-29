CREATE DEFINER=`root`@`localhost` PROCEDURE `update_employee_payroll_details`(
	IN empId VARCHAR(45), 
    IN taxRate DECIMAL(5,2),
    IN rateOfPay DECIMAL(10,2),
    IN notionalRateOfPay DECIMAL(10,2),
    IN getsBlindAllowance TINYINT,
    IN nationalInsuranceCode VARCHAR(1),
    IN payFrequency ENUM('W1', 'W2', 'W4', 'M1', 'M3', 'M6', 'MA', 'IO', 'IR'),
    IN taxCode VARCHAR(12),
    IN avgHoursPerWeek DECIMAL(5,2))
BEGIN

	UPDATE employee_payroll_details
    SET 
        tax_rate = taxRate,
        rate_of_pay = rateOfPay,
        notional_rate_of_pay = notionalRateOfPay,
        gets_blind_allowance = getsBlindAllowance,
        nic = nationalInsuranceCode,
        pay_frequency = payFrequency,
        tax_code = taxCode,
        avg_hours_per_week = avgHoursPerWeek
    WHERE 
		employee_id = empId;
END