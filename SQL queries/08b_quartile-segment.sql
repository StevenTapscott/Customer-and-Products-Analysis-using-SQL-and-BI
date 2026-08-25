USE ClassicModelsDB;
GO
--- Customer Segmentation analysis with NTILE()
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
),
CustomerRanking AS(
SELECT *, NTILE(4) OVER(ORDER BY total_revenue DESC) AS revenue_quartile
FROM CustomerPurchaseHistory
WHERE total_revenue IS NOT NULL
)
SELECT
customerNumber,
customerName,
country,
city,
total_orders,
total_units_purchased,
total_revenue,
CAST(total_revenue/NULLIF(total_orders, 0) AS DECIMAL (10,2)) AS average_order_value,
first_order_date,
last_order_date,
revenue_quartile,
CASE 
WHEN revenue_quartile = 1 THEN 'High Value'
WHEN revenue_quartile = 2 THEN 'Upper Mid Value'
WHEN revenue_quartile = 3 THEN 'Lower Mid Value'
WHEN revenue_quartile = 4 THEN 'Low Value'
END AS customer_segment,
CASE
WHEN total_orders >= 5 THEN 'Frequent Buyer'
WHEN total_orders >= 3 THEN 'Repeat Buyer'
ELSE 'Occasional Buyer'
END AS purchase_frequency

FROM CustomerRanking
ORDER BY total_revenue DESC;