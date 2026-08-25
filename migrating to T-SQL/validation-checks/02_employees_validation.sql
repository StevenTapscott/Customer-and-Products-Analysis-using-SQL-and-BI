USE ClassicModelsDB;
GO
-- I imported Employees through SSIS
-- Row count
SELECT COUNT(*) AS employees_rows
FROM dbo.stg_employees;
-- Ordering by Employee number
SELECT * FROM dbo.stg_employees
ORDER BY employeeNumber;
-- Checking Duplicate numbers
SELECT employeeNumber, COUNT(*) AS record_count
FROM dbo.stg_employees
GROUP BY employeeNumber
HAVING COUNT(*) > 1;
-- Checking for 'NULLS' - One value confirmed
SELECT * FROM dbo.stg_employees
WHERE reportsTo = 'NULL';
-- Converting to SQL NULL
UPDATE dbo.stg_employees
SET reportsTo = NULLIF(reportsTo, 'NULL');
-- Validation of office reference
SELECT e.employeeNumber, e.officeCode
FROM dbo.stg_employees e
LEFT JOIN dbo.stg_offices o ON e.officeCode = o.officeCode
WHERE o.officeCode IS NULL;
-- Checking whether non-null reportsTo can convert to Integer
SELECT reportsTo FROM dbo.stg_employees
WHERE reportsTo IS NOT NULL AND TRY_CONVERT(INT, reportsTo) IS NULL;