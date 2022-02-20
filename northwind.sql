-----------------------------------------------------------------------------------
-- Aufgaben: https://www.w3resource.com/mysql-exercises/northwind/products-table-exercises/
-----------------------------------------------------------------------------------

-- Write a query to get Product name and quantity/unit.
SELECT ProductName, QuantityPerUnit FROM Products;

-- Write a query to get current Product list (Product ID and name)
SELECT  ProductID, ProductName FROM Products;

-- Write a query to get discontinued Product list (Product ID and name)
SELECT  ProductID, ProductName FROM Products
    WHERE Discontinued = 1;

-- Write a query to get most expense and least expensive Product list (name and unit price)
SELECT ProductName, UnitPrice  FROM Products
    ORDER BY UnitPrice DESC;

-- Write a query to get Product list (id, name, unit price) where current products cost less than $20
SELECT ProductID, ProductName, UnitPrice FROM Products
    WHERE UnitPrice < 20
    ORDER BY UnitPrice DESC;

-- Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order
SELECT ProductName, UnitsOnOrder, UnitsInStock FROM  Products
    WHERE (Discontinued = 0) AND (UnitsOnOrder > UnitsInStock);


-----------------------------------------------------------------------------------
--Aufgaben: https://qdoc.tips/database-northwind-practice-queries-pdf-free.html
-----------------------------------------------------------------------------------

-- Aufgabe 1
SELECT CategoryName, Description FROM Categories
    ORDER BY CategoryName DESC;

-- Aufgabe 2
SELECT ContactName, CompanyName, ContactTitle, Phone FROM Customers
    ORDER BY Phone DESC;

-- Aufgabe 3
SELECT FirstName, LastName, HireDate FROM Employees
    ORDER BY HireDate ASC;

-- Aufgabe 4
SELECT OrderID, OrderDate, ShippedDate, CustomerID, Freight FROM Orders
    ORDER BY Freight DESC;

-- Aufgabe 5
SELECT CompanyName, Fax, Phone, HomePage, Country FROM Suppliers
    ORDER BY Country DESC, CompanyName ASC;

-- Aufgabe 6
SELECT  CompanyName, ContactName FROM Customers
    WHERE City = 'Buenos Aires';

-- Aufgabe 7
SELECT  ProductName, UnitPrice, QuantityPerUnit FROM Products
    WHERE UnitsInStock < UnitsOnOrder;

-- Aufgabe 8
SELECT OrderDate, ShippedDate, CustomerID, Freight FROM Orders
    WHERE OrderDate = '1997-05-19 00:00:00.000';

-- Aufgabe 9
SELECT FirstName, LastName, Country FROM Employees
    WHERE Country != 'USA';

-- Aufgabe 10
SELECT EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate FROM Orders
    WHERE RequiredDate < ShippedDate;

-- Aufgabe 11
SELECT City, CompanyName, ContactName FROM Customers
    WHERE City LIKE 'A%' OR City LIKE 'B%';

-- More excises ....

-- Aufgabe 23
SELECT CompanyName, ContactTitle, City, Country FROM Customers
    WHERE (Country = 'Mexico') OR
          (Country = 'Spain' AND City != 'Madrid');

-- More excises ....

-- Wie viele Bestellungen gab es?
SELECT COUNT(*) FROM "Order Details";

-- Gebe zu jeder Bestellung die Order ID und die Vor und nachnamen der Arbeitnehmer an
SELECT Orders.OrderID, E.FirstName, E.LastName FROM Orders
    inner join Employees E on E.EmployeeID = Orders.EmployeeID;

-- Gebe zu allen Terretorien die passende Region aus
SELECT  T.TerritoryDescription, Regions.RegionDescription FROM Regions
    INNER JOIN Territories T on Regions.RegionID = T.RegionID
    WHERE Regions.RegionID = 1;

--Gebe zu jeder Bestellung den Produkt Namen und das ShippungCountry an
SELECT ShipCountry, ProductName FROM "Order Details"
    INNER JOIN Products P on P.ProductID = "Order Details".ProductID
    INNER JOIN Orders O on O.OrderID = "Order Details".OrderID;

-- Gebe Name des Mitarbietrs und das Teretory an
SELECT FirstName, LastName, TerritoryDescription FROM EmployeeTerritories
    INNER JOIN Territories T on T.TerritoryID = EmployeeTerritories.TerritoryID
    INNER JOIN Employees E on E.EmployeeID = EmployeeTerritories.EmployeeID;


SELECT FirstName, LastName, COUNT(E.EmployeeID) as 'Anzahl der Terretorien der Angestellten' FROM EmployeeTerritories
    INNER JOIN Territories T on T.TerritoryID = EmployeeTerritories.TerritoryID
    INNER JOIN Employees E on E.EmployeeID = EmployeeTerritories.EmployeeID
    GROUP BY E.EmployeeID;


-- Get all Customers and their Orders
SELECT CompanyName, OrderDate FROM Customers
    LEFT JOIN Orders O on Customers.CustomerID = O.CustomerID
    ORDER BY CompanyName;

-- Get all Customers and their Orders
SELECT CompanyName, COUNT(CompanyName) AS 'Anzahl der Bestllung pro Kunde' FROM Customers
    LEFT JOIN Orders O on Customers.CustomerID = O.CustomerID
    GROUP BY CompanyName
    ORDER BY COUNT(CompanyName) DESC;


-----------------------------------------------------------------------------------
-- Pruefung
-----------------------------------------------------------------------------------
SELECT SupplierID, MAX(UnitPrice) AS MaxPreis  FROm Products
    group by SupplierID;


SELECT CategoryName, SUM(UnitsInStock) AS SumInStock FROM Categories
    LEFT JOIN Products P on Categories.CategoryID = P.ProductID
    GROUP BY CategoryName
    ORDER BY SumInStock DESC;


SELECT SupplierID, MAX(UnitPrice) AS MaxPreis  FROM Products
    group by SupplierID
    ORDER BY SupplierID ASC;
