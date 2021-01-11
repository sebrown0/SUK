DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS initialise_payroll $$
CREATE PROCEDURE initialise_payroll (IN employer_tax_year VARCHAR(4))
BEGIN	
    SET foreign_key_checks = 0;
    
    CALL create_payroll_dates(employer_tax_year);

	-- Payroll Frequency
	DELETE FROM payroll_frequency WHERE id !='' AND tax_year_id = employer_tax_year;
	INSERT INTO  payroll_frequency
		(id, tax_year_id, pay_frequency_id, last_payroll_run_number)
	Values
		(1, employer_tax_year, "W1", 0),
		(2, employer_tax_year, "W2", 0),
		(3, employer_tax_year, "W4", 0),
		(4, employer_tax_year, "M1", 0),
		(5, employer_tax_year, "M3", 0),
		(6, employer_tax_year, "M6", 0),
		(7, employer_tax_year, "MA", 0),
		(8, employer_tax_year, "IO", 0),
		(9, employer_tax_year, "IR", 0);
		
END$$
DELIMITER ;    