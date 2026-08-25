--- Product Sales Analysis
USE ClassicModelsDB;
GO

SELECT 
p.productCode,
p.productName,
p.productLine,
COUNT(DISTINCT o.orderNumber) AS total_orders,
SUM(od.quantityOrdered) AS total_units_sold,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS estimated_gross_profit,
AVG(od.priceEach) AS average_selling_price,
p.buyPrice,
p.MSRP
FROM dbo.orders o
INNER JOIN dbo.orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN dbo.products p ON od.productCode = p.productCode
INNER JOIN dbo.productlines pl ON p.productLine = pl.productLine
GROUP BY
p.productCode,
p.productName,
p.productLine,
p.buyPrice,
p.MSRP
ORDER BY total_revenue DESC;