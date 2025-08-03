-- Create and select new database
CREATE SCHEMA redata;
USE redata;

-- Imported table data, now checking data looks accurate
SELECT * FROM victoria;

-- Dropping timestamp from Dates
ALTER TABLE Victoria MODIFY COLUMN SoldDate DATE, MODIFY COLUMN ListDate DATE;

-- Checking results
SELECT * FROM Victoria;

-- Total sales by year, from highest to lowest
SELECT YEAR(SoldDate) "Year", SUM(SoldPrice) Volume FROM Victoria GROUP BY YEAR(SoldDate) ORDER BY Volume DESC;
-- Running totals of sales for all active sales years
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2017;
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2018;
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2019;
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2020;
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2021;
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2022;
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2023;
SELECT SoldDate, SoldPrice, SUM(SoldPrice) OVER(ORDER BY SoldDate, Agency) AS RunningTotal FROM Victoria WHERE YEAR(SoldDate) = 2025;

-- Total Sales for each city
SELECT City, SUM(soldprice) Volume FROM Victoria GROUP BY City ORDER BY Volume DESC;
-- Total Sales for each city by active sales year
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2017 GROUP BY City ORDER BY Volume DESC;
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2018 GROUP BY City ORDER BY Volume DESC;
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2019 GROUP BY City ORDER BY Volume DESC;
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2020 GROUP BY City ORDER BY Volume DESC;
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2021 GROUP BY City ORDER BY Volume DESC;
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2022 GROUP BY City ORDER BY Volume DESC;
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2023 GROUP BY City ORDER BY Volume DESC;
SELECT City, SUM(soldprice) Volume FROM Victoria WHERE YEAR(SoldDate) = 2025 GROUP BY City ORDER BY Volume DESC;

-- Stats by Year
SELECT YEAR(SoldDate) "Year", Agency, SUM(SoldPrice) Volume, SUM(Units) Units, ROUND(AVG(SoldPrice), 0) "Average Transaction" FROM Victoria GROUP By YEAR(SoldDate), Agency ORDER BY Year(SoldDate);

-- Total Stats
SELECT SUM(SoldPrice) Volume, SUM(Units) Units, ROUND(AVG(SoldPrice), 0) AS "Avg Transaction", ROUND(AVG(DOM), 0) as "Avg DOM" FROM Victoria;

-- Total Stats by Agency
SELECT Agency, SUM(SoldPrice) Volume, SUM(Units) Units, ROUND(AVG(SoldPrice), 0) AS "Avg Transaction", ROUND(AVG(DOM), 0) as "Avg DOM" FROM Victoria GROUP BY Agency ORDER BY Volume DESC;
