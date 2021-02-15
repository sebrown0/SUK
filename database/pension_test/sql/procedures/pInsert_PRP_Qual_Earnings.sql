CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_prp_qual_earnings`(
	IN empPenId VARCHAR(40),
    IN testDate DATE)
BEGIN	
    DECLARE prpTaxYr VARCHAR(4);
    DECLARE prpPayFreq VARCHAR(2);
    DECLARE prpAmount DECIMAL(10,2) DEFAULT 0.00;

	SELECT prp_tax_year, prp_pay_frequency, prp_amount 
    INTO prpTaxYr, prpPayFreq, prpAmount
    FROM temp_test_data;
        
    IF prpAmount IS NULL THEN SET prpAmount = 0; END IF;
        
	TRUNCATE `salaroo_uk_pension_test`.`pay_reference_period_qual_earnings` ;
	INSERT INTO 
		`salaroo_uk_pension_test`.`pay_reference_period_qual_earnings` 
        (`employee_pension_id`, `record_date`, `amount`, `prp_tax_year`, `prp_pay_frequency`) 
	VALUES 
		(empPenId, testDate, prpAmount, prpTaxYr, prpPayFreq);
END