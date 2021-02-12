CREATE DEFINER=`root`@`localhost` PROCEDURE `load_payroll_included_emps`(
	IN payrollRunId INT,
    IN freqId INT)
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE empPayrollId VARCHAR(45); 
    DECLARE empId VARCHAR(45); 
    
    DECLARE curIncludedEmps
    CURSOR FOR
		SELECT payroll_id, employee_id FROM employee_payroll_details 
        WHERE pay_frequency = freqId; 
    
	DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET finished = 1;
    
    -- Get employees with the pay frequency
    -- and load them into payroll_data.
    -- NOTE: WE ARE ASSUMING THAT ALL EMPS ARE INCLUDED.
    -- THERE ARE NO FLAGS FOR SUSPENDED, TERMINATED ETC.
    OPEN curIncludedEmps;
    included_emps: LOOP
		FETCH curIncludedEmps INTO empPayrollId, empId;
        IF finished = 1 THEN LEAVE included_emps; END IF;   
            
		INSERT INTO `payroll_data` (`payroll_run_id`, `employee_payroll_id`, `employee_id`) 
		VALUES (payrollRunId, empPayrollId, empId);
    END LOOP;
END