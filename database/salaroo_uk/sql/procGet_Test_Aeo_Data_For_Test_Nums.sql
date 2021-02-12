CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_aeo_data_for_test_nums`(IN testNumArray VARCHAR(100))
BEGIN
	SELECT 
		tst.id AS test_num, 
		aeo.*
	FROM 
		test tst    
		INNER JOIN test_data_aeo aeo ON tst.aeo_test_num = aeo.aeo_test_num 				
	WHERE 
		tst.id IN (testNumArray)
	ORDER BY
		tst.id;
END