CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payroll_frequency_last_run`(
	IN taxYr VARCHAR(4),
    IN freqId INT)
BEGIN
	DECLARE lastPayroll INT DEFAULT 0;
    DECLARE revertToPayroll INT DEFAULT 0;
    DECLARE maxPayrolls INT DEFAULT 0;
    
    SELECT last_payroll_run_number, max_payrolls INTO lastPayroll, maxPayrolls
	FROM payroll_frequency
	WHERE tax_year_id = taxYr AND pay_frequency_id = freqId;
        
	SET revertToPayroll = lastPayroll - 1;
    
    IF revertToPayroll < 0 THEN
		SET revertToPayroll = 0;
	ELSEIF revertToPayroll > maxPayrolls THEN
		SET revertToPayroll = maxPayrolls;
    END IF;
    
    UPDATE payroll_frequency SET last_payroll_run_number = revertToPayroll
    WHERE tax_year_id = taxYr AND pay_frequency_id = freqId;
END