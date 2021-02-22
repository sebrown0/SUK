CREATE DEFINER=`root`@`localhost` PROCEDURE `get_minimum_contribution`(IN taxYear VARCHAR(4))
BEGIN
	SELECT * FROM minimum_contribution
    WHERE tax_year = taxYear;
END