USE ClassicModelsDB;
GO
--- Imported Products through SSIS
--- Checking for Rows
SELECT COUNT(*) AS product_rows
FROM dbo.stg_products;
--- Top 20
SELECT TOP 20 *
FROM dbo.stg_products
ORDER BY productCode;
--- Checking Duplicate product codes
SELECT
    productCode,
    COUNT(*) AS record_count
FROM dbo.stg_products
GROUP BY productCode
HAVING COUNT(*) > 1;
--- Missing product codes
SELECT COUNT(*) AS missing_product_codes
FROM dbo.stg_products
WHERE productCode IS NULL;
--- Checking for 'NULL'
SELECT *
FROM dbo.stg_products
WHERE productCode = 'NULL'
   OR productName = 'NULL'
   OR productLine = 'NULL'
   OR productScale = 'NULL'
   OR productVendor = 'NULL';
--- Checking for SQL NULLS
SELECT *
FROM dbo.stg_products
WHERE productCode IS NULL
   OR productName IS NULL
   OR productLine IS NULL
   OR productScale IS NULL
   OR productVendor IS NULL
   OR quantityInStock IS NULL
   OR buyPrice IS NULL
   OR MSRP IS NULL;
--- NULL Profiling
SELECT
    SUM(CASE WHEN productCode IS NULL THEN 1 ELSE 0 END) AS null_productCode,
    SUM(CASE WHEN productName IS NULL THEN 1 ELSE 0 END) AS null_productName,
    SUM(CASE WHEN productLine IS NULL THEN 1 ELSE 0 END) AS null_productLine,
    SUM(CASE WHEN productScale IS NULL THEN 1 ELSE 0 END) AS null_productScale,
    SUM(CASE WHEN productVendor IS NULL THEN 1 ELSE 0 END) AS null_productVendor,
    SUM(CASE WHEN quantityInStock IS NULL THEN 1 ELSE 0 END) AS null_quantityInStock,
    SUM(CASE WHEN buyPrice IS NULL THEN 1 ELSE 0 END) AS null_buyPrice,
    SUM(CASE WHEN MSRP IS NULL THEN 1 ELSE 0 END) AS null_MSRP
FROM dbo.stg_products;
--- Validating relationship with Product Lines - 0 rows
SELECT
    p.productCode,
    p.productName,
    p.productLine
FROM dbo.stg_products p
LEFT JOIN dbo.stg_productlines pl
    ON p.productLine = pl.productLine
WHERE pl.productLine IS NULL;