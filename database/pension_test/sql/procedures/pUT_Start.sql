CREATE DEFINER=`root`@`localhost` PROCEDURE `ut_start`()
BEGIN
	SET autocommit = 0;  
	SAVEPOINT ut_savepoint;
END