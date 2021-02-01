SELECT * FROM salaroo_uk.postponement_approach ORDER BY id;
SELECT * FROM salaroo_uk.notice_type;
SELECT * FROM salaroo_uk.assessment_reason;

SELECT * FROM salaroo_uk.enrolment_type;
SELECT * FROM salaroo_uk.enrolment_criteria;
SELECT * FROM salaroo_uk.enrolment_criterion;

CALL get_all_postponement_types();
CALL get_all_enrolment_type_data();

