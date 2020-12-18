CREATE DEFINER=`root`@`localhost` FUNCTION `get_payroll_id_for_emp_id`(emp_id VARCHAR(45)) RETURNS varchar(45) CHARSET utf8
    DETERMINISTIC
BEGIN
	DECLARE pay_id varchar(45);
    SELECT payroll_id INTO pay_id FROM salaroo_uk.employee_payroll_details WHERE employee_id = emp_id;
RETURN pay_id;
END