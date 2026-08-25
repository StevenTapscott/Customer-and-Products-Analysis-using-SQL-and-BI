USE ClassicModelsDB;
GO
--- Impoerted Product Lines through SSIS
--- Row Count
SELECT COUNT(*) AS productlines_rows
FROM dbo.stg_productlines;
-- Inspect imported data
SELECT * FROM dbo.stg_productlines
ORDER BY productLine;
--- Checking for duplicates
SELECT productLine, COUNT(*) AS record_count
FROM dbo.stg_productlines
GROUP BY productLine
HAVING COUNT(*) > 1;
--- Checking for missing productLine Keys
SELECT COUNT(*) AS missing_prouduct_lines
FROM dbo.stg_productlines
WHERE productLine IS NULL;
--- Check literal NULL placeholders
SELECT * FROM dbo.stg_productlines
WHERE textDescription = 'NULL'
OR htmlDescription = 'NULL'
OR image = 'NULL';
--- Converting into SQL NULLS
UPDATE dbo.stg_productlines SET
textDescription = NULLIF(textDescription, 'NULL'),
htmlDescription = NULLIF(htmlDescription, 'NULL'),
image = NULLIF(image, 'NULL');
--- Validation (no 'null''s exist)
SELECT *
FROM dbo.stg_productlines
WHERE textDescription = 'NULL'
   OR htmlDescription = 'NULL'
   OR image = 'NULL';
--- Checking for Genuine NULLS
SELECT * FROM dbo.stg_productlines
WHERE textDescription IS NULL
OR htmlDescription IS NULL
OR image IS NULL;
--- Final check
SELECT
    COUNT(*) AS total_product_lines,
    COUNT(DISTINCT productLine) AS unique_product_lines,
    SUM(CASE WHEN productLine IS NULL THEN 1 ELSE 0 END) AS missing_product_line_keys
FROM dbo.stg_productlines;
--- Validating the relationship with Products 
SELECT
    p.productCode,
    p.productName,
    p.productLine
FROM dbo.stg_products p
LEFT JOIN dbo.stg_productlines pl
    ON p.productLine = pl.productLine
WHERE pl.productLine IS NULL;
--- Summary Checks
SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT productLine) AS distinct_product_lines
FROM dbo.stg_products;
--- Comparing Summary Check with this
SELECT COUNT(*) AS total_product_lines
FROM dbo.stg_productlines;
--- Checking for NULL Prooduct line values
SELECT COUNT(*) AS missing_product_line
FROM dbo.stg_products
WHERE productLine IS NULL;