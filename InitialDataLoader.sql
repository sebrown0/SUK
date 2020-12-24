/* Make sure that the CSV files are in SELECT @@global.secure_file_priv;.

TEMPLATE
DELETE FROM XXXX WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\XXXX.csv'
INTO TABLE employee_aeo 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
TEMPLATE */

USE salaroo_uk;
SET foreign_key_checks = 0;

DELETE FROM tax_year WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\tax_year.csv'
INTO TABLE tax_year 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM student_loan WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\student_loan.csv'
INTO TABLE student_loan 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM leave_type WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\leave_type.csv'
INTO TABLE leave_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM leave_booking WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\leave_booking.csv'
INTO TABLE leave_booking 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM employment_type WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\employment_type.csv'
INTO TABLE employment_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM employer WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\employer.csv'
INTO TABLE employer 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM employee_payroll_details WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\employee_payroll_details.csv'
INTO TABLE employee_payroll_details 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM aeo_type WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\aeo_type.csv'
INTO TABLE aeo_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM aeo_agency WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\aeo_agency.csv'
INTO TABLE aeo_agency 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM address WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\emp_address.csv'
INTO TABLE address 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM employee WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\emp.csv'
INTO TABLE employee 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM employee_aeo WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\AEO_Test_Data.csv'
INTO TABLE employee_aeo 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DELETE FROM payroll_frequency WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\payroll_frequency.csv'
INTO TABLE payroll_frequency 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET foreign_key_checks = 1;