CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_schemes`()
BEGIN
	SELECT * FROM salaroo_uk_pension.pension_scheme;
END