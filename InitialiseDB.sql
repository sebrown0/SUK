USE salaroo_uk;
SET foreign_key_checks = 0;

-- Set variables
SET @tax_yr = '2021';
SET @employer_id = 'DAK1';

-- Initialise the basic tables
CALL initialise_employer(@employer_id, "Dakar", "123", "PAYE123", "ACCOUNTSREF123", @tax_yr);
CALL initialise_employee(@employer_id);
CALL initialise_aeo(@tax_yr);
CALL initialise_payroll(@tax_yr);
CALL initialise_leave(@tax_yr);

-- Insert payroll run for each employee
CALL insert_payroll_data('NI123456B', 1, "M1", @tax_yr);
CALL insert_payroll_data('NI123456D', 1, "M1", @tax_yr);

SET foreign_key_checks = 1;

