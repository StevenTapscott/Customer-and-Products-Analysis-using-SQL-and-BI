USE ClassicModelsDB;
GO
--- Imported Order Details through SSIS
--- Row count
SELECT COUNT(*) AS orderdetail_rows
FROM dbo.stg_orderdetails;
--- Checking for any NULLS on key components (no NULLS identified)
SELECT *
FROM dbo.stg_orderdetails
WHERE orderNumber IS NULL
   OR productCode IS NULL;
-- Checking for Duplicate rows (no duplicates)
SELECT
    orderNumber,
    productCode,
    COUNT(*) AS record_count
FROM dbo.stg_orderdetails
GROUP BY orderNumber, productCode
HAVING COUNT(*) > 1;
-- Checking for invalid numeric values (no NULLS identified)
SELECT *
FROM dbo.stg_orderdetails
WHERE quantityOrdered IS NULL
   OR priceEach IS NULL
   OR orderLineNumber IS NULL;
-- Valating relationship to Orders
SELECT
    od.orderNumber,
    od.productCode
FROM dbo.stg_orderdetails od
LEFT JOIN dbo.stg_orders o
    ON od.orderNumber = o.orderNumber
WHERE o.orderNumber IS NULL;
--- Validating relationship to Products
SELECT
    od.orderNumber,
    od.productCode
FROM dbo.stg_orderdetails od
LEFT JOIN dbo.stg_products p
    ON od.productCode = p.productCode
WHERE p.productCode IS NULL;