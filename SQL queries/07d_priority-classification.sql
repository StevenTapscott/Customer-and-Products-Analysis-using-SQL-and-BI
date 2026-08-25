--- Adding priority classification
USE ClassicModelsDB;
GO

WITH ProductPerformance AS (
SELECT 
p.productCode,
p.productName,
p.productLine,
p.quantityInStock,
SUM(od.quantityOrdered) AS total_units_sold,
COUNT(DISTINCT od.orderNumber) AS total_orders,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS estimated_gross_profit
FROM dbo.products p
INNER JOIN dbo.orderdetails od
ON p.productCode = od.productCode
GROUP BY
p.productCode,
p.productName,
p.productLine,
p.quantityInStock
),
InventoryAnalysis AS (
SELECT *, CAST (
total_units_sold * 1.0/NULLIF(quantityInStock, 0) AS DECIMAL (10,2)
) AS sales_to_stock_ratio
FROM ProductPerformance
),
ProductRanking AS (
SELECT *, 
DENSE_RANK() OVER(
ORDER BY sales_to_stock_ratio DESC)
AS replenishment_rank
FROM InventoryAnalysis
)
SELECT
productCode,
productName,
productLine,
quantityInStock,
total_units_sold,
total_orders,
total_revenue,
estimated_gross_profit,
sales_to_stock_ratio,
CASE
WHEN replenishment_rank <=10 THEN 'High Priority'
WHEN replenishment_rank <= 25 THEN 'Medium Priority'
ELSE 'Low Priority'
END AS replenishment_priority
FROM ProductRanking
ORDER BY replenishment_rank;