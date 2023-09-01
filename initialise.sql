CREATE DATABASE GroceryStore2214618;

GO

USE GroceryStore2214618; 

-- assume shop started at 1970
-- assume employee and customer from usa only
-- assume got offers and stuff so flexible subtotal

-- item
CREATE TABLE [dbo].[Item] (
    [ItemID] INT PRIMARY KEY IDENTITY(1,1), -- auto increment
    [Brand] VARCHAR(30) NOT NULL,
    [Tax] VARCHAR(1) NOT NULL,
    [Price] SMALLMONEY NOT NULL,
    [Shape] VARCHAR(12) NOT NULL,
    [Size] VARCHAR(12) NOT NULL,
    [Cost] SMALLMONEY NOT NULL,
    [Weight] DECIMAL(6,2) NOT NULL, 
    [Description] VARCHAR(255) NOT NULL,
    [UPC] VARCHAR(6) NOT NULL,
    CONSTRAINT itemWeight CHECK([Weight] >= 0)    
);
SET IDENTITY_INSERT [dbo].[Item] ON; -- to allow for the auto increment to be overide
INSERT INTO [dbo].[Item] (ItemID, Brand, Description, Price, Cost, Shape, Size, UPC, Weight, Tax)
VALUES
    (12, 'Nabisco', 'Cookies', 2.25, 1.00, 'Oval', '23x5x20', '224852', 22.40, 1),
    (145, 'Kleenex', 'Tissues', 2.99, 1.00, 'Rectangle', '3x19x4', '178965', 34.00, 0),
    (1566, 'HomeBrand', 'Spaghetti', 0.99, 0.50, 'Round', '3x3x3', '698547', 3.00, 0),
    (2365, 'Kellogg', 'Cereal', 1.99, 0.50, 'Round', '10x10x10', '557858', 18.00, 1),
    (256, 'Hershey', 'Candy', 3.99, 2.00, 'Rectangle', '4x16x6', '123058', 52.80, 0),
    (335, 'Del Monte', 'Canned Fruit', 0.50, 0.10, 'Square', '3x3x3', '411255', 5.20, 1),
    (3521, 'Nabisco', 'Crackers', 4.00, 2.00, 'Round', '4x4x4', '254413', 2.00, 0),
    (4587, 'Kraft', 'Cheese', 6.00, 4.00, 'Rectangle', '6x12x3', '845532', 0.11, 0),
    (658, 'Phillip Morris', 'Cigarettes', 5.00, 3.00, 'Square', '8x8x8', '596543', 89.00, 0),
    (84854, 'Quaker', 'Oatmeal', 2.50, 1.00, 'Square', '2x2x2', '556487', 1.00, 0);
SET IDENTITY_INSERT [dbo].[Item] OFF;
-- customer
CREATE TABLE [dbo].[Customer](
    [CustID] INT PRIMARY KEY IDENTITY(1,1), -- auto increment
    [Name] VARCHAR(50) NOT NULL,
    [Phone] VARCHAR(10) NULL, -- us phone num length
    [Email] VARCHAR(50) NULL,
    [Date_Joined] DATE NOT NULL,
    CONSTRAINT CustomerDate CHECK([Date_Joined] >= '1970-01-01') -- assume thats when shop started
);
SET IDENTITY_INSERT [dbo].[Customer] ON; -- allow auto increment to be override
INSERT INTO [dbo].[Customer] (CustID, Name, Phone, Email, Date_Joined)
VALUES
    (105, 'Master Shake', '5555555555', 'MixMaster@crimefighter.org', '2000-08-25'),
    (178, 'Bruce Wayne', '6619872145', 'lamBatman@crimefighter.org', '2000-01-09'),
    (179, 'Seymoure Butes', '4789582145', 'SButes@education.edu', '2001-01-01'),
    (50, 'Bob Hope', '6615552485', 'Bobhope@gmail.com', '2001-01-01'),
    (51, 'Renee Hicks', '4589854588', 'Dragonthing@aol.com', '2005-05-05'),
    (52, 'Scott Sheer', '4176521425', 'Scotts@hotmail.com', '2011-12-12'),
    (53, 'Colleen Mctyre', NULL, 'CMcT@ct.com', '2008-08-12'),
    (58, 'Bart Simpson', NULL, NULL, '2001-06-06'),
    (67, 'Lisa Girl', '6619755896', NULL, '1999-04-09'),
    (99, 'Jeremy Scott', '4586895847', 'TheBigMan@gmail.com', '2000-09-01');
