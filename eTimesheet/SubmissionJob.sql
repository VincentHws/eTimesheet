DELIMITER $$
CREATE 
EVENT Submission_DailyTask
ON SCHEDULE EVERY 1 MONTH STARTS '2018-03-07 00:00:00'
DO BEGIN

SET SQL_SAFE_UPDATES = 0;

UPDATE lazypeondb.userdailytasks 
SET state = 'SUBMITTED' 
WHERE state = 'DRAFT' AND submissionMonth = (SELECT monthname(current_date()));

SET SQL_SAFE_UPDATES = 1;

END$$
DELIMITER ;