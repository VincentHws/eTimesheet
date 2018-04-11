SELECT * FROM lazypeondb.existinggroup;
SELECT * FROM lazypeondb.usergroups;
SELECT * FROM lazypeondb.dailytask;
SELECT * FROM lazypeondb.userdailytasks;
SELECT * FROM lazypeondb.user;
SELECT * FROM lazypeondb.tasktype;
SELECT * FROM lazypeondb.customer;
SELECT * FROM lazypeondb.project;

SELECT * FROM lazypeondb.archive_dailytask;
SELECT * FROM lazypeondb.archive_userdailytasks;

SELECT eg.groupName FROM existinggroup eg JOIN usergroups ug ON existinggroupeg.groupID = ug.groupID WHERE ug.userID = 1;

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

-- Deleting moved row
DELETE FROM lazypeondb.dailytask WHERE dailyTaskID IN 
(SELECT dailyTaskID FROM lazypeondb.userdailytasks WHERE state = 'ARCHIVE');
DELETE FROM lazypeondb.userdailytasks WHERE state = 'ARCHIVE';

DELETE FROM lazypeondb.archive_userdailytasks;
DELETE FROM lazypeondb.archive_dailytask;

show create event ARCHIVE_DailyTask

-- Altering event run time to today date & time --
DELIMITER $$
ALTER EVENT ARCHIVE_DailyTask
ON SCHEDULE EVERY 1 MONTH STARTS '2018-03-01 15:10:00'
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

-- To see which events have ran --
SELECT * FROM INFORMATION_SCHEMA.events;

SELECT monthname(current_date());

SELECT DATE, FROMTIME, TOTIME, PROJECTNAME, TASKTYPE, LOCATION, TASKDESCRIPTION, TRANSPORTCLAIMAMOUNT, PLEASESPECIFY, OTHERCLAIMAMOUNT, STATE, SUBMISSIONMONTH 
FROM dailytask dt
JOIN userdailytasks udt ON dt.dailyTaskID = udt.dailyTaskID
WHERE udt.state = 'SUBMITTED' AND udt.userID = 1;

-- Insert into customer table
INSERT INTO lazypeondb.customer (customername, customerdescription) VALUES ('Deutsche Bank', 'BANK D');

-- Select relevant projects based on group
SELECT p.projectName FROM project p WHERE p.assignedGroup IN (SELECT groupID FROM usergroups WHERE userID = 3);