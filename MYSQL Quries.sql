--QURIES IN SQL --

-- CREATE DATABASE WITH NAME hospital- :-)
CREATE DATABASE hospital;

-- USE THE DATABASE Hospital

USE hospital ;

--CREATE TABLE WITH NAME patients--


CREATE TABLE patients (
Patient_ID VARCHAR(50),
Patient_Admission_Date DATE ,
Patient_Admission_TIME TIME,
Patient_First_Inital VARCHAR (5),
Patient_Last_Name VARCHAR(25),
Patient_Gender VARCHAR(10),
Patient_Age INT,
Patient_Race VARCHAR(15),
Department_Referral VARCHAR(50),
Patient_Admission_Flag TINYINT,
Patient_Satisfaction_Score INT NULL,
Patient_Waittime INT
);

-- TRY TO LOAD DATA IN DATABASE--
LOAD DATA INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\Hospital Emergency Room Data.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Error Code: 1290. The MySQL server is running with the --secure-file-priv option so it cannot execute this statement	0.016 sec
SHOW VARIABLES LIKE 'secure_file_priv';

-- AGAIN TRY TO LOAD DATA IN DATABASE WITH SOME CHANGES--
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Hospital Emergency Room Data.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
IGNORE 1 ROWS; 

-- Error Code: 1366. Incorrect integer value: 'FALSE' for column 'Patient_Admission_Flag' at row 1	0.000 sec
ALTER TABLE patients
MODIFY Patient_Admission_Flag VARCHAR(10);

-- 	Error Code: 1406. Data too long for column 'Patient_Race' at row 2	0.031 sec
ALTER TABLE patients
MODIFY Patient_Race VARCHAR(50);

-- Error Code: 1366. Incorrect integer value: '' for column 'Patient_Satisfaction_Score' at row 2	0.015 sec
ALTER TABLE patients 
MODIFY Patient_Satisfaction_Score VARCHAR(10) NULL;

-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec
SET SQL_SAFE_UPDATES = 0;

-- Error Code: 1366. Incorrect integer value: '' for column 'Patient_Satisfaction_Score' at row 2	0.015 sec
ALTER TABLE patients 
MODIFY Patient_Satisfaction_Score VARCHAR(10) NULL;

-- TRY AGAIN TO UPLOAD AND SUCESSFULLY UPLOAD MY DATA

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Hospital Emergency Room Data.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
IGNORE 1 ROWS; 


Select * FROM patients;

-- SOME UPADTE IN MY DATA WHICH MAKE DATA EASY TO UNDERSTAND

UPDATE patients
SET Patient_Gender = 'Male'
WHERE Patient_Gender ='M';

-- SOME UPADTE IN MY DATA WHICH MAKE DATA EASY TO UNDERSTAND

UPDATE patients
SET Patient_Gender = 'Female'
WHERE Patient_Gender ='F';

Select * FROM patients;

-- Basic Understanding (Foundation)

-- What is the total number of patients in the dataset?
SELECT COUNT(DISTINCT(Patient_ID)) AS Total_Patient
FROM patients;
-- 9216

-- How many patients were admitted vs not admitted?

SELECT 
CASE 
WHEN Patient_Admission_Flag ='TRUE' THEN 'Admitted'
WHEN Patient_Admission_Flag ='False' THEN 'Not Admitted'
ELSE 'Unknown'
END AS Addmission_Status, COUNT(*) AS patient_count
FROM patients
GROUP BY Addmission_Status;

-- What is the average patient wait time?
SELECT Round(AVG(Patient_Waittime),0) AS Avg_WaitTime 
FROM patients;
-- 35 

-- What is the average patient satisfaction score?

SELECT Round(AVG(Patient_Satisfaction_Score),0) AS Avg_Satisfaction
FROM patients;

-- What is the gender distribution of patients?
SELECT Patient_Gender, count(*) AS Total 
FROM patients
GROUP BY Patient_Gender;

-- Male	4729   Female	4487

-- Data Analysis Questions :-)

-- Which department receives the highest number of patients?
SELECT Department_Referral, COUNT(*) AS TOTAL
FROM patients
GROUP BY Department_Referral 
ORDER BY TOTAL DESC;
-- 'None', '5400'


-- Which department has the longest average wait time?
SELECT Department_Referral, avg(Patient_Waittime) AS avg_wait_time
FROM patients
GROUP BY Department_Referral
ORDER BY avg_wait_time DESC
LIMIT 1;

-- Neurology	36.8031

-- What is the average wait time by gender?
SELECT Patient_Gender , AVG(Patient_Waittime) AS A_W_G
FROM patients
GROUP BY Patient_Gender;

-- Which age group visits the Orthopedics most frequently?
SELECT  
CASE 
WHEN Patient_Age BETWEEN 0 AND 18 THEN '0-18'
WHEN Patient_Age BETWEEN 19 AND 35 THEN '19-35'
WHEN Patient_Age BETWEEN 36 AND 60 THEN '36-60'
ELSE '60+' END AS Age_Group, Count(*) AS total_visit
FROM patients
WHERE Department_Referral ='Orthopedics'
GROUP BY Age_group
ORDER BY total_visit DESC;



