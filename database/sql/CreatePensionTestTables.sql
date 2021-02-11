USE salaroo_uk;
-- Tables an data
DROP TABLE IF EXISTS salaroo_uk_pension_test.enrolment_criterion;
CREATE TABLE salaroo_uk_pension_test.enrolment_criterion AS SELECT * FROM enrolment_criterion;

DROP TABLE IF EXISTS salaroo_uk_pension_test.state_pension_age_67_to_68;
CREATE TABLE salaroo_uk_pension_test.state_pension_age_67_to_68 AS SELECT * FROM state_pension_age_67_to_68;

DROP TABLE IF EXISTS salaroo_uk_pension_test.enrolment_criteria;
CREATE TABLE salaroo_uk_pension_test.enrolment_criteria AS SELECT * FROM enrolment_criteria;

DROP TABLE IF EXISTS salaroo_uk_pension_test.enrolment_type;
CREATE TABLE salaroo_uk_pension_test.enrolment_type AS SELECT * FROM enrolment_type;

DROP TABLE IF EXISTS salaroo_uk_pension_test.eligibility;
CREATE TABLE salaroo_uk_pension_test.eligibility AS SELECT * FROM eligibility;

DROP TABLE IF EXISTS salaroo_uk_pension_test.assessment_reason;
CREATE TABLE salaroo_uk_pension_test.assessment_reason AS SELECT * FROM assessment_reason;

DROP TABLE IF EXISTS salaroo_uk_pension_test.notice_type;
CREATE TABLE salaroo_uk_pension_test.notice_type AS SELECT * FROM notice_type;

DROP TABLE IF EXISTS salaroo_uk_pension_test.postponement_approach;
CREATE TABLE salaroo_uk_pension_test.postponement_approach AS SELECT * FROM postponement_approach;

-- Tables only
DROP TABLE IF EXISTS salaroo_uk_pension_test.pension_scheme;
CREATE TABLE salaroo_uk_pension_test.pension_scheme AS SELECT * FROM pension_scheme WHERE 1=0;

DROP TABLE IF EXISTS salaroo_uk_pension_test.employee_pension;
CREATE TABLE salaroo_uk_pension_test.employee_pension AS SELECT * FROM employee_pension WHERE 1=0;

DROP TABLE IF EXISTS salaroo_uk_pension_test.employee_enroled;
CREATE TABLE salaroo_uk_pension_test.employee_enroled AS SELECT * FROM employee_enroled WHERE 1=0;

DROP TABLE IF EXISTS salaroo_uk_pension_test.employee_eligibility;
CREATE TABLE salaroo_uk_pension_test.employee_eligibility AS SELECT * FROM employee_eligibility WHERE 1=0; 

DROP TABLE IF EXISTS salaroo_uk_pension_test.assessment_result;
CREATE TABLE salaroo_uk_pension_test.assessment_result AS SELECT * FROM assessment_result WHERE 1=0;

DROP TABLE IF EXISTS salaroo_uk_pension_test.notices_due;
CREATE TABLE salaroo_uk_pension_test.notices_due AS SELECT * FROM notices_due WHERE 1=0;

DROP TABLE IF EXISTS salaroo_uk_pension_test.employee_postponement;
CREATE TABLE salaroo_uk_pension_test.employee_postponement AS SELECT * FROM employee_postponement WHERE 1=0;

DROP TABLE IF EXISTS salaroo_uk_pension_test.contribution;
CREATE TABLE salaroo_uk_pension_test.contribution AS SELECT * FROM contribution WHERE 1=0;

/*
DROP TABLE IF EXISTS salaroo_uk_pension_test.;
CREATE TABLE salaroo_uk_pension_test. AS
SELECT * FROM 
*/
