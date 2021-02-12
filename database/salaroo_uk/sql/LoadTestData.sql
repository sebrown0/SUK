-- Make sure that the CSV files are in SELECT @@global.secure_file_priv;

USE salaroo_uk;
SET foreign_key_checks = 0;

TRUNCATE test_data_salary;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_data_salary.csv'
INTO TABLE test_data_salary 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_aeo;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_data_aeo.csv'
INTO TABLE test_data_aeo 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_student_loan;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_data_student_loan.csv'
INTO TABLE test_data_student_loan 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_ytd;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_data_ytd.csv'
INTO TABLE test_data_ytd 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_group;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_group.csv'
INTO TABLE test_group 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_employee;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_data_employee.csv'
INTO TABLE test_data_employee 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_salary_sacrifice;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_data_salary_sacrifice.csv'
INTO TABLE test_data_salary_sacrifice 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE test_data_payroll_params;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_data_payroll_params.csv'
INTO TABLE test_data_payroll_params 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Turn the FK checks back on because the test data for a test (below) has to exist.
-- If test data for a category is not included in a test we load the dummy row with id = -1.
SET foreign_key_checks = 1;

-- Have to delete the data in test_result_expected because it has FK to test.
TRUNCATE test_result_expected;
-- --------------------------------------------------------------------------
DELETE FROM test WHERE test_num <> "";
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test.csv'
INTO TABLE test 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\test_result_expected.csv'
INTO TABLE test_result_expected 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

