CREATE DEFINER=`root`@`localhost` FUNCTION `get_employees_age`(empCode VARCHAR(45)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE empDOB DATE;
    DECLARE empAge INT;
    
    SELECT date_of_birth INTO empDOB FROM employee WHERE id = empCode;
    SELECT TIMESTAMPDIFF(YEAR, empDOB, CURDATE()) INTO empAge;
	
	RETURN empAge;
END