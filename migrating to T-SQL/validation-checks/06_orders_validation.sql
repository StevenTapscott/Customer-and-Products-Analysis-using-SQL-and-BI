USE ClassicModelsDB;
GO
--- Impoerted Orders through SSIS
--- Row count
SELECT COUNT(*) AS order_rows
FROM dbo.stg_orders;
--- Top 20
SELECT TOP 20 *
FROM dbo.stg_orders
ORDER BY orderNumber;
--- Checking for duplicate order numbers - no duplicates
SELECT
    orderNumber,
    COUNT(*) AS record_count
FROM dbo.stg_orders
GROUP BY orderNumber
HAVING COUNT(*) > 1;
---Checking for missing Order Numbers
SELECT COUNT(*) AS missing_order_numbers
FROM dbo.stg_orders
WHERE orderNumber IS NULL;
--- Checking for 'NULL' Strings
SELECT *
FROM dbo.stg_orders
WHERE orderDate = 'NULL'
   OR requiredDate = 'NULL'
   OR shippedDate = 'NULL'
   OR status = 'NULL'
   OR comments = 'NULL';
--- Converting 'NULL' strings into SQL NULLS
UPDATE dbo.stg_orders
SET
    shippedDate = NULLIF(shippedDate, 'NULL'),
    comments    = NULLIF(comments, 'NULL');
--- Validating and trying to convert date-like values
SELECT orderNumber, orderDate
FROM dbo.stg_orders
WHERE TRY_CONVERT(DATE, orderDate) IS NULL;
---
SELECT orderNumber, requiredDate
FROM dbo.stg_orders
WHERE TRY_CONVERT(DATE, requiredDate) IS NULL;
---
SELECT orderNumber, shippedDate
FROM dbo.stg_orders
WHERE shippedDate IS NOT NULL
  AND TRY_CONVERT(DATE, shippedDate) IS NULL;
--- Validating the relationship to Customers
SELECT
    o.orderNumber,
    o.customerNumber
FROM dbo.stg_orders o
LEFT JOIN dbo.stg_customers c
    ON o.customerNumber = c.customerNumber
WHERE c.customerNumber IS NULL;