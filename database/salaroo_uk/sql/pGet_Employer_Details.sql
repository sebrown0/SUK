CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employer_details`()
BEGIN
	SELECT 
		er.id, er.name, er.hmrc_office_number, er.paye_reference, er.accounts_office_reference, 
        er.contracted_out_number, er.self_assesment_utr, er.cotax_reference, er.salary_sacrifice_ni_retained,
        er.apportionment_rule, er.duties_start_date, 
        er.postponement_approach_id, pa.description
    FROM 
		employer er
		JOIN salaroo_uk_pension.postponement_approach pa
        ON er.postponement_approach_id = pa.id;
END