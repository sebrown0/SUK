CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_log`()
BEGIN
	DELETE FROM log WHERE id <> "";
END