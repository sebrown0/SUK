CREATE DEFINER=`root`@`localhost` PROCEDURE `update_employer`(
	IN hmrcOfficeNumber VARCHAR(45), 
    IN payeReference VARCHAR(45), 
    IN accountsOfficeReference VARCHAR(45), 
    IN contractedOutNumber VARCHAR(45), 
    IN selfAssesmentUtr VARCHAR(45), 
    IN cotaxReference VARCHAR(45), 
    IN salarySacrificeNiRetained DECIMAL(5,2), 
    IN postponementApproach  VARCHAR(100), 
    IN apportionmentRule ENUM('260', '365'), 
    IN dutiesStartDate DATE)
BEGIN
	DECLARE ppId INT;
    
    SELECT id INTO ppID 
    FROM salaroo_uk_pension.postponement_approach WHERE
    `description` = postponementApproach;
	
    UPDATE 
		employer 
	SET 
		hmrc_office_number = hmrcOfficeNumber, 
        paye_reference = payeReference, 
        accounts_office_reference = accountsOfficeReference, 
        contracted_out_number = contractedOutNumber, 
        self_assesment_utr = selfAssesmentUtr, 
        cotax_reference = cotaxReference, 
        salary_sacrifice_ni_retained = salarySacrificeNiRetained, 
        postponement_approach_id = ppID,
        apportionment_rule = apportionmentRule, 
        duties_start_date = dutiesStartDate;
END