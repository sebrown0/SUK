-- Get the payroll basic & gross data from the Payroll Data tables.
DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS get_basic_and_gross $$
CREATE PROCEDURE get_basic_and_gross (
	IN taxYear VARCHAR(4),
    IN payFrequencyId INT,
    IN payrollNum INT)
BEGIN	
    SELECT 
		pd.id as payroll_data_id, pd.employee_payroll_id, pd.payroll_run_id, 
		pb.rate, pb.total, pb.units,
		pg.bonus, pg.commision, pg.overtime, pg.total_gross		
	FROM 
		payroll_data pd
		LEFT JOIN payroll_run pr ON pd.payroll_run_id = pr.id
		LEFT JOIN payroll_basic pb ON pd.ID = pb.payroll_data_id				
		LEFT JOIN payroll_gross pg ON pd.ID = pg.payroll_data_id
	WHERE
		pr.payroll_number = 1 AND pr.tax_year_id = taxYear AND pr.payroll_frequency_id = payFrequencyId;
END $$
DELIMITER ;