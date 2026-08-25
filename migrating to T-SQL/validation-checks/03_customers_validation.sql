USE ClassicModelsDB;
GO
-- Importing Customers through SSIS there are 122 rows
-- Top 20 and Count
SELECT COUNT(*) AS customer_rows
FROM dbo.stg_customers;

SELECT TOP 20 * FROM dbo.stg_customers
ORDER BY customerName;
-- Duplicate check
SELECT customerNumber, COUNT(*) AS record_count
FROM dbo.stg_customers
GROUP BY customerNumber HAVING COUNT(*) > 1;

-- Identify any 'NULLS' to convert to SQL NULLS
SELECT * FROM dbo.stg_customers
WHERE addressLine2 = 'NULL'
OR state = 'NULL'
or postalCode = 'NULL'
OR salesRepEmployeeNumber = 'NULL';
-- Converting 'NULL' into genuine SQL NULL values
UPDATE dbo.stg_customers SET
addressLine2 = NULLIF(addressLine2, 'NULL'),
state = NULLIF(state, 'NULL'),
postalCode = NULLIF(postalCode, 'NULL'),
salesRepEmployeeNumber = NULLIF(salesRepEmployeeNumber, 'NULL');
-- NULL validation checks and converting Employee ID into Integer
SELECT salesRepEmployeeNumber FROM dbo.stg_customers
WHERE salesRepEmployeeNumber IS NOT NULL
AND TRY_CONVERT(INT, salesRepEmployeeNumber) IS NOT NULL;
-- Validating relationship to employees
SELECT c.customerNumber, c.customerName, c.salesRepEmployeeNumber
FROM dbo.stg_customers c
LEFT JOIN dbo.stg_employees e ON TRY_CONVERT(INT, c.salesRepEmployeeNumber) = e.employeeNumber
WHERE c.salesRepEmployeeNumber IS NOT NULL
AND e.employeeNumber IS NULL;
-- Compact validation 
SELECT COUNT(*) AS total_customers,
COUNT(DISTINCT customerNumber) AS unique_customers,
SUM(CASE WHEN customerNumber IS NULL THEN 1 ELSE 0 END) AS missing_customer_numbers,
SUM(CASE WHEN salesRepEmployeeNumber IS NULL THEN 0 END) AS customers_without_sales_rep
FROM dbo.stg_customers;