SET IDENTITY_INSERT [dbo].[Customer] OFF;

-- Store
CREATE TABLE [dbo].[Store](
    [StoreID] INT PRIMARY KEY IDENTITY(1,1),
    [Address] VARCHAR(255) NOT NULL,
    [ManagerID] INT NOT NULL -- cannot add fk now cuz employee relation not created yet
);
SET IDENTITY_INSERT [dbo].[Store] ON; -- allow auto increment to be override
INSERT INTO [dbo].[Store] (StoreID, Address, ManagerID)
VALUES
    (854,'22556 Elm St',14),
    (778,'341 Main St',15),
    (159,'13636 Fir St',14),
    (369,'940 Green St',6),
    (354,'820 Birch Rd',15),
    (696,'710 Edison Dr',4),
    (674,'14496 Maple Way',6),
    (247,'10 orangutan street',10),
    (989,'20 monkey avenue',15),
    (348,'9 rich boy den',10)
SET IDENTITY_INSERT [dbo].[Store] OFF;
-- invetory 
CREATE TABLE [dbo].[Inventory](
    [StoreID] INT NOT NULL,
    [ItemID] INT NOT NULL,
    [Quantity] SMALLINT NOT NULL,
    PRIMARY KEY (StoreID,ItemID),
    CONSTRAINT inventoryItem FOREIGN KEY (ItemID) REFERENCES [dbo].[Item](ItemID) ON DELETE CASCADE,
    CONSTRAINT inventoryStore FOREIGN KEY (StoreID) REFERENCES [dbo].[Store](StoreID) ON DELETE CASCADE
)
INSERT INTO [dbo].[Inventory] (StoreID, ItemID, Quantity)
VALUES
    (159, 1566, 31),
    (159, 335, 27),
    (247, 145, 56),
    (348, 256, 100),
    (354, 1566, 4),
    (369, 3521, 113),
    (674, 2365, 0),
    (674, 4587, 23),
    (696, 12, 23),
    (696, 658, 38),
    (778, 84854, 350),
    (854, 12, 10),
    (854, 658, 10),
    (989, 145, 560);
