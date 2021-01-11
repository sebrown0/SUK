CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_loan_data_for_test_nums`(IN testNumArray VARCHAR(100))
BEGIN
	SELECT 		
		tst.id AS test_num, 
		loan.*
	FROM 
		test tst    
		LEFT JOIN test_data_student_loan loan ON tst.loan_test_num = loan.loan_test_num 
	WHERE 
		tst.id IN (testNumArray)
	ORDER BY
		tst.id;
END