USE ClassicModelsDB;
GO
--- Geographic segmentation
WITH CustomerSales AS(
SELECT
c.customerNumber,
c.country,
COUNT(DISTINCT o.orderNumber) AS total_orders,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM dbo.customers c
LEFT JOIN dbo.orders o ON c.customerNumber = o.customerNumber
LEFT JOIN dbo.orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY 
c.customerNumber,
c.country
)
SELECT
country,
COUNT(customerNumber) AS number_of_customers,
SUM(total_orders) AS total_orders,
SUM(total_revenue) AS total_revenue,
CAST(SUM(total_revenue)/NULLIF(COUNT(customerNumber),0)
AS DECIMAL(12,2)) AS average_revenue_per_customer

FROM CustomerSales
WHERE total_revenue IS NOT NULL
GROUP BY country
ORDER BY total_revenue DESC;