CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aeo_details`(IN empId VARCHAR(45))
BEGIN
	SELECT     
		emp_aeo.id as emp_aeo_id, emp_aeo.employee_id, emp_aeo.aeo_type_id, 
        emp_aeo.aeo_agency_id, emp_aeo.date_added_to_payroll, emp_aeo.priority, 
        emp_aeo.status, emp_aeo.frequency, emp_aeo.ytd, emp_aeo.start_date, emp_aeo.original_amount,
        emp_aeo.current_amount, emp_aeo.cumulative_unpaid, emp_aeo.order_date, 
        emp_aeo.apply_from, emp_aeo.stop_order, emp_aeo.ref_number, emp_aeo.court_case_number, 
        emp_aeo.description, emp_aeo.deduct_admin_charge, emp_aeo.deduction_amount, emp_aeo.pe_amount, 
        agency.id as agency_id, agency.aeo_type_id, agency.agency_name, 
        tpe.id AS type_id, tpe.description AS type_description, tpe.pe_type, tpe.is_unpaid_deduction_bf, tpe.deduction_type, tpe.is_priority
	FROM 
		salaroo_uk.employee_aeo emp_aeo
		INNER JOIN aeo_agency agency ON emp_aeo.aeo_agency_id = agency.id
			INNER JOIN aeo_type tpe ON emp_aeo.aeo_type_id = tpe.id
	WHERE
		employee_id = empId
	ORDER BY emp_aeo.employee_id, emp_aeo.priority;
END