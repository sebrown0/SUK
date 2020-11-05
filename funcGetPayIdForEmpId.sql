USE salaroo_uk;
DROP FUNCTION IF EXISTS getPayrollId_ForEmpId;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getPayrollId_ForEmpId`(emp_id VARCHAR(45)) RETURNS VARCHAR(45)
    DETERMINISTIC
BEGIN
	DECLARE pay_id varchar(45);
    SELECT payroll_id INTO pay_id FROM salaroo_uk.employee_payroll_details WHERE employee_id = emp_id;
RETURN pay_id;
END$$
DELIMITER ;