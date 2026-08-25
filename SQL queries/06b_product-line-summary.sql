--- Product Line Summary
USE ClassicModelsDB;
GO

SELECT 
p.productLine,
COUNT(DISTINCT p.productCode) AS number_of_products,
COUNT(DISTINCT o.orderNumber) AS total_orders,
SUM(od.quantityOrdered) AS total_units_sold,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS estimated_gross_profit
FROM dbo.orders o 
INNER JOIN dbo.orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN dbo.products p ON od.productCode = p.productCode
GROUP BY
p.productLine
ORDER BY total_revenue DESC;