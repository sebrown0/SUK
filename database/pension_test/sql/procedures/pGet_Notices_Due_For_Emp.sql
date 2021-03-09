CREATE DEFINER=`root`@`localhost` PROCEDURE `get_notices_due_for_emp`(IN empPenID VARCHAR(40))
BEGIN
	SELECT * FROM notices_due
    WHERE employee_pension_id = empPenID;
END