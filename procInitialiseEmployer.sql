DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS initialise_employer $$
CREATE PROCEDURE initialise_employer (
	IN employer_id VARCHAR(45),
    IN employer_name VARCHAR(45),
    IN employer_hmrc_office_number VARCHAR(45),
    IN employer_paye_reference VARCHAR(45),
    IN employer_id_accounts_office_reference VARCHAR(45),
    IN employer_tax_year VARCHAR(4))
BEGIN	
    SET foreign_key_checks = 0;
    
	/*Employer*/
	DELETE FROM employer WHERE id = employer_id;
	INSERT INTO  employer
		(id, `name`, hmrc_office_number, paye_reference, accounts_office_reference) 
	VALUES 
		(employer_id, employer_name, employer_hmrc_office_number, employer_paye_reference, employer_id_accounts_office_reference); 
	
	/* Tax Year */
    DELETE FROM tax_year WHERE id =employer_tax_year AND tax_year.employer_id = employer_id;
	INSERT INTO  tax_year
		(id, employer_id) 
	VALUES 
		(employer_tax_year, employer_id);
	
    /*Payroll Frequency*/
	DELETE FROM payroll_frequency WHERE tax_year_id = employer_tax_year;    
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
    
    SET foreign_key_checks = 1;         
END $$
DELIMITER ;