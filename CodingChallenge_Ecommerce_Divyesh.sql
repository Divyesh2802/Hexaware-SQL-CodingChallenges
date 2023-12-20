CREATE DATABASE Ecommerce;
USE Ecommerce;
-- SQL Schema
CREATE TABLE Customers(
	customerID INT PRIMARY KEY,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
);
CREATE TABLE Products(
	productID INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	description VARCHAR(100) NOT NULL,
	price FLOAT NOT NULL,
	stockQuantity INT NOT NULL
);
CREATE TABLE Cart(
	cartID INT PRIMARY KEY,
	customerID INT NOT NULL, 
	productID INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY(customerID) REFERENCES Customers(customerID) ON DELETE CASCADE,
	FOREIGN KEY(productID) REFERENCES Products(productID) ON DELETE CASCADE
);
CREATE TABLE Orders(
	orderID INT PRIMARY KEY,
	customerID INT NOT NULL,
	orderDate DATE NOT NULL,
	totalAmount FLOAT NOT NULL,
	FOREIGN KEY(customerID) REFERENCES Customers(customerID) ON DELETE CASCADE
);
CREATE TABLE OrderItems(
	orderItemID INT PRIMARY KEY,
	orderID INT NOT NULL,
	productID INT NOT NULL,
	quantity INT NOT NULL,
	itemAmount FLOAT NOT NULL,
	FOREIGN KEY(productID) REFERENCES Products(productID) ON DELETE CASCADE,
	FOREIGN KEY(orderID) REFERENCES Orders(orderID) ON DELETE CASCADE	
);
-- Inserting Values
INSERT INTO [dbo].[Customers] VALUES(1,'John','Doe','johndoe@example.com','123 Main St, City');
INSERT INTO [dbo].[Customers] VALUES(2,'Jane','Smith','janesmith@example.com','456 Elm St, Town');
INSERT INTO [dbo].[Customers] VALUES(3,'Robert','Johnson','robert@example.com','789 Oak St, Village');
INSERT INTO [dbo].[Customers] VALUES(4,'Sarah','Brown','sarah@example.com','101 Pine St, Suburb');
INSERT INTO [dbo].[Customers] VALUES(5,'David','Lee','david@example.com','234 Cedar St, District');
INSERT INTO [dbo].[Customers] VALUES(6,'Laura','Hall','laura@example.com','567 Birch St, County');
INSERT INTO [dbo].[Customers] VALUES(7,'Michael','Davis','michael@example.com','890 Maple St, State');
INSERT INTO [dbo].[Customers] VALUES(8,'Emma','Wilson','emma@example.com','321 Redwood St, Country');
INSERT INTO [dbo].[Customers] VALUES(9,'William','Taylor','william@example.com','432 Spruce St, Province');
INSERT INTO [dbo].[Customers] VALUES(10,'Olivia','Adams','olivia@example.com','765 Fir St, Territory');

INSERT INTO [dbo].[Products] VALUES(1,'Laptop','High-performance laptop',800.00,10);
INSERT INTO [dbo].[Products] VALUES(2,'Smartphone','Latest smartphone',600.00,15);
INSERT INTO [dbo].[Products] VALUES(3,'Tablet','Portable tablet',300.00,20);
INSERT INTO [dbo].[Products] VALUES(4,'Headphones','Noise-canceling',150.00,30);
INSERT INTO [dbo].[Products] VALUES(5,'TV','4K Smart TV',900.00,5);
INSERT INTO [dbo].[Products] VALUES(6,'Coffee Maker','Automatic coffee maker',50.00,25);
INSERT INTO [dbo].[Products] VALUES(7,'Refrigerator','Energy-efficient',700.00,10);
INSERT INTO [dbo].[Products] VALUES(8,'Microwave Oven','Countertop microwave',80.00,15);
INSERT INTO [dbo].[Products] VALUES(9,'Blender','High-speed blender',70.00,20);
INSERT INTO [dbo].[Products] VALUES(10,'Vacuum Cleaner','Bagless vacuum cleaner',120.00,10);

INSERT INTO [dbo].[Cart] VALUES(1,1,1,2);
INSERT INTO [dbo].[Cart] VALUES(2,1,3,1);
INSERT INTO [dbo].[Cart] VALUES(3,2,2,3);
INSERT INTO [dbo].[Cart] VALUES(4,3,4,4);
INSERT INTO [dbo].[Cart] VALUES(5,3,5,2);
INSERT INTO [dbo].[Cart] VALUES(6,4,6,1);
INSERT INTO [dbo].[Cart] VALUES(7,5,1,1);
INSERT INTO [dbo].[Cart] VALUES(8,6,10,2);
INSERT INTO [dbo].[Cart] VALUES(9,6,9,3);
INSERT INTO [dbo].[Cart] VALUES(10,7,7,2);

INSERT INTO [dbo].[Orders] VALUES(1,1,'2023-01-05',1200.00);
INSERT INTO [dbo].[Orders] VALUES(2,2,'2023-02-10',900.00);
INSERT INTO [dbo].[Orders] VALUES(3,3,'2023-03-15',300.00);
INSERT INTO [dbo].[Orders] VALUES(4,4,'2023-04-20',150.00);
INSERT INTO [dbo].[Orders] VALUES(5,5,'2023-05-25',1800.00);
INSERT INTO [dbo].[Orders] VALUES(6,6,'2023-06-30',400.00);
INSERT INTO [dbo].[Orders] VALUES(7,7,'2023-07-05',700.00);
INSERT INTO [dbo].[Orders] VALUES(8,8,'2023-08-10',160.00);
INSERT INTO [dbo].[Orders] VALUES(9,9,'2023-09-15',140.00);
INSERT INTO [dbo].[Orders] VALUES(10,10,'2023-10-20',1400.00);

