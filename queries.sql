USE GroceryStore2214618; 

-- query 1

SELECT C.Name as "CustName", S.StoreID as "Store_ID", S.Address as "Store Address",
       M.Name as "Manager of The Store", O.DateOfPurchase as "Transaction Date", I.Brand, I.Description,
       CO.Quantity as "Quantity Purchased", E.Name as "Served By"
FROM CheckOut O 
JOIN Customer C ON O.CustID = C.CustID
JOIN CheckOutItems CO ON O.CheckOutID = CO.CheckOutID
JOIN Item I ON CO.ItemID = I.ItemID
JOIN Employee E ON O.EmpID = E.EmpID
JOIN Store S ON E.StoreID = S.StoreID
JOIN Employee M ON S.ManagerID = M.EmpID;

-- query 2

SELECT S.ManagerID as "Store Manager ID", E.Name as "Name of Manager", S.StoreID as "Store Managed", I.ItemID as "Item", 
       Iv.Quantity as "Quantity on Inventory" 
FROM Inventory Iv
JOIN Item I ON Iv.ItemID = I.ItemID
JOIN Store S ON Iv.StoreID = S.StoreID
JOIN Employee E ON E.EmpID = S.ManagerID;

-- query 3
-- include those that never buy anything so i do left and right join
SELECT X.Name AS "Customers Who Bought <= 2 On Any Single Transaction"
FROM (
  SELECT C.Name, SUM(CI.Quantity) AS Qty
  FROM Customer C
  LEFT OUTER JOIN CheckOut O ON O.CustID = C.CustID -- include those who nvr buy anything
  LEFT OUTER JOIN CheckOutItems CI ON CI.CheckOutID = O.CheckOutID
  GROUP BY C.Name, O.CheckOutID
) AS X
GROUP BY X.Name
HAVING MAX(ISNULL(X.Qty, 0)) <= 2; -- find max items quantity on any trans

-- query 4

SELECT I.[ItemID] as "Item_ID", I.Description, 
       SUM(I.Price * Inv.Quantity) as 'Retail', 
       SUM(I.Cost * Inv.Quantity) as 'WholeSale'
FROM Item I 
JOIN Inventory Inv ON Inv.ItemID = I.ItemID
JOIN Store S ON S.StoreID = Inv.StoreID
GROUP BY I.ItemID, I.Description
HAVING COUNT(Inv.StoreID) >= 2;

-- query 5

SELECT E.Name as "Name of Employee", E.EmpID as "Employee ID", 
       M.Name as "Name of Manager", M.EmpID as "Manager ID" 
FROM Employee E 
JOIN Employee M ON E.ManagerID = M.EmpID;

-- query 6

SELECT DISTINCT M.Name as "Name of Manager", B.EmpID as "Boss ID", M.EmpID as "Manager ID", 
	   B.Name as "Name of Boss", M.StoreID as "Store ID", S.Address
FROM Employee E 
JOIN Employee M ON E.ManagerID = M.EmpID 
JOIN Employee B ON M.ManagerID = B.EmpID 
JOIN Store S ON M.StoreID = S.StoreID
WHERE M.StoreID = B.StoreID;


