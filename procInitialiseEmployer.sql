DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS initialise_employer $$
CREATE PROCEDURE initialise_employer
BEGIN	
    DELIMITER ££        	
    SET foreign_key_checks = 0££         
    
	/*Employer*/
	DELETE FROM employer WHERE id !='';
	INSERT INTO  employer
		(id, `name`, hmrc_office_number, paye_reference, accounts_office_reference) 
	VALUES 
		("DAK1", "Dakar", "123", "PAYE123", "ACCOUNTSREF123"); 
        
	/* Tax Year */
    DELETE FROM tax_year WHERE id !=''££
	INSERT INTO  tax_year
		(id, employer_id) 
	VALUES 
		("2020", "DAK1")££     
    
    SET foreign_key_checks = 1££         
END $$
DELIMITER ;