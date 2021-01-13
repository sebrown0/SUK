-- Load
-- payroll id, basic_units, commision, bonus, ot_hours
-- Into salary_data table.
-- This data will then be used in payroll.
-- The last added row for an emp is copied into the relevant payroll_xxxx table.

-- The cumulative amounts are calculated in salary_data_BEFORE_INSERT
-- If an employee is not variable hours and hours or Overtime is specified, 
-- it will be set to zero.
CALL load_salary_data('NI123456A', 1,0,100,0); 
CALL load_salary_data('NI123456B', 1,0,0,0); 
CALL load_salary_data('NI123456C', 40,0,0,10); -- Bart is the only variable hours emp
CALL load_salary_data('NI123456D', 1,10,0,0); 
CALL load_salary_data('NI123456E', 1,0,500,0); 
CALL load_salary_data('NI123456F', 1,0,0,0); 
CALL load_salary_data('NI123456G', 1,90,0,0); 
CALL load_salary_data('NI123456H', 1,0,0,0); 
CALL load_salary_data('NI123456I', 1,0,0,0); 
CALL load_salary_data('NI123456J', 1,0,20,10); 


