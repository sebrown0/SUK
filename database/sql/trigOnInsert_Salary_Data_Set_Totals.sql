USE salaroo_uk;
DROP TRIGGER IF EXISTS salary_data_BEFORE_INSERT;

DELIMITER $$
CREATE TRIGGER 
	salary_data_BEFORE_INSERT
BEFORE INSERT ON 
	salary_data
FOR EACH ROW
BEGIN
	SET NEW.basic_total = NEW.basic_units * NEW.basic_rate;
    SET NEW.ot_amount = NEW.ot_hours * NEW.ot_rate;
    SET NEW.total_gross = NEW.basic_total + NEW.ot_amount + NEW.commision + NEW.bonus;
END $$
DELIMITER ;
