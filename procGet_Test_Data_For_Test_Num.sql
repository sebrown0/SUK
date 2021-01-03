CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_data_for_test_num`(IN testNum INT)
BEGIN
	SELECT * FROM test WHERE test_num = testNum;
END