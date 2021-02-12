CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enrolment_type_data_for_tax_year`(IN taxYear VARCHAR(4))
BEGIN
	CALL create_all_enrolment_type_data();
    SELECT * FROM temp_all_enrolment_type_data
    WHERE tax_year = taxYear;
END