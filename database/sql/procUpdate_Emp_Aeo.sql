CREATE DEFINER=`root`@`localhost` PROCEDURE `update_emp_aeo`(
		IN empAeoId INT, 
        IN employeeId VARCHAR(45), 
        IN aeoTypeId INT, 
        IN aeoAgencyId INT, 
        IN dateAddedToPayroll DATE, 
        IN priority INT, 
        IN aeoStatus TINYINT, 
        IN frequency TINYINT, 
        IN ytd DECIMAL(8,2), 
        IN startDate DATE, 
        IN originalAmount DECIMAL(8,2),
        IN currentAmount DECIMAL(8,2), 
        IN cumulativeUnpaid DECIMAL(8,2), 
        IN orderDate DATE, 
        IN applyFrom DATE, 
        IN stopOrder TINYINT, 
        IN refNumber VARCHAR(45), 
        IN courtCaseNumber VARCHAR(45),  
        IN aeoDescription VARCHAR(145),  
        IN deductAdminCharge TINYINT, 
        IN deductionAmount DECIMAL(8,2), 
        IN peAmount DECIMAL(8,2))
BEGIN
	INSERT INTO employee_aeo (
		`id`, `employee_id`, `aeo_type_id`, `aeo_agency_id`, `date_added_to_payroll`, `priority`, 
		`status`, `frequency`, `ytd`, `start_date`, `original_amount`, `current_amount`, `cumulative_unpaid`, `order_date`, `apply_from`, 
		`stop_order`, `ref_number`, `court_case_number`, `description`, `deduct_admin_charge`, `deduction_amount`, `pe_amount`)
	VALUES (
		empAeoId, employeeId, aeoTypeId, aeoAgencyId, dateAddedToPayroll, priority, 
        aeoStatus, frequency, ytd, 	startDate, originalAmount, currentAmount, cumulativeUnpaid, orderDate, applyFrom, 
        stopOrder, refNumber, courtCaseNumber, aeoDescription, deductAdminCharge, deductionAmount, peAmount)
	ON DUPLICATE KEY UPDATE
		`aeo_type_id` = aeoTypeId, 
        `aeo_agency_id` = aeoAgencyId, 
        `date_added_to_payroll` = dateAddedToPayroll, 
        `priority` = priority, 
		`status` = aeoStatus, 
        `frequency` = frequency, 
        `ytd` = ytd, 
        `start_date` = startDate, 
        `original_amount` = originalAmount, 
        `current_amount` = currentAmount, 
        `cumulative_unpaid` = cumulativeUnpaid, 
        `order_date` = orderDate, 
        `apply_from` = applyFrom, 
		`stop_order` = stopOrder, 
        `ref_number` = refNumber, 
        `court_case_number` = courtCaseNumber, 
        `description` = aeoDescription, 
        `deduct_admin_charge` = deductAdminCharge, 
        `deduction_amount` = deductionAmount, 
        `pe_amount` = peAmount;
END