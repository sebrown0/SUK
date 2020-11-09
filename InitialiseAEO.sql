USE salaroo_uk;
SET foreign_key_checks = 0;
  
/* AEO Type */
DELETE FROM aeo_type WHERE id !='';
INSERT INTO 
	`aeo_type` (`id`,`type_name`, `deduction_type`, `pe_type`, `unpaid_bf`, `priority_order`, `description`) 
VALUES 
	(1, "DEA", "T", "P", true, false, "Department of Work and Pensions"),
    (2, "DEO", "V", "A", true, true, "Child support"),
    (3, "CTAEO", "T", "N", false, true, "Council tax"),
    (4, "CMA", "D", "D", false, true, "Current maintenance agreement"),
    (5, "AEO", "T", "N", false, true, "Magistrates court AEO");
    
    
    -- drop table aeo_type;
    