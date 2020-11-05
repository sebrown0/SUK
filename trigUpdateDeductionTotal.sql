USE salaroo_uk;
DROP TRIGGER IF EXISTS update_totals;

DELIMITER $$
CREATE TRIGGER 
	update_totals
BEFORE INSERT ON 
	payroll_result_deduction
FOR EACH ROW
BEGIN
	SET NEW.total = NEW.paye_tax + NEW.ni + NEW.pension;
END $$
DELIMITER ;