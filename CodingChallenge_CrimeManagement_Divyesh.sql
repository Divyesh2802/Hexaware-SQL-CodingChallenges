CREATE DATABASE CrimeManagement;
USE CrimeManagement;
-- Create tables
CREATE TABLE Crime (
	CrimeID INT PRIMARY KEY,
	IncidentType VARCHAR(255),
	IncidentDate DATE,
	Location VARCHAR(255),
	Description TEXT,
	Status VARCHAR(20)
);
CREATE TABLE Victim (
	VictimID INT PRIMARY KEY,
	CrimeID INT,
	Name VARCHAR(255),
	ContactInfo VARCHAR(255),
	Injuries VARCHAR(255),
	FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
CREATE TABLE Suspect (
	SuspectID INT PRIMARY KEY,
	CrimeID INT,
	Name VARCHAR(255),
	Description TEXT,
	CriminalHistory TEXT,
	FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
-- Insert sample data
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status) VALUES
	(1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
	(2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
	(3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries) VALUES
	(1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
	(2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
	(3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory) VALUES
	(1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
	(2, 2, 'Unknown', 'Investigation ongoing', NULL),
	(3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');
-- Question 1
SELECT * FROM [dbo].[Crime] WHERE [Status] = 'Open';
-- Question 2
SELECT COUNT(*) 'TotalNoOfIncidents' FROM [dbo].[Crime];
-- Question 3
SELECT DISTINCT [IncidentType] FROM [dbo].[Crime];
-- Question 4
SELECT * FROM [dbo].[Crime] WHERE [IncidentDate] BETWEEN '2023-09-01' AND '2023-09-10';
-- Question 5
ALTER TABLE [dbo].[Suspect]
ADD Age INT;
UPDATE [dbo].[Suspect] SET [Age] = 25 WHERE [SuspectID] = 1;
UPDATE [dbo].[Suspect] SET [Age] = 30 WHERE [SuspectID] = 2;
UPDATE [dbo].[Suspect] SET [Age] = 18 WHERE [SuspectID] = 3;
SELECT * FROM [dbo].[Suspect] ORDER BY [Age] DESC;
-- Question 6
SELECT AVG([Age]) 'AverageAge' FROM [dbo].[Suspect];
-- Question 7
SELECT [IncidentType],COUNT([IncidentType]) 'Count' FROM [dbo].[Crime]
WHERE [Status] = 'Open'
GROUP BY [IncidentType];
-- Question 8
SELECT * FROM [dbo].[Victim] WHERE
Name LIKE '%Doe%';
-- Question 9
SELECT S.[Name],C.[Status] FROM [dbo].[Suspect] AS S
JOIN [dbo].[Crime] AS C
ON S.[CrimeID] = C.[CrimeID]
WHERE C.[Status] = 'Open' OR C.[Status] = 'Closed';
-- Question 10
SELECT C.[IncidentType] FROM [dbo].[Crime] AS C
JOIN [dbo].[Suspect] AS S
ON C.[CrimeID] = S.[CrimeID]
WHERE S.[Age] = 30 OR S.[Age] = 35;
-- Question 11
SELECT S.*,C.[IncidentType] FROM [dbo].[Suspect] AS S
JOIN [dbo].[Crime] AS C
ON S.[CrimeID] = C.[CrimeID]
WHERE C.[IncidentType] = 'Robbery';
-- Question 12
SELECT [IncidentType] FROM [dbo].[Crime]
WHERE [Status] = 'Open'
GROUP BY [IncidentType]
HAVING COUNT([Status]) > 1;
-- Question 13
SELECT C.* FROM [dbo].[Crime] AS C
JOIN [dbo].[Suspect] AS S
ON C.[CrimeID] = S.[CrimeID]
WHERE S.[Name] IN
(SELECT [Name] FROM [dbo].[Victim]);
-- Question 14
SELECT * FROM [dbo].[Crime] AS C
JOIN [dbo].[Suspect] AS S
ON C.[CrimeID] = S.[CrimeID]
JOIN [dbo].[Victim] AS V
ON C.[CrimeID] = V.[CrimeID];
-- Question 15
ALTER TABLE [dbo].[Victim]
ADD Age INT;
UPDATE [dbo].[Victim] SET [Age] = 15 WHERE [VictimID] = 1;
UPDATE [dbo].[Victim] SET [Age] = 20 WHERE [VictimID] = 2;
UPDATE [dbo].[Victim] SET [Age] = 38 WHERE [VictimID] = 3;
SELECT C.* FROM [dbo].[Crime] AS C
JOIN [dbo].[Suspect] AS S
ON C.[CrimeID] = S.[CrimeID]
JOIN [dbo].[Victim] AS V
ON C.[CrimeID] = V.[CrimeID]
WHERE S.[Age] > V.[Age];
-- Question 16
SELECT S.[SuspectID] FROM [dbo].[Suspect] AS S
JOIN [dbo].[Crime] AS C
ON S.[CrimeID] = C.[CrimeID]
GROUP BY S.[SuspectID]
HAVING COUNT(C.[CrimeID]) > 1;
-- Question 17
SELECT * FROM [dbo].[Crime]
WHERE [CrimeID] NOT IN
(SELECT [CrimeID] FROM [dbo].[Suspect]);
-- Question 18
SELECT * FROM [dbo].[Crime]
WHERE [IncidentType] IN ('Homicide','Robbery');
-- Question 19
SELECT C.[CrimeID],
CASE
	WHEN S.[Name] IN (SELECT S.[Name] FROM [dbo].[Crime] AS C
						JOIN [dbo].[Suspect] AS S
						ON C.[CrimeID] = S.[CrimeID]) THEN S.[Name]
	ELSE 'No Suspect'
END
AS 'SuspectName'
FROM [dbo].[Crime] AS C
JOIN [dbo].[Suspect] AS S
ON C.[CrimeID] = S.[CrimeID];
-- Question 20
SELECT S.* FROM [dbo].[Suspect] AS S
JOIN [dbo].[Crime] AS C
ON S.[CrimeID] = C.[CrimeID]
WHERE C.[IncidentType] = 'Robbery' OR C.[IncidentType] = 'Assault';