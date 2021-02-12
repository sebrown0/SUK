CREATE DEFINER=`root`@`localhost` PROCEDURE `update_aeo_priority`(IN aeoId INT, IN priority INT)
BEGIN
	UPDATE employee_aeo SET `priority` = priority WHERE id = aeoId;
END