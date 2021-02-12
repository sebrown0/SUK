CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_test_data_for_test_nums`(IN testNumArray VARCHAR(100))
BEGIN
	SELECT 
		tst.test_num, tst.description,
        sal.*,
		aeo.*,
		loan.*
	FROM 
		test tst    
		LEFT JOIN test_data_salary sal ON sal.salary_test_num = tst.salary_test_num
			 LEFT JOIN test_data_aeo aeo ON tst.aeo_test_num = aeo.aeo_test_num 	
				LEFT JOIN test_data_student_loan loan ON tst.student_loan_test_num = loan.student_loan_test_num 
	WHERE 
		tst.test_num IN (testNumArray)
	ORDER BY
		tst.test_num;
END