CREATE DEFINER=`root`@`localhost` PROCEDURE `ut_end`()
BEGIN
	ROLLBACK TO ut_savepoint;
    RELEASE SAVEPOINT ut_savepoint;
    SET autocommit = 1;  
END