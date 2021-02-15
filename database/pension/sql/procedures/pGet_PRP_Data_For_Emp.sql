CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prp_data_for_emp`(
	IN empPensionId VARCHAR(40),
    IN payFreq VARCHAR(2),
    IN forDate DATE)
BEGIN
	-- Get the prp (dates, prp number etc).
    -- If there's any prp earnings return those as well.
	DECLARE prpId INT DEFAULT 0;
    SET prpId = get_prp_id_for_freq_and_date(payFreq, forDate);
    
	WITH prp_qe AS(
		SELECT * FROM 
			pay_reference_period_qual_earnings 
		WHERE 
			pay_reference_period_id = prpId
		AND
			employee_pension_id = empPensionId
		ORDER BY record_date DESC LIMIT 1
		) 
		SELECT 
			prp.pay_frequency, prp.prp_number, prp.date_from, prp.date_to, prp.run_payroll_on, prp.pay_emps_on,
			prp_qe.pay_reference_period_id, prp_qe.employee_pension_id, prp_qe.record_date, prp_qe.amount, prp_qe.prp_tax_year	
			FROM 
				prp_qe
				RIGHT JOIN pay_reference_period prp 
				ON prp.id = prp_qe.pay_reference_period_id
				WHERE prp.id = prpId; 
END