INSERT INTO [dbo].[OrderItems] VALUES(1,1,1,2,1600.00);
INSERT INTO [dbo].[OrderItems] VALUES(2,1,3,1,300.00);
INSERT INTO [dbo].[OrderItems] VALUES(3,2,2,3,1800.00);
INSERT INTO [dbo].[OrderItems] VALUES(4,3,5,2,1800.00);
INSERT INTO [dbo].[OrderItems] VALUES(5,4,4,4,600.00);
INSERT INTO [dbo].[OrderItems] VALUES(6,4,6,1,50.00);
INSERT INTO [dbo].[OrderItems] VALUES(7,5,1,1,800.00);
INSERT INTO [dbo].[OrderItems] VALUES(8,5,2,2,1200.00);
INSERT INTO [dbo].[OrderItems] VALUES(9,6,10,2,240.00);
INSERT INTO [dbo].[OrderItems] VALUES(10,6,9,3,210.00);
--Question 1
UPDATE [dbo].[Products] SET [price] = 800 WHERE [name] = 'Refrigerator';
SELECT * FROM [dbo].[Products];
--Question 2
DELETE FROM [dbo].[Cart] WHERE [customerID] = 2;
SELECT * FROM [dbo].[Cart];
--Question 3
SELECT * FROM [dbo].[Products] WHERE [price] < 100;
--Question 4
SELECT * FROM [dbo].[Products] WHERE [stockQuantity] > 5;
--Question 5
SELECT * FROM [dbo].[Orders] WHERE [totalAmount] BETWEEN 500 AND 1000;
--Question 6
SELECT * FROM [dbo].[Products] WHERE [name] LIKE '%r';
--Question 7
SELECT * FROM [dbo].[Cart] WHERE [customerID] = 5;
--Question 8
SELECT * FROM [dbo].[Customers] AS C
JOIN [dbo].[Orders] AS O
ON C.[customerID] = O.[customerID]
WHERE YEAR(O.[orderDate]) = 2023;
--Question 9
SELECT [name],MIN([stockQuantity]) 'minStockQuantity' FROM [dbo].[Products]
GROUP BY [name];
--Question 10
SELECT O.[customerID],OI.[orderID],SUM(OI.[itemAmount]) 'totalAmountSpent' FROM [dbo].[OrderItems] AS OI
RIGHT JOIN [dbo].[Orders] AS O
ON OI.[orderID] = O.[orderID]
GROUP BY O.[customerID],OI.[orderID];
--Question 11
SELECT O.[customerID],OI.[orderID],AVG(OI.[itemAmount]) 'averageOrderAmount' FROM [dbo].[OrderItems] AS OI
RIGHT JOIN [dbo].[Orders] AS O
ON OI.[orderID] = O.[orderID]
GROUP BY O.[customerID],OI.[orderID];
--Question 12
SELECT O.[customerID],OI.[orderID],COUNT(OI.[orderID]) 'numberOfOrdersPlaced' FROM [dbo].[OrderItems] AS OI
RIGHT JOIN [dbo].[Orders] AS O
ON OI.[orderID] = O.[orderID]
GROUP BY O.[customerID],OI.[orderID];
--Question 13
SELECT O.[customerID],OI.[orderID],MAX(OI.[itemAmount]) 'maxOrderAmount' FROM [dbo].[OrderItems] AS OI
RIGHT JOIN [dbo].[Orders] AS O
ON OI.[orderID] = O.[orderID]
GROUP BY O.[customerID],OI.[orderID];
--Question 14
SELECT O.[customerID],OI.[orderID],SUM(OI.[itemAmount]) 'totalAmountSpent' FROM [dbo].[OrderItems] AS OI
RIGHT JOIN [dbo].[Orders] AS O
ON OI.[orderID] = O.[orderID]
GROUP BY O.[customerID],OI.[orderID]
HAVING SUM(OI.[itemAmount]) > 1000;
--Question 15
SELECT * FROM [dbo].[Products] 
WHERE [productID] NOT IN
(SELECT [productID] FROM [dbo].[Cart]);
--Question 16
SELECT * FROM [dbo].[Customers]
WHERE [customerID] NOT IN
(SELECT [customerID] FROM [dbo].[Orders]);
--Question 17
SELECT [productID],SUM([itemAmount]) 'totalRevenue' FROM [dbo].[OrderItems]
WHERE [orderID] IN 
(SELECT [orderID] FROM [dbo].[Orders])
GROUP BY [productID];
--Question 18
SELECT OI.[productID],P.[stockQuantity] - OI.[quantity] 'leftOverStock'FROM [dbo].[Products] AS P
JOIN [dbo].[OrderItems] AS OI
ON P.[productID] = OI.[productID]
ORDER BY 2
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
--Question 19
SELECT  [customerID],SUM([totalAmount]) 'totalAmountSpent' FROM [dbo].[Orders]
WHERE [orderID] IN
(SELECT [orderID] FROM [dbo].[OrderItems])
GROUP BY [customerID]
ORDER BY 2 DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;