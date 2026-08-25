USE ClassicModelsDB;
GO
--- Customer Segmentation analysis
WITH CustomerPurchaseHistory AS (
SELECT 
c.customerNumber,
c.customerName,
c.country,
c.city,
COUNT(DISTINCT o.orderNumber) AS total_orders,
SUM(od.quantityOrdered) AS total_units_purchased,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
MIN(o.orderDate) AS first_order_date,
MAX(o.orderDate) AS last_order_date
FROM dbo.customers c
LEFT JOIN dbo.orders o ON c.customerNumber = o.customerNumber
LEFT JOIN dbo.orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
c.customerNumber,
c.customerName,
c.country,
c.city
)
SELECT
customerNumber,
customerName,
country,
city,
total_orders,
total_units_purchased,
total_revenue,
first_order_date,
last_order_date,

CAST(total_revenue/NULLIF(total_orders, 0) AS DECIMAL (10,2)) AS average_order_value

FROM CustomerPurchaseHistory
ORDER BY total_revenue DESC;