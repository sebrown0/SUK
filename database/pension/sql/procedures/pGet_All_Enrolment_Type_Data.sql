CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_enrolment_type_data`()
BEGIN
	CALL create_all_enrolment_type_data();
    SELECT * FROM temp_all_enrolment_type_data;
END