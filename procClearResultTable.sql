CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_result_table`(
	IN payrollRunId INT,
    IN taxYear VARCHAR(4),
    IN payFrequencyId INT,    
	IN tableName VARCHAR(45))
BEGIN
	-- Clear any table (tableName) name that has the correct params        
    SET @s = CONCAT(
			'DELETE FROM ', tableName, 
			' WHERE payroll_run_id = ',  payrollRunId, 
			' AND payroll_run_payroll_frequency_id = ',  payFrequencyId, 
			' AND payroll_run_tax_year_id = ', "'", taxYear, "'");            
            	
	PREPARE stmt FROM @s; 
	EXECUTE stmt; 
	DEALLOCATE PREPARE stmt; 
END