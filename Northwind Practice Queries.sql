USE northwind;

-- Query 1 - Select the average unit price of all discontinued products from the products tables
SELECT * FROM products;
SELECT ProductID, ProductName, ROUND(AVG(unitprice), 2) FROM products
	WHERE discontinued = 1
    GROUP BY productid, productname;
    
SELECT AVG(unitprice) FROM products
	WHERE discontinued = 1;
    
-- Query 2 - Select the average unit price of all active (not discontinued) products in the products table.
SELECT ProductID, ProductName, AVG(unitprice) FROM products
	WHERE discontinued = 0
    GROUP BY productid, productname;
    
SELECT AVG(unitprice) FROM products
	WHERE discontinued = 0;
    
-- Query 3 - Select the average units in stock from the products table.
SELECT AVG(unitsinstock) FROM products;

-- Query 4 - Select the average units in stock by product category.
SELECT CategoryID, AVG(unitsinstock) FROM products
	GROUP BY CategoryID;
    
SELECT CategoryName, AVG(Unitsinstock) FROM products p
	JOIN categories c ON c.categoryid = p.categoryid
    GROUP BY categoryname;
    
-- Query 5 - Select the name and price of the most expensive active (not discontinued) product.
SELECT ProductName, UnitPrice FROM products
	WHERE discontinued = 0
    ORDER BY unitprice DESC
    LIMIT 1;
    
SELECT ProductName, UnitPrice FROM products
	WHERE discontinued = 0 AND unitprice = (SELECT MAX(unitprice) FROM products);
    
-- Query 6 - Select the name and price of the least expensive active (not discontinued) product.
SELECT ProductName, UnitPrice FROM products
	WHERE discontinued = 0
    ORDER BY unitprice
    LIMIT 1;
    
SELECT ProductName, UnitPrice FROM products
	WHERE discontinued = 0 AND unitprice = (SELECT MIN(unitprice) FROM products);
    
-- Query 7 - Create a rank of products from most expensive to least expensive.
SELECT ProductName, UnitPrice, RANK() OVER(ORDER BY unitprice DESC) AS PriceRank FROM products;

SELECT ProductName, UnitPrice, DENSE_RANK() OVER(ORDER BY unitprice DESC) AS PriceRank FROM products;

-- Query 8 - Select the name of all active (not discontinued) products that don’t have any units in stock.
SELECT ProductName FROM products
	WHERE discontinued = 0 AND unitsinstock = 0;
    
-- Query 9 - Select a count of active (not discontinued) products by supplier company name.
SELECT s.CompanyName, COUNT(p.productID) FROM products p
	JOIN suppliers s ON p.supplierid = s.supplierid
    WHERE discontinued = 0
    GROUP BY p.supplierID;
    
-- Query 10 - Select count of active (not discontinued) products from each supplier that have a reorder level of 10 or more.
SELECT s.CompanyName, COUNT(p.productID) FROM products p
	JOIN suppliers s ON s.supplierid = p.supplierid
    WHERE discontinued = 0 AND reorderlevel >= 10
    GROUP BY p.supplierid;