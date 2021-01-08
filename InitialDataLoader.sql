/* Make sure that the CSV files are in SELECT @@global.secure_file_priv;.

TEMPLATE
DELETE FROM XXXX WHERE id <> '';
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\XXXX.csv'
INTO TABLE employee_aeo 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
TEMPLATE */

USE salaroo_uk;
SET foreign_key_checks = 0;

TRUNCATE tax_year;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\tax_year.csv'
INTO TABLE tax_year 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE student_loan;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\student_loan.csv'
INTO TABLE student_loan 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE leave_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\leave_type.csv'
INTO TABLE leave_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE leave_booking;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\leave_booking.csv'
INTO TABLE leave_booking 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employment_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\employment_type.csv'
INTO TABLE employment_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employer;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\employer.csv'
INTO TABLE employer 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee_payroll_details;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\employee_payroll_details.csv'
INTO TABLE employee_payroll_details 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE aeo_type;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\aeo_type.csv'
INTO TABLE aeo_type 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE aeo_agency;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\aeo_agency.csv'
INTO TABLE aeo_agency 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE address;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\emp_address.csv'
INTO TABLE address 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\emp.csv'
INTO TABLE employee 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE employee_aeo;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\emp_aeo_data.csv'
INTO TABLE employee_aeo 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE payroll_frequency;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\initial_data\\payroll_frequency.csv'
INTO TABLE payroll_frequency 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET foreign_key_checks = 1;