CREATE PROCEDURE `update_student_loan` (
	IN empId VARCHAR(20),
    IN startDate DATE,
    IN originalAmount DECIMAL(8,2),
    IN loanType TINYINT,
	IN currentAmount DECIMAL(8,2),
    IN reasonForDeduction VARCHAR(3),
    IN stopNoticeReceived TINYINT)
BEGIN
	INSERT INTO student_loan (
		employee_id, start_date, original_amount,loan_type,
		current_amount,reason_for_deduction,stop_notice_received)
	VALUES (
		empId, startDate, originalAmount, loanType, 
        currentAmount, reasonForDeduction, stopNoticeReceived)
	ON DUPLICATE KEY UPDATE
		start_date = startDate,
		original_amount = originalAmount,
		current_amount = currentAmount,
		reason_for_deduction = reasonForDeduction,
		stop_notice_received = stopNoticeReceived;
END