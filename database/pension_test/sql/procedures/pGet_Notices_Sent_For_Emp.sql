CREATE DEFINER=`root`@`localhost` PROCEDURE `get_notices_sent_for_emp`(IN empPenID VARCHAR(40))
BEGIN
	SELECT * FROM notices_sent
    WHERE employee_pension_id = empPenID;
END