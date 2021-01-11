USE salaroo_uk;
DROP FUNCTION IF EXISTS getDaysToInclude;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getDaysToInclude`(booking_to DATE, payrollDateTo DATE, booked_days INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE daysToInclude INT;
    DECLARE daysDiff INT;
    
	SET daysDiff = DATEDIFF(booking_to, payrollDateTo);
	IF daysDiff > 0 THEN
		SET booked_days = booked_days - daysDiff;
    END IF;

RETURN booked_days;
END$$
DELIMITER ;

         