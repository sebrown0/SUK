CREATE DEFINER=`root`@`localhost` PROCEDURE `date_spa_reached_for_emp`(
	IN empId VARCHAR(45))
BEGIN
	DECLARE empDOB DATE;
    DECLARE dobFrom DATE;
    DECLARE dobTo DATE;
    DECLARE dateSpaReached DATE;
    DECLARE spaYear INT DEFAULT 0;
        
	SELECT date_of_birth INTO empDOB FROM employee WHERE id = empId;
    
    IF empDOB <= "1977-04-04" THEN
		SET dateSpaReached = DATE_ADD(empDOB, INTERVAL 67 YEAR);
        SET spaYear = 67;
	ELSEIF empDOB >= "1978-04-06" THEN
		SET dateSpaReached = DATE_ADD(empDOB, INTERVAL 68 YEAR);
        SET spaYear = 68;
	ELSE
		SELECT date_spa_reached INTO dateSpaReached FROM state_pension_age_67_to_68
		WHERE dob_from <= empDOB AND dob_to >= empDOB;
        SET spaYear = 68;
    END IF;

    SELECT empDOB AS emp_dob, spaYear AS spa_year, dateSpaReached AS date_spa_reached;
END