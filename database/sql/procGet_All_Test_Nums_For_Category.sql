CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_test_nums_for_category`(
	IN categoryIdent VARCHAR(20),
    IN subCategoryIdent VARCHAR(20))
BEGIN
	DECLARE catExpression VARCHAR(40) DEFAULT '';
    
    IF NOT (upper(subCategoryIdent) != 'NONE' OR subCategoryIdent = '') THEN
		SET catExpression = concat(categoryIdent, ' -%');        
	ELSE		
		SET catExpression = concat(categoryIdent, ' - ', subCategoryIdent);        	               	        
    END IF;
    SELECT test_num FROM salaroo_uk.test WHERE test.category LIKE(catExpression);         
END