USE salaroo_uk;
DROP TRIGGER IF EXISTS payroll_result_payment_AFTER_INSERT;

DELIMITER $$
CREATE TRIGGER 
	payroll_result_AFTER_INSERT
AFTER INSERT ON 
	payroll_result_payment
FOR EACH ROW
BEGIN 
	DECLARE oldGross DECIMAL(10,2) DEFAULT 0;
    DECLARE oldBasic DECIMAL(10,2) DEFAULT 0; 
    DECLARE oldNet DECIMAL(10,2) DEFAULT 0;
    DECLARE oldBonus DECIMAL(10,2) DEFAULT 0; 
    DECLARE oldCommission DECIMAL(10,2) DEFAULT 0; 
    DECLARE oldOvertime DECIMAL(10,2) DEFAULT 0; 
    DECLARE oldPension DECIMAL(10,2) DEFAULT 0; 
    DECLARE oldExpenses DECIMAL(10,2) DEFAULT 0;
     
    SELECT 
		gross_pay, basic_pay, net_pay, bonus, commission, overtime, pension, expenses
	INTO 
		oldGross, oldBasic, oldNet, oldBonus, oldCommission, oldOvertime, oldPension, oldExpenses 
	FROM 
		payroll_payment_ytd    
	WHERE
		payroll_run_tax_year_id = NEW.payroll_run_tax_year_id
	AND
		payroll_run_payroll_frequency_id = NEW.payroll_run_payroll_frequency_id
	AND
        employee_payroll_id = NEW.employee_payroll_details_payroll_id;
        
	INSERT INTO payroll_payment_ytd (
		`payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_id`,
        `gross_pay`, `basic_pay`, `net_pay`, `bonus`, `commission`, `overtime`, `pension`, `expenses`) 
	VALUES (
		NEW.payroll_run_tax_year_id, 
        NEW.payroll_run_payroll_frequency_id, 
        NEW.employee_payroll_details_payroll_id, 
		NEW.gross_pay + oldGross, 
        NEW.basic_pay + oldBasic, 
        NEW.net_pay + oldNet, 
        NEW.bonus + oldBonus,
        NEW.commission + oldCommission, 
        NEW.overtime + oldOvertime, 
        NEW.pension + oldPension, 
        NEW.expenses + oldExpenses)
	ON DUPLICATE KEY UPDATE
		gross_pay = NEW.gross_pay + oldGross,  
        basic_pay = NEW.basic_pay + oldBasic, 
        net_pay = NEW.net_pay + oldNet, 
        bonus = NEW.bonus + oldBonus,
        commission = NEW.commission + oldCommission,
        overtime = NEW.overtime + oldOvertime,
        pension = NEW.pension + oldPension, 
        expenses  = NEW.expenses + oldExpenses; 
END $$
DELIMITER ;