USE salaroo_uk;
DROP FUNCTION IF EXISTS getEmpId_ForPayrollId;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getEmpId_ForPayrollId`(pay_id VARCHAR(45)) RETURNS VARCHAR(45)
    DETERMINISTIC
BEGIN
	DECLARE emp_id varchar(45);
    SELECT employee_id INTO emp_id FROM salaroo_uk.employee_payroll_details WHERE payroll_id = pay_id;
RETURN emp_id;
END$$
DELIMITER ;