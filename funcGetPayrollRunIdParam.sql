CREATE DEFINER=`root`@`localhost` FUNCTION `get_payroll_run_id_param`() RETURNS int
    NO SQL
    DETERMINISTIC
BEGIN
RETURN @payrollRunId;
END