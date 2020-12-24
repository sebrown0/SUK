CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_id_for_test_nums`(IN testNumArray VARCHAR(100))
BEGIN
	SELECT 
		tst.id AS test_num
	FROM 
		test tst    
	WHERE 
		tst.id IN (testNumArray)
	ORDER BY
		tst.id;
END