CREATE DATABASE VirtualArtGallery;
USE VirtualArtGallery;
-- Create the Artists table
CREATE TABLE Artists (
	ArtistID INT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Biography TEXT,
	Nationality VARCHAR(100)
);
-- Create the Categories table
CREATE TABLE Categories (
	CategoryID INT PRIMARY KEY,
	Name VARCHAR(100) NOT NULL
);
-- Create the Artworks table
CREATE TABLE Artworks (
	ArtworkID INT PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	ArtistID INT,
	CategoryID INT,
	Year INT,
	Description TEXT,
	ImageURL VARCHAR(255),
	FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
	FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
);
-- Create the Exhibitions table
CREATE TABLE Exhibitions (
	ExhibitionID INT PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	StartDate DATE,
	EndDate DATE,
	Description TEXT
);
-- Create a table to associate artworks with exhibitions
CREATE TABLE ExhibitionArtworks (
	ExhibitionID INT,
	ArtworkID INT,
	PRIMARY KEY (ExhibitionID, ArtworkID),
	FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
	FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)
);
-- Insert sample data into the Artists table
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
	(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
	(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
	(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');
-- Insert sample data into the Categories table
INSERT INTO Categories (CategoryID, Name) VALUES
	(1, 'Painting'),
	(2, 'Sculpture'),
	(3, 'Photography');
-- Insert sample data into the Artworks table
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
	(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
	(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
	(3, 'Guernica', 1, 1, 1937, 'Pablo Picassos powerful anti-war mural.', 'guernica.jpg');
-- Insert sample data into the Exhibitions table
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
	(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
	(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');
-- Insert artworks into exhibitions
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 2);
-- Question 1
SELECT A.[Name],COUNT(AW.[ArtworkID]) 'NoOfArtworks' FROM [dbo].[Artists] AS A
JOIN [dbo].[Artworks] AS AW
ON A.[ArtistID] = AW.[ArtistID]
GROUP BY A.[Name]
ORDER BY 2 DESC;
-- Question 2
SELECT AW.[Title] FROM [dbo].[Artworks] AS AW
WHERE AW.[ArtistID] IN
(SELECT [ArtistID] FROM [dbo].[Artists]
WHERE [Nationality] = 'Spanish' OR [Nationality] = 'Dutch')
ORDER BY AW.[Year] ASC;
-- Question 3
SELECT A.[Name],C.[Name] 'Category',COUNT(AW.[ArtworkID]) 'NoOfArtworks' FROM [dbo].[Artists] AS A
JOIN [dbo].[Artworks] AS AW
ON A.[ArtistID] = AW.[ArtistID]
JOIN [dbo].[Categories] AS C
ON AW.[CategoryID] = C.[CategoryID]
WHERE C.[Name] = 'Painting'
GROUP BY A.[Name],C.[Name];
-- Question 4
SELECT AW.[Title],A.[Name] 'Artist',C.[Name] 'Category' FROM [dbo].[Artworks] AS AW
JOIN [dbo].[ExhibitionArtworks] AS EA
ON AW.[ArtworkID] = EA.[ArtworkID]
JOIN [dbo].[Exhibitions] AS E
ON EA.[ExhibitionID] = E.[ExhibitionID]
JOIN [dbo].[Artists] AS A
ON AW.[ArtistID] = A.[ArtistID]
JOIN [dbo].[Categories] AS C
ON AW.[CategoryID] = C.[CategoryID]
WHERE E.[Title] = 'Modern Art Masterpieces';
-- Question 5
SELECT [Name] FROM [dbo].[Artists]
WHERE [ArtistID] IN
(SELECT [ArtistID] FROM [dbo].[Artworks]
GROUP BY [ArtistID]
HAVING COUNT([ArtistID]) > 2);
-- Question 6
SELECT AW.[Title] FROM [dbo].[Artworks] AS AW
JOIN [dbo].[ExhibitionArtworks] AS EA
ON AW.[ArtworkID] = EA.[ArtworkID]
JOIN [dbo].[Exhibitions] AS E
ON EA.[ExhibitionID] = E.[ExhibitionID]
WHERE E.[Title] IN
('Modern Art Masterpieces','Renaissance Art')
GROUP BY AW.[Title]
HAVING COUNT(DISTINCT E.[Title]) = 2;
-- Question 7
SELECT C.[CategoryID],COUNT(AW.[ArtworkID]) 'NoOfArtworks' FROM [dbo].[Artworks] AS AW
FULL JOIN [dbo].[Categories] AS C
ON AW.[CategoryID] = C.[CategoryID]
GROUP BY C.[CategoryID];
-- Question 8
SELECT [Name] FROM [dbo].[Artists]
WHERE [ArtistID] IN
(SELECT [ArtistID] FROM [dbo].[Artworks]
GROUP BY [ArtistID]
HAVING COUNT([ArtworkID]) > 3);
-- Question 9
SELECT * FROM [dbo].[Artworks]
WHERE [ArtistID] IN
(SELECT [ArtistID] FROM [dbo].[Artists]
WHERE [Nationality] = 'Spanish');
-- Question 10
SELECT E.[Title] FROM [dbo].[Exhibitions] AS E
JOIN [dbo].[ExhibitionArtworks] AS EA
ON E.[ExhibitionID] = EA.[ExhibitionID]
JOIN [dbo].[Artworks] AS AW
ON EA.[ArtworkID] = AW.[ArtworkID]
JOIN [dbo].[Artists] AS A
ON AW.[ArtistID] = A.[ArtistID]
WHERE A.[Name] IN
('Vincent van Gogh','Leonardo da Vinci')
GROUP BY E.[ExhibitionID],E.[Title]
HAVING COUNT(DISTINCT A.[Name]) = 2;
-- Question 11
SELECT * FROM [dbo].[Artworks]
WHERE [ArtworkID] NOT IN
(SELECT [ArtworkID] FROM [dbo].[ExhibitionArtworks]);
-- Question 12
SELECT A.[Name] FROM [dbo].[Artists] AS A
FULL JOIN [dbo].[Artworks] AS AW
ON A.[ArtistID] = AW.[ArtistID]
GROUP BY A.[Name] 
HAVING COUNT(AW.[ArtworkID]) IN 
(SELECT COUNT([ArtworkID]) FROM [dbo].[Artworks]
GROUP BY [CategoryID]);
-- Question 13
SELECT C.[CategoryID],COUNT(AW.[ArtworkID]) 'NoOfArtworks' FROM [dbo].[Artworks] AS AW
FULL JOIN [dbo].[Categories] AS C
ON AW.[CategoryID] = C.[CategoryID]
GROUP BY C.[CategoryID];
-- Question 14
SELECT A.[Name] FROM [dbo].[Artists] AS A
JOIN [dbo].[Artworks] AS AW
ON A.[ArtistID] = AW.[ArtistID]
GROUP BY AW.[ArtistID],A.[Name]
HAVING COUNT(AW.[ArtworkID]) > 2;
-- Question 15
SELECT C.[CategoryID],C.[Name],AVG(AW.[Year]) 'AverageYear' FROM [dbo].[Categories] AS C
FULL JOIN [dbo].[Artworks] AS AW
ON C.[CategoryID] = AW.[CategoryID]
GROUP BY C.[CategoryID],C.[Name]
HAVING COUNT(AW.[ArtworkID]) > 1;
-- Question 16
SELECT AW.[Title] FROM [dbo].[Artworks] AS AW
JOIN [dbo].[ExhibitionArtworks] AS EA
ON AW.[ArtworkID] = EA.[ArtworkID]
JOIN [dbo].[Exhibitions] AS E
ON EA.[ExhibitionID] = E.[ExhibitionID]
WHERE E.[Title] = 'Modern Art Masterpieces';
-- Question 17
SELECT C.[CategoryID],C.[Name] FROM [dbo].[Categories] AS C
FULL JOIN [dbo].[Artworks] AS AW
ON C.[CategoryID] = AW.[CategoryID]
GROUP BY C.[CategoryID],C.[Name]
HAVING AVG(AW.[Year]) > 
(SELECT AVG([Year]) FROM [dbo].[Artworks]);
-- Question 18
SELECT * FROM [dbo].[Artworks]
WHERE [ArtworkID] NOT IN
(SELECT [ArtworkID] FROM [dbo].[ExhibitionArtworks]);
-- Question 19
SELECT A.[Name],C.[CategoryID] FROM [dbo].[Artists] AS A
JOIN [dbo].[Artworks] AS AW
ON A.[ArtistID] = AW.[ArtistID]
JOIN [dbo].[Categories] AS C
ON AW.[CategoryID] = C.[CategoryID]
WHERE C.[CategoryID] =
(SELECT [CategoryID] FROM [dbo].[Artworks]
WHERE [Title] = 'Mona Lisa');
-- Question 20
SELECT A.[Name],COUNT(AW.[ArtworkID]) 'NoOfArtworks' FROM [dbo].[Artists] AS A
JOIN [dbo].[Artworks] AS AW
ON A.[ArtistID] = AW.[ArtistID]
GROUP BY A.[ArtistID],A.[Name];
