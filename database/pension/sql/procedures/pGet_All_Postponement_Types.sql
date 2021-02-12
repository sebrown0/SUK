CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_postponement_types`()
BEGIN
	SELECT * FROM postponement_approach ORDER BY id;
END