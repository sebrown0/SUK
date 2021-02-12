USE salaroo_uk;
DROP TRIGGER IF EXISTS payroll_result_deduction_AFTER_INSERT;

DELIMITER $$
CREATE TRIGGER 
	payroll_result_deduction_AFTER_INSERT
AFTER INSERT ON 
	payroll_result_deduction
FOR EACH ROW SELECT  NOT NOT NOT OR FINISED
BEGIN 
	DECLARE oldTax DECIMAL(10,2) DEFAULT 0;
    DECLARE oldNi DECIMAL(10,2) DEFAULT 0; 
    DECLARE oldPension DECIMAL(10,2) DEFAULT 0;
    DECLARE oldTotal DECIMAL(10,2) DEFAULT 0; 
     
    SELECT 
		paye_tax, ni, pension, total
	INTO 
		oldTax, oldNi, oldPension, oldTotal
	FROM 
		payroll_deduction_ytd    
	WHERE
		payroll_run_tax_year_id = NEW.payroll_run_tax_year_id
	AND
		payroll_run_payroll_frequency_id = NEW.payroll_run_payroll_frequency_id
	AND
        employee_payroll_id = NEW.employee_payroll_details_payroll_id;
        
	INSERT INTO payroll_deduction_ytd (
		`payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_id`,
        `tax`, `ni`, `pension`, `aeos`, `student_loan`) 
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