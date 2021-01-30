CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_record_pay_freq`(IN payFreq VARCHAR(2))
BEGIN
	-- Get the fields needed to create a record for employees with pay freq.
    CALL create_all_emp_records();    
	SELECT * FROM temp_all_emp_recs WHERE pay_frequency = payFreq;	
END