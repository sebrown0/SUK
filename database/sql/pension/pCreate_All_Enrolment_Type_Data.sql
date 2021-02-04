CREATE DEFINER=`root`@`localhost` PROCEDURE `create_all_enrolment_type_data`()
BEGIN
	DROP TABLE IF EXISTS temp_all_enrolment_type_data;
    CREATE TEMPORARY TABLE temp_all_enrolment_type_data
	SELECT 
		e_type.id AS type_id, e_type.enrolment_criteria_tax_year AS tax_year, e_type.enrolment_description, 
		criteria.is_no_criteria, criteria.is_worker_automatically_enroled, criteria.is_there_opt_out_period,
		criterion.criterion_id, criterion.age_min, criterion.age_max, criterion.earn_min, criterion.earn_max, criterion.is_under_spa, criterion.is_spa 
	FROM 
		enrolment_type e_type
		JOIN enrolment_criteria criteria
		ON e_type.enrolment_criteria_id = criteria.id
			LEFT JOIN enrolment_criterion criterion
			ON criteria.id = criterion.enrolment_criteria_id;
END