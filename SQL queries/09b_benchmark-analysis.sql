USE ClassicModelsDB;
GO

-- Customer Lifetime Value Portfolio level benchmarks

WITH CustomerValue AS (
SELECT
c.customerNumber,
SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS lifetime_gross_profit

FROM dbo.customers c
INNER JOIN dbo.orders o ON c.customerNumber = o.customerNumber
INNER JOIN dbo.orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN dbo.products p ON od.productCode = p.productCode
GROUP BY
c.customerNumber
),

AverageCustomerValue AS (
SELECT AVG(lifetime_gross_profit) AS avg_lifetime_gross_profit
FROM CustomerValue
)

SELECT
CAST(avg_lifetime_gross_profit AS DECIMAL(10,2)) AS avg_lifetime_gross_profit,
CAST(avg_lifetime_gross_profit * 0.10 AS DECIMAL(12,2)) AS acquistion_budget_10pc,
CAST(avg_lifetime_gross_profit * 0.20 AS DECIMAL(12,2)) AS acquistion_budget_20pc,
CAST(avg_lifetime_gross_profit * 0.30 AS DECIMAL(12,2)) AS acquistion_budget_0pc

FROM AverageCustomerValue;

