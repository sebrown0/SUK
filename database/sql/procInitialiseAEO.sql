CREATE DEFINER=`root`@`localhost` PROCEDURE `initialise_aeo`(IN employer_tax_year VARCHAR(4))
BEGIN	
	DECLARE loan_start DATE;	
	/* 
    AEOs 
    deduction type
		D = % = 0 don't know why it's D and not P
        V = value = 1
        T = table = 2
	protected earnings type
		N = None = -1
        P = % = 0
        A = Value = 1        
        D = daily = 2
    */
    DELETE FROM aeo_type WHERE id !='';    
    INSERT INTO 
		`salaroo_uk`.`aeo_type` (
        `id`, `description`, `deduction_type`, `pe_type`, `is_unpaid_deduction_bf`,  `is_priority`) 
	VALUES 
		(1, 'Department Work Pensions', 'T', 'P', 1,  0),
        (2, 'Child Support', 'V', 'A', 1,  1),
        (3, 'Council Tax Attachment of Earnings Order', 'T', 'N', 0,  1),
        (4, 'Current Maintenance Agreement', 'D', 'D', 0,  1),
        (5, 'Magistrates Court Attachment of Earnings Order', 'T', 'N', 0,  1);
    
    DELETE FROM aeo_agency WHERE id !='';    
    INSERT INTO 
		`salaroo_uk`.`aeo_agency` (
		`id`, `aeo_type_id`, `agency_name`) 
	VALUES 
		(1, 1, 'Department Work Pensions'),
        (2, 2, 'CSA'),
        (3, 3, 'Bristol City Council'),
        (4, 3, 'Springfield City Council'),
        (5, 5, 'Springfield Crown Court');
       
    DELETE FROM employee_aeo WHERE id !='';            
    INSERT INTO 
		`salaroo_uk`.`employee_aeo` (
		`employee_id`, `aeo_type_id`, `aeo_agency_id`, 
        `date_added_to_payroll`, `priority`, `status`, `frequency`, 
        `start_date`, `original_amount`, `current_amount`, `amount_paid_in_previous_employment`, `cumulative_unpaid`, `order_date`, `apply_from`, 
        `stop_order`, `ref_number`, `court_case_number`, `description`, `deduct_admin_charge`, `deduction_amount`, `pe_amount`)
	VALUES 
		('LS1', 2, 2, '2020-01-01', 1, 1, 0, '2020-01-01', 1000, 1000, 0, 0, '2020-01-01', '2020-01-01', 0, 'REF-1234', 'CC NUM CSA-18291', 'Child support for LS', 1, 123, 2500),
        ('LS1', 3, 4, '2020-01-01', 2, 1, 0, '2020-01-01', 10000, 10000, 0, 0, '2020-01-01', '2020-01-01', 0, 'REF-412', 'CC NUM SCC-12191', 'Council Tax arrears for LS', 0, 3123, 0);	
        		
	/*Student Loan*/
    SET loan_start = date(concat(year(date_sub(concat(employer_tax_year,'-01-01'), INTERVAL 1 YEAR)),'-01-01'));
	DELETE FROM student_loan WHERE id !='';
	INSERT INTO  student_loan
		(employee_id, start_date, original_amount, loan_type, current_amount, reason_for_deduction, stop_notice_received)
	VALUES
		("LS1", '2020-01-01', 1000, 1, 1000, 'ER',0),
		("LS1", loan_start, 4000, 2, 4000, 'P45',0),
		("LS1", loan_start, 3000, 3, 3000, 'GR',0),
		("MS1", loan_start, 1230, 1, 1230, 'SR',0),
		("MS1", loan_start, 4320, 2, 4320, 'SC',0),
		("MS1", loan_start, 1983, 3, 1983, 'ER',0);
END