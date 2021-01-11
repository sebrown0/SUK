CREATE DEFINER=`root`@`localhost` PROCEDURE `update_test_as_fail`(IN testResultId INT)
BEGIN
	UPDATE test_result SET passed = 0 WHERE id = testResultId;
END