-- Create Employee
CREATE TABLE [dbo].[Employee] (
    [EmpID] INT PRIMARY KEY IDENTITY(1,1), -- auto increment
    [Name] VARCHAR(50) NOT NULL,
    [SSN] VARCHAR(9) NOT NULL UNIQUE,
    [Phone] VARCHAR(10) NOT NULL,
    [Address] VARCHAR(255) NOT NULL,
    [Email] VARCHAR(50) NULL,
    [Password] VARCHAR(50) NULL,
    [Date_Start] DATE NOT NULL, -- check if more than 1970
    [Date_End] DATE NULL,
    [Date_Hired] DATE NULL,
    [StoreID] INT NOT NULL,
    [ManagerID] INT NULL REFERENCES [dbo].[Employee](EmpID),
    [HourlyPay] MONEY  NULL,
    [YearlyPay] MONEY  NULL,
    [ChngPwdDate] DATE NULL,
    CONSTRAINT employeeDate CHECK([Date_End] >= [Date_Start] AND [Date_Start] >= '1970-01-01'),-- when the shop was founded in 1970
    CONSTRAINT employeeStore FOREIGN KEY (StoreID) REFERENCES [dbo].[Store](StoreID) ON DELETE NO ACTION  --  transfer employee before deleting
);
SET IDENTITY_INSERT [dbo].[Employee] ON; -- allow auto increment to be override
INSERT INTO [dbo].[Employee] (EmpID, Name, SSN, Phone, StoreID, Address, Password, ManagerID, Email, Date_Hired, Date_Start, Date_End, YearlyPay, HourlyPay, ChngPwdDate)
VALUES
    (1, 'Darrel Philbin', '654269856', '5489659874', 854, '258 Cumberland dr', '1234', 14, 'baldman@gmail.com', '1985-04-05', '2011-02-02', NULL, 20, 3.6, '2009-06-03'),
    (10, 'Jerry Garcia', '758965897', '6521458569', 247, '214 Q st', '1234', 9, 'govperson@gov.gov', NULL, '1990-09-24', NULL, 52000, NULL, '2010-08-20'),
    (11, 'Lawarnce Tom', '625458569', '9658745632', 159, '2154 Beech st', NULL, 14, NULL, NULL, '1989-01-20', '2011-09-01', NULL, 15, '2011-03-09'),
    (12, 'Dexter Robert', '254125478', '1111111111', 778, '365 Moon dr', NULL, 15, NULL, NULL, '1990-05-06', NULL, NULL, 12.25, '2011-03-28'),
    (13, 'Mark Nick', '563258965', '2225478512', 989, '65412 B St', NULL, 15, NULL, NULL, '1998-02-05', NULL, NULL, 8.25, '2011-07-20'),
    (14, 'Jeremy David', '111111112', '2356895654', 159, '2 Molly Way', NULL, 9, NULL, NULL, '2000-06-03', NULL, 16000, NULL, '2013-02-07'),
    (15, 'Luke Ted', '111111144', '2144544123', 354, '65 Southland Av', NULL, 9, NULL, NULL, '2004-09-09', NULL, 20000, NULL, '2013-11-18'),
    (2, 'Ricky Tanner', '125651452', '6988532587', 696, '1587 Hst', 'Abcdef', 4, 'omegaman@aol.com', NULL, '1990-06-08', '1999-06-10', NULL, 10, NULL),
    (3, 'Susan Phillips', '145969658', '9856984523', 369, '695 LMNOP st', 'Password', 4, 'streetsmartkid@hampster.edu', NULL, '1972-06-09', NULL, NULL, 15, '2018-04-25'),
    (4, 'George Scott', '147589652', '2586521452', 696, '4521 Gold st', 'Alpha', 9, NULL, NULL, '1999-07-25', NULL, 42000, NULL, '2018-07-09'),
    (5, 'Erin Abernathy', '256985698', '5896583541', 369, '635 Number In', 'Bottle', 6, 'drinkerster@gmail.com', NULL, '1998-12-20', NULL, NULL, 30, '2019-05-21'),
    (6, 'Ted Smith', '352956587', '4736593569', 369, '12 S st', 'Worksu', 9, NULL, NULL, '1989-06-08', NULL, 50000, NULL, '2019-06-11'),
    (7, 'Harry Buts', '458521658', '2586584763', 674, '1 wonder st', 'Password', 6, NULL, NULL, '1970-10-20', NULL, NULL, 12, '2019-07-25'),
    (8, 'Maynar Teener', '256656521', '2596573257', 674, '24 nice In', 'Password', 6, 'Meme585@gmail.com', NULL, '2005-06-04', NULL, NULL, 9.25, '2021-03-10'),
    (9, 'Matt Longfell.', '958786548', '5249868525', 354, '6144 Computer', 'Password', NULL, 'thisisshort@az.com', NULL, '2000-09-21', NULL, 60000, NULL, '2021-11-29');
