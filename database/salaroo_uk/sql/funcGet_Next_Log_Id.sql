CREATE DEFINER=`root`@`localhost` FUNCTION `get_next_log_id`() RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE lastID INT DEFAULT 0;
    
    SELECT MAX(id) INTO lastID
    FROM log 
    LIMIT 1;
    
    IF lastID IS NULL THEN 
		SET lastID = 0;
	END IF;
	RETURN lastID + 1;    
END