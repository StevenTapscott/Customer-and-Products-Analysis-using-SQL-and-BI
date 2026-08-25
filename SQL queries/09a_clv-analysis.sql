USE ClassicModelsDB;
GO

-- Customer Lifetime Value Analysis

WITH CustomerLifetimeValue AS (
SELECT
c.customerNumber,
c.customerName,
c.country,
c.city,

COUNT(DISTINCT o.orderNumber) AS total_orders,
SUM(od.quantityOrdered) AS total_units_purchased,
SUM(od.quantityOrdered * od.priceEach) AS lifetime_revenue,
SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS estimated_lifetime_gross_profit,
MIN(o.orderDate) AS first_order_date,
MAX(o.orderDate) AS last_order_date
FROM dbo.customers c
INNER JOIN dbo.orders o ON c.customerNumber = o.customerNumber
INNER JOIN dbo.orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN dbo.products p ON od.productCode = p.productCode
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
lifetime_revenue,
estimated_lifetime_gross_profit,
CAST((estimated_lifetime_gross_profit*100.0)/NULLIF(lifetime_revenue, 0) AS DECIMAL(10,2)) AS gross_margin_pct,
CAST(lifetime_revenue / NULLIF(total_orders, 0) AS DECIMAL(12,2)) AS average_order_value,
first_order_date,
last_order_date,
DATEDIFF(DAY,
first_order_date,
last_order_date
) AS customer_lifespan_days

FROM CustomerLifetimeValue

ORDER BY lifetime_revenue DESC;