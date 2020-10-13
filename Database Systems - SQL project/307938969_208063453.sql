--created by NAME:Meytal Meshulam,ID:307938969 & NAME:Yasmin Avraham,ID:208063453

--Q1
SELECT [First_Name],[Last_Name]
FROM [Personal]  JOIN [Shifts] 
ON [Personal].[ID] = [Shifts].[Employee_id]
WHERE [Date] = '01/01/2010'

--Q2
SELECT [First_Name],[Last_Name], [ID]
FROM [Personal]  JOIN [Shifts] 
ON [Personal].[ID] = [Shifts].[Employee_id]
WHERE [Date] = '01/01/2010' AND [Start_time]= '13:00'

--Q3 
select [First_Name], [Last_Name], [Lab_Name]
from Patients, Labs, Patients_Labs
where Patients.Patient_ID = Patients_Labs.Patient_id AND Labs.Lab_ID = Patients_Labs.Lab_ID AND Patients_Labs.Lab_date = '01/01/2010';

--Q4
Select [Specialty] 
from Personal_Specialization
WHERE ID IN (Select ID from Personal 
             where (First_Name='Dana' AND Last_Name='Biton'));

--Q5
select [Personal].[ID], [First_Name], [Last_Name]
from Personal
where Personal.ID in (select ID
	                  from Personal_Specialization
	                   group by ID
                    	having COUNT(*) >= All (select COUNT (Specialty)
		                                        from Personal_Specialization
		                                        group by Personal_Specialization.ID) )  

--Q6
Select [Patients]. [Patient_ID], [First_Name],[Last_Name]
From Patients join (
	Select  Patient_id from  Patients_Labs
	Except
	Select Patient_ID from Patients_Treatments) AS  NotTreatQ
On Patients. Patient_ID =  NotTreatQ. Patient_ID;


--Q7
SELECT [Personal].[ID],[First_Name],[Last_Name]
	FROM [Patients_Treatments] JOIN [Personal]
	ON [Patients_Treatments].[Personal_id]=[Personal].[ID]
	GROUP BY [Personal].[ID],[First_Name],[Last_Name]
	HAVING COUNT( DISTINCT [Patient_ID]) >= ALL (SELECT COUNT (DISTINCT [Patient_ID]) FROM [Patients_Treatments] GROUP BY [Personal_id])


--Q8
Select [Patients]. [Patient_ID], [First_Name],[Last_Name]
From Patients join (
	Select  Patient_id from  Patients_Labs
	Except
	Select Patient_ID from Patients_Treatments) AS  NotTreatQ
On Patients. Patient_ID =  NotTreatQ. Patient_ID;


--Q9
SELECT [RES].[Patient_ID], [RES].[First_Name], [RES].[Last_Name]
FROM (SELECT COUNT (DISTINCT [Treatment_code]) 
      AS 'Num_Of_Treatments', Patients.Patient_ID, Patients.First_Name, Patients.Last_Name
      FROM Patients_Treatments JOIN Patients
      ON Patients.Patient_ID=Patients_Treatments.Patient_ID
      GROUP BY Patients.Patient_ID, Patients.First_Name, Patients.Last_Name) AS RES
WHERE ([Num_Of_Treatments]>3)


--Q10
Select [Patients]. [Patient_ID], [First_Name],[Last_Name]
From Patients join (
	Select  Patient_ID from Patients
	Except
	Select Patient_ID from Patients_Treatments) AS NotProgress
On Patients. Patient_ID =  NotProgress. Patient_ID;


--Q11 
SELECT [Patients].[Patient_ID], [Patients].[First_Name] ,[Patients].[Last_Name], [Patients].[Patient_ID]
FROM Patients , Patients_Treatments
WHERE Patients.Patient_ID = Patients_Treatments.Patient_ID AND Patients.Patient_ID != '999999999'
	  AND  Patients_Treatments.Treatment_code IN (SELECT Patients_Treatments.Treatment_code
												  FROM Patients_Treatments
												  WHERE Patients_Treatments.Patient_ID ='999999999')
GROUP BY Patients.First_Name , Patients.Last_Name, Patients.Patient_ID
HAVING COUNT(*) >= ALL ( SELECT COUNT(Patients_Treatments.Treatment_code)
						 FROM Patients_Treatments
					     WHERE Patients_Treatments.Patient_ID ='999999999')


--Q12
SELECT DISTINCT[Patients].[Patient_id], [First_Name], [Last_Name]
FROM Patients JOIN Patients_Treatments
ON Patients.Patient_ID = Patients_Treatments.Patient_ID
WHERE [Patients].[Patient_ID] IN (SELECT RES.Patient_ID FROM (SELECT [Patient_ID], [Treatment_code] FROM Patients_Treatments
                                                              EXCEPT (SELECT [Patient_ID], [Treatment_code] FROM Patients_Progress)) AS RES)


--Q13
SELECT [Patients].[Patient_ID], [Patients].[First_Name], [Patients].[Last_Name]
FROM [Patients_Progress] JOIN [Patients]
ON [Patients].[Patient_ID] = [Patients_Progress].[Patient_ID]
GROUP BY [Patients].[Patient_ID], [Patients].[First_Name], [Patients].[Last_Name]
HAVING COUNT(*) >= ALL (SELECT COUNT([Patient_ID]) 
				        FROM [Patients_Progress]
				        GROUP BY [Patient_ID] )

--Q14
INSERT INTO [Patients_Treatments] 
VALUES ('999999999', 444 , '111111111', '01/05/2010', '10/05/2010')

--Q15
INSERT INTO [Patients_Progress]
VALUES('777777777', 333 ,'222222222','hey','hello','15/07/2011')

--Q16
DELETE FROM [Patients_Treatments]
WHERE (Patient_ID='777777777')

--Q17
UPDATE [Personal]
SET [Degree] = 'Phd'
WHERE ([ID]='222222222')
