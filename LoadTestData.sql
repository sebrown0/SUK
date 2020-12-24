-- Make sure that the CSV files are in SELECT @@global.secure_file_priv;

USE salaroo_uk;
SET foreign_key_checks = 0;

TRUNCATE test_data_salary;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\test_data\\test_data_salary.csv'
INTO TABLE test_data_salary 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_aeo;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\test_data\\test_data_aeo.csv'
INTO TABLE test_data_aeo 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_student_loan;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\test_data\\test_data_student_loan.csv'
INTO TABLE test_data_student_loan 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\test_data\\test.csv'
INTO TABLE test 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SET foreign_key_checks = 0;