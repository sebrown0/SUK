/*Payroll Frequency*/
DELETE FROM payroll_frequency WHERE id !='';
INSERT INTO  payroll_frequency
	(id, tax_year_id, pay_frequency_id, last_payroll_run_number) 
VALUES 
	(1, "2020", "W1", 0),
    (2, "2020", "W2", 0),
    (3, "2020", "W4", 0),
    (4, "2020", "M1", 0),
    (5, "2020", "M3", 0),
    (6, "2020", "M6", 0),
    (7, "2020", "MA", 0),
    (8, "2020", "IO", 0),
    (9, "2020", "IR", 0);
    
/*Payroll Run*/
DELETE FROM payroll_run WHERE id !='';
INSERT INTO  payroll_run
	(payroll_number, tax_year_id, payroll_frequency_id) 
VALUES 
	(1, "2020", 1);
    
/*Employee Basic*/
/* 
	Units = number of hours etc (default is 1)
    Rate = rate of pay    
*/
DELETE FROM employee_basic WHERE id !='';
INSERT INTO  employee_basic
	(employee_payroll_details_payroll_id, rate) 
VALUES 
	("NI123456B", 4333.33);

DELETE FROM `salaroo_uk`.`payroll_result_payment` WHERE id !='';    
INSERT INTO `salaroo_uk`.`payroll_result_payment` 
	(`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_details_payroll_id`, `gross_pay`, `basic_pay`, `net_pay`, `bonus`) 
VALUES 
	(1, "2020", 1, "NI123456B", 1200, 1000, 800, 0);