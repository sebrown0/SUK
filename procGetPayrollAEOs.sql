-- Get the AEOs from the Payroll Data tables and join on AEO Type and AEO.
DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS get_payroll_aeo $$
CREATE PROCEDURE get_payroll_aeo (
	IN taxYear VARCHAR(4),
    IN payFrequencyId INT,
    IN payrollNum INT)
BEGIN	
	SELECT 
		pd.employee_payroll_id, pd.payroll_run_id, 		
		paeo.aeo_type_id, paeo.employee_aeo_id, paeo.id,
        aeo.start_date, aeo.original_amount, aeo.current_amount,
        aeot.type_name, aeot.deduction_type, aeot.pe_type, aeot.unpaid_bf, aeot.priority_order
	FROM 
		payroll_data pd
		LEFT JOIN payroll_run pr ON pd.payroll_run_id = pr.id		
		INNER JOIN payroll_aeo paeo ON pd.ID = paeo.payroll_data_id		
        LEFT JOIN employee_aeo aeo ON paeo.aeo_type_id = aeo.id
        LEFT JOIN aeo_type aeot ON aeo.aeo_type_id = aeot.id
	WHERE
		pr.payroll_number = payrollNum AND pr.tax_year_id = taxYear AND pr.payroll_frequency_id = payFrequencyId;    
END $$
DELIMITER ;