--- Finding top-selling products
USE ClassicModelsDB;
GO

SELECT 
p.productCode,
p.productName,
p.productLine,
SUM(od.quantityOrdered) AS total_units_sold,
COUNT(DISTINCT od.orderNumber) AS total_orders,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
p.quantityInStock
FROM dbo.products p
INNER JOIN dbo.orderdetails od
ON p.productCode = od.productCode
GROUP BY
p.productCode,
p.productName,
p.productLine,
p.quantityInStock
ORDER BY total_units_sold DESC;


--- Identifying the lowest-inventory products
SELECT 
p.productCode,
p.productName,
p.productLine,
p.quantityInStock
FROM dbo.products p
ORDER BY quantityInStock ASC;
