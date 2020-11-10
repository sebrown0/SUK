DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS initialise_aeo $$
CREATE PROCEDURE initialise_aeo (IN employer_tax_year VARCHAR(4))
BEGIN	
	DECLARE loan_start DATE;
	SET loan_start = date(concat(year(date_sub(concat(employer_tax_year,'-01-01'), INTERVAL 1 YEAR)),'-01-01'));

	/* AEO Type */
	DELETE FROM aeo_type WHERE id !='';
	INSERT INTO 
		`aeo_type` (`id`,`type_name`, `deduction_type`, `pe_type`, `unpaid_bf`, `priority_order`, `description`) 
	VALUES 
		(1, "DEA", "T", "P", true, false, "Department of Work and Pensions"),
		(2, "DEO", "V", "A", true, true, "Child support"),
		(3, "CTAEO", "T", "N", false, true, "Council tax"),
		(4, "CMA", "D", "D", false, true, "Current maintenance agreement"),
		(5, "AEO", "T", "N", false, true, "Magistrates court AEO");
		
	/*Student Loan*/
	DELETE FROM student_loan WHERE id !='';
	INSERT INTO  student_loan
		(employee_id, start_date, original_amount, loan_type, current_amount)
	VALUES
		("LS1", loan_start, 1000, 1, 1000),
		("LS1", loan_start, 4000, 2, 4000),
		("LS1", loan_start, 3000, 3, 3000);
	END$$
DELIMITER ;