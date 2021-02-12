USE salaroo_uk;
DROP FUNCTION IF EXISTS getEmpType_ForPayrollId;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getEmpType_ForPayrollId`(emp_pay_id VARCHAR(12)) RETURNS VARCHAR(1)
    DETERMINISTIC
BEGIN
	DECLARE emp_type VARCHAR(1);
	SELECT 
		et.employee_type 
	INTO
		emp_type
	FROM 
		salaroo_uk.employment_type et
	LEFT JOIN 
		employee_payroll_details epd 
	ON
		et.employee_id = epd.employee_id
	WHERE
		epd.payroll_id = emp_pay_id;

RETURN emp_type;
END$$
DELIMITER ;