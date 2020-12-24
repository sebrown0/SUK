CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_salary_data_for_test_nums`(IN testNumArray VARCHAR(100))
BEGIN
	SELECT 
		tst.id AS test_num, 
        sal.*		
	FROM 
		test tst    
		INNER JOIN test_data_salary sal ON sal.salary_test_num = tst.salary_test_num			 
	WHERE 
		tst.id IN (testNumArray)
	ORDER BY
		tst.id;
END