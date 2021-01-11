CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aeo_priority_ordered`(IN empId VARCHAR(45))
BEGIN
	SELECT 
		aeo.id, aeo.employee_id, aeo.priority, aeo.order_date, aeo.date_added_to_payroll,
        tpe.is_priority
	FROM 
		employee_aeo aeo
		INNER JOIN aeo_type tpe
		ON aeo.aeo_type_id = tpe.id
	WHERE 
		aeo.employee_id = empId 
	ORDER BY 
		tpe.is_priority DESC, aeo.priority ASC, aeo.order_date ASC;
END