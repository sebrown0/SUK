-- HAVE TO CREATE THE payroll_run FIRST !!!!! --
-- ------------------------------------------ --

USE salaroo_uk;
DELIMITER $$
DROP PROCEDURE IF EXISTS `insert_test_data` $$
CREATE PROCEDURE `insert_test_data` (
	IN taxYr VARCHAR(4), 
    IN payFreq VARCHAR(2), 
    IN thePayrollNumber INT,
    IN testNum INT)
BEGIN
	DECLARE payFreqId INT;
    DECLARE payrollRunId INT;
    
	SELECT id INTO payFreqId FROM payroll_frequency WHERE pay_frequency_id = payFreq;
	SELECT id INTO payrollRunId FROM payroll_run WHERE tax_year_id = taxYr AND payroll_frequency_id = payFreqId AND payroll_number = thePayrollNumber;
	DELETE FROM payroll_test_data WHERE payroll_run_tax_year_id = taxYr AND payroll_run_payroll_frequency_id = payFreqId AND id != '';

    -- CHECK IF weekly OR monthly THEN WHICH testNum for the frequency.
    IF payFreq = 'W1' THEN
		-- SHOULD ONLY INCLUDE EMPS THAT ARE PAID FOR W1
		CASE testNum
			WHEN 1 THEN
				INSERT INTO 
					payroll_test_data (`emp_payroll_id`, `payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `commission`, `overtime_15`, `bonus`, `expenses`, `basic_hours`) 
				VALUES 
					('NI123456A', payrollRunId, taxYr, payFreqId, 1, 2, 3, 4, 0),
                    ('NI123456E', payrollRunId, taxYr, payFreqId, 1, 2, 3, 4, 0),
                    ('NI123456H', payrollRunId, taxYr, payFreqId, 1, 2, 3, 4, 0);
		END CASE;
	ELSE
		-- SHOULD ONLY INCLUDE EMPS THAT ARE PAID FOR M1
		CASE testNum
			WHEN 1 THEN
				INSERT INTO 
					payroll_test_data (`emp_payroll_id`, `payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `commission`, `overtime_15`, `bonus`, `expenses`, `basic_hours`) 
				VALUES 
					('NI123456B', payrollRunId, taxYr, payFreqId, 0, 0, 0, 0, 0),
                    ('NI123456C', payrollRunId, taxYr, payFreqId, 1000, 10, 0, 0, 173.33), -- THE ONLY VARIABLE HOURS EMP
                    ('NI123456D', payrollRunId, taxYr, payFreqId, 850, 0, 950, 1000, 0),
                    ('NI123456F', payrollRunId, taxYr, payFreqId, 0, 0, 0, 0, 0),
                    ('NI123456G', payrollRunId, taxYr, payFreqId, 0, 0, 0, 0, 0),
                    ('NI123456I', payrollRunId, taxYr, payFreqId, 0, 0, 0, 0, 0),
                    ('NI123456J', payrollRunId, taxYr, payFreqId, 0, 0, 0, 0, 0);
			END CASE;
		END IF;
	SELECT testNum, payroll_test_data.* FROM payroll_test_data;    
END $$
DELIMITER ;