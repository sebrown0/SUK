CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enrolment_type_data_for_type`(
	IN taxYear VARCHAR(4),
    IN enrolmentType VARCHAR(20))
BEGIN
	CALL create_all_enrolment_type_data();
    SELECT * FROM temp_all_enrolment_type_data
    WHERE tax_year = taxYear and type_id = enrolmentType;
END