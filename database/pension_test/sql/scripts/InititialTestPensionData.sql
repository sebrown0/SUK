USE salaroo_uk_pension_test;

SET foreign_key_checks = 0;

TRUNCATE test_data;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\salaroo_uk\\data\\test_data\\pension\\tests.csv'
INTO TABLE test_data 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 2 ROWS;

SET foreign_key_checks = 1;