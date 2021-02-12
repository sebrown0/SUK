CREATE DEFINER = CURRENT_USER TRIGGER `salaroo_uk_pension`.`pay_reference_period_qual_earnings_BEFORE_INSERT` BEFORE INSERT ON `pay_reference_period_qual_earnings` FOR EACH ROW
BEGIN
	DECLARE prpId INT(11);
    SET prpId =  get_prp_id_for_freq_and_date(NEW.prp_pay_frequency, NEW.record_date);
    SET NEW.pay_reference_period_id = prpId;
END