SET IDENTITY_INSERT [dbo].[Employee] OFF;
-- store must refer to manager
ALTER TABLE [dbo].[Store]
ADD CONSTRAINT storeManager FOREIGN KEY (ManagerID) REFERENCES [dbo].[Employee](EmpID); -- very strict. must chng manager before deleting him. double check this pls before submitting
-- cuz need create employee table before ref to it
-- Dependent
CREATE TABLE [dbo].[Dependent](
    [EmpID] INT NOT NULL,
    [Name] VARCHAR(50) NOT NULL,
    [Phone] VARCHAR(10) NULL,
    [Relation] VARCHAR(11) NOT NULL CHECK (Relation IN('Spouse','Child','Parent','Sibling','Grandparent','Grandchild','Others')),
    CONSTRAINT dependentEmployee FOREIGN KEY (EmpID) REFERENCES [dbo].[Employee](EmpID) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(EmpID,Name)
);
INSERT INTO [dbo].[Dependent] ([EmpID], [Name], [Phone], [Relation])
VALUES
    (1, 'John Smith', '5551234567', 'Spouse'),
    (1, 'Emma Smith', '5559876543', 'Child'),
    (2, 'Michael Johnson', '5555551212', 'Spouse'),
    (3, 'Sarah Davis', '5556667777', 'Child'),
    (3, 'Robert Davis', '5552223333', 'Child'),
    (4, 'Jennifer Thompson', '5558889999', 'Spouse'),
    (4, 'Daniel Thompson', '5554445555', 'Child'),
    (5, 'Michelle Anderson', '5557778888', 'Parent'),
    (5, 'Olivia Anderson', '5551231234', 'Child'),
    (6, 'William Wilson', '5559876543', 'Spouse'),
    (6, 'Sophia Wilson', '5554567890', 'Sibling'),
    (7, 'Emily Martinez', '5553216547', 'Spouse'),
    (8, 'James Jackson', '5555555555', 'Spouse'),
    (9, 'Ava Lopez', '5557777777', 'Spouse'),
    (10, 'Matthew Lee', '5558888888', 'Spouse'),
    (11, 'Charlotte Harris', '5559999999', 'Grandchild'),
    (12, 'Henry Clark', '5551112222', 'Spouse'),
    (12, 'Liam Clark', '5553334444', 'Child'),
    (13, 'Amelia Lewis', '5555551234', 'Spouse'),
    (14, 'Daniel Young', '5555557890', 'Spouse'),
    (15, 'Evelyn Hall', '5557771234', 'Spouse');
-- Transaction
CREATE TABLE [dbo].[CheckOut](
    [CheckOutID] INT PRIMARY KEY IDENTITY(1,1),
    [CustID] INT NOT NULL,
    [EmpID] INT NOT NULL,
    [DateOfPurchase] DATE NOT NULL,
    CONSTRAINT checkoutEmployee FOREIGN KEY (EmpID) REFERENCES [dbo].[Employee](EmpID),
    CONSTRAINT checkoutCustomer FOREIGN KEY (CustID) REFERENCES [dbo].[Customer](CustID),
    CONSTRAINT checkoutDate CHECK([DateOfPurchase] >= '1970-01-01')
)
SET IDENTITY_INSERT [dbo].[CheckOut] ON; -- allow auto increment to be override
INSERT INTO [dbo].[CheckOut] ([CheckOutID], [CustID], [DateOfPurchase], [EmpID])
VALUES
    (1, 50, '2011-06-10', 1),
    (2, 178, '2011-12-12', 12),
    (3, 99, '2010-06-05', 11),
    (4, 105, '2007-04-05', 3),
    (5, 51, '2011-06-09', 15),
    (6, 52, '2010-08-12', 2),
    (7, 179, '2009-11-05', 7);
SET IDENTITY_INSERT [dbo].[CheckOut] OFF;
-- Checkout
CREATE TABLE [dbo].[CheckOutItems](
    [CheckOutID] INT NOT NULL,
    [ItemID] INT NOT NULL,
    [Quantity] INT NOT NULL,
    PRIMARY KEY(CheckOutID,ItemID),
    CONSTRAINT transCheckout FOREIGN KEY (CheckOutID) REFERENCES [dbo].[CheckOut](CheckOutID),
    CONSTRAINT transItem FOREIGN KEY (ItemID) REFERENCES [dbo].[Item](ItemID),
    CONSTRAINT transQuantity CHECK([Quantity] > 0)
);
INSERT INTO [dbo].[CheckOutItems] ([CheckOutID], [ItemID], [Quantity])
VALUES
    (1, 256, 2),
    (1, 2365, 2),
    (2, 145, 10),
    (3, 4587, 2),
    (4, 4587, 4),
    (5, 1566, 4),
    (5, 145, 3),
    (5, 3521, 2),
    (5, 84854, 2),
    (6, 2365, 2),
    (6, 4587, 2),
    (7, 3521, 2),
    (7, 658, 2);