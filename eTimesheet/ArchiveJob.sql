DELIMITER $$
CREATE 
EVENT ARCHIVE_DailyTask
ON SCHEDULE EVERY 1 MONTH STARTS '2018-03-07 00:00:00'
DO BEGIN
		
-- Inserting row with state 'ARCHIVE' into archive table
INSERT INTO  lazypeondb.archive_userdailytasks (userID, dailyTaskID, state, submissionMonth)
(SELECT userID, dailyTaskID, state, submissionMonth
FROM lazypeondb.userdailytasks
WHERE state = 'ARCHIVE');

-- Inserting old row into archive table --
INSERT INTO lazypeondb.archive_dailytask (DailyTaskID, Date, FromTime, ToTime, ProjectName, TaskType, Location, TaskDescription, TransportClaimAmount, PleaseSpecify, OtherClaimAmount)
(SELECT dt.dailyTaskID, dt.Date, dt.FromTime, dt.ToTime, dt.ProjectName, dt.TaskType, dt.Location, dt.TaskDescription, dt.TransportClaimAmount, dt.PleaseSpecify, dt.OtherClaimAmount 
FROM lazypeondb.userdailytasks udt 
JOIN lazypeondb.dailytask dt ON udt.dailyTaskID = dt.dailyTaskID 
WHERE udt.state='ARCHIVE');

-- Set safe update to false
SET SQL_SAFE_UPDATES = 0;

-- Deleting moved row
DELETE FROM lazypeondb.dailytask WHERE dailyTaskID IN 
(SELECT dailyTaskID FROM lazypeondb.userdailytasks WHERE state = 'ARCHIVE');
DELETE FROM lazypeondb.userdailytasks WHERE state = 'ARCHIVE';

-- Set safe update to true
SET SQL_SAFE_UPDATES = 1;

END$$
DELIMITER ;