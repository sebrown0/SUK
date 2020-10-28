/*Employer*/
DELETE FROM employer WHERE id !='';
INSERT INTO  employer
	(id, `name`, hmrc_office_number, paye_reference, accounts_office_reference) 
VALUES 
	("DAK1", "Dakar", "123", "PAYE123", "ACCOUNTSREF123");
    
/*Tax Year*/
DELETE FROM tax_year WHERE id !='';
INSERT INTO  tax_year
	(id, employer_id) 
VALUES 
	("2020", "DAK1");

/* Employee */
DELETE FROM employee WHERE id !='';
INSERT INTO employee 
	(id, first_name, last_name, gender, date_of_birth, initials, employer_id) 
VALUES 
	("MS1","Marge","Simpson","F","1985/05/12", "MS", "DAK1"),
    ("BS1","Bart","Simpson","M","1996/12/25", "BS", "DAK1"),
    ("LS1","Lisa","Simpson","F","1995/06/12", "LS", "DAK1"),
    ("TR1","The","Rock","M","1980/01/01", "TR", "DAK1"),
    ("CE1","Clint","Eastwood","M","1950/03/22", "CE", "DAK1"),
    ("BM1","Bat","Man","M","1980/06/15", "BM", "DAK1"),
    ("QE2","Queen Liz","The II","F","1920/09/27", "QE", "DAK1"),
    ("HS1","Homer","Simpson","M","1980/04/01", "HS", "DAK1"),
    ("MAS1","Maggie","Simpson","F","1998/05/06", "MAS", "DAK1"),
    ("SW1","Stevie","Wonder","M","1970/01/01", "SW", "DAK1");
    
/* Address */
DELETE FROM address WHERE id !='';
INSERT INTO address 
	(employee_id, number_or_name, street, district, city, post_code, country ) 
VALUES 
	("MS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
    ("BS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
    ("LS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
    ("TR1","12","Rocky Ave", "Ashton Vale","Bristol","BS3 7PQ", "England"),
    ("CE1","99","Make My Day St", "Horfield","Newcastle","HR12 3PA", "England"),
    ("BM1","Wayne Manor","1 Bat Cave Ave", "","Gotham","GT123", "England"),
    ("QE2","Buck House","Strand", "Westminster","London","SW1A 1AA", "England"),
    ("HS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
    ("MAS1","742","Evergreen Terrace", "","Springfied","OH123", "England"),
    ("SW1","4","Blues Rd", "Motown","Detroit","MT321", "England");

/*Employee HR*/
DELETE FROM employee_hr WHERE id !='';
INSERT INTO employee_hr 
	(employee_id, ni_number, start_date, martial_status, employee_hours_normally_worked, starting_declaration) 
VALUES 
	("MS1","NI123456B","2020/01/01","M", "D", "B"),
    ("BS1","NI123456C","2020/01/01","S", "B", "B"),
    ("LS1","NI123456D","2020/01/01","S", "D", "B"),
    ("TR1","NI123456F","2020/05/01","S", "D", "B"),
    ("CE1","NI123456G","2020/01/01","M", "D", "B"),
    ("BM1","NI123456I","2020/01/01","S", "D", "B"),
    ("QE2","NI123456J","2020/01/01","M", "A", "B"),
    ("HS1","NI123456A","2016/02/13","M", "D", "B"),
    ("MAS1","NI123456E","2020/01/01","S", "D", "B"),
    ("SW1","NI123456H","2020/01/01","M", "D", "B");
    
/*Employee Payroll Details*/
DELETE FROM employee_payroll_details WHERE id !='';
INSERT INTO employee_payroll_details 
	(employee_id, payroll_id, tax_rate, rate_of_pay, commision_percentage, gets_blind_allowance, nic, pay_frequency) 
VALUES 
	("MS1","NI123456B", 0, 4333.33, 0.00, 0, "A", "M1"),
    ("BS1","NI123456C", 0, 8.83, 0.00, 0, "A", "M1"),
    ("LS1","NI123456D", 0, 10000.00, 0.00, 0, "H", "M1"),
    ("TR1","NI123456F", 0, 1500.00, 0.00, 0, "A", "M1"),
    ("CE1","NI123456G", 0, 2400.00, 0.00, 0, "C", "M1"),
    ("BM1","NI123456I", 0, 13000.00, 0.00, 0, "A", "M1"),
    ("QE2","NI123456J", 0, 5000.00, 0.00, 0, "C", "M1"),
    ("HS1","NI123456A", 0, 2000, 0.00, 0, "A", "W1"),
    ("MAS1","NI123456E", 0, 4000, 0.00, 0, "Z", "W1"),
    ("SW1","NI123456H", 0, 3000.00, 0.00, 1, "A", "W1");

/*Employement Type*/
DELETE FROM employment_type WHERE id !='';
INSERT INTO  employment_type
	(employee_id, primary_employment, is_apprentice, is_casual_worker, employee_type) 
VALUES 
	("MS1", 1, 0, 0, "S"),
    ("BS1", 1, 1, 0, "V"),
    ("LS1", 0, 0, 0, "S"),
    ("TR1", 1, 0, 0, "S"),
    ("CE1", 1, 0, 0, "S"),
    ("BM1", 1, 0, 0, "S"),
    ("QE2", 1, 0, 0, "P"),
    ("HS1", 1, 0, 0, "S"),
    ("MAS1", 0, 0, 0, "S"),
    ("SW1", 1, 0, 0, "S");

/*Student Loan*/
DELETE FROM student_loan WHERE id !='';
INSERT INTO  student_loan
	(employee_id, start_date, amount, loan_type) 
VALUES 
	("LS1", "2020/01/01", 1000, 1),
    ("LS1", "2020/01/01", 4000, 2),
    ("LS1", "2020/01/01", 3000, 3);

