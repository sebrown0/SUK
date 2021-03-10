CREATE DEFINER=`root`@`localhost` PROCEDURE `ut_update_employer_ppa`(IN ppaID INT)
BEGIN
	CALL ut_start();    
	UPDATE salaroo_uk.employer 
    SET postponement_approach_id = ppaID 
    WHERE id = 'DAK1';
END