CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aeo_type_data_for_agency_name`(
	IN agencyName VARCHAR(145))
BEGIN
	SELECT
		agency.agency_name, 
        tpe.description, tpe.pe_type, tpe.is_unpaid_bf, tpe.deduction_type, tpe.is_priority
	FROM 
		aeo_agency agency
		INNER JOIN aeo_type tpe
		ON agency.aeo_type_id = tpe.id
	WHERE agency.agency_name = agencyName;
END