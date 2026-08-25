USE ClassicModelsDB;
GO
--- Imported Payments through SSIS
--- Row count
SELECT COUNT(*) AS payment_rows
FROM dbo.stg_payments;
--- Top 20
SELECT TOP 20 *
FROM dbo.stg_payments
ORDER BY customerNumber, paymentDate;
--- Checking for dupicates on Composite Keys (no duplicates found)
SELECT
    customerNumber,
    checkNumber,
    COUNT(*) AS record_count
FROM dbo.stg_payments
GROUP BY customerNumber, checkNumber
HAVING COUNT(*) > 1;
--- Checking for missing fields (No NULLS identified)
SELECT *
FROM dbo.stg_payments
WHERE customerNumber IS NULL
   OR checkNumber IS NULL
   OR paymentDate IS NULL
   OR amount IS NULL;
--- Checking to see if date values can be converted
SELECT
    customerNumber,
    checkNumber,
    paymentDate
FROM dbo.stg_payments
WHERE TRY_CONVERT(DATE, paymentDate) IS NULL;
--- Validating customer relationship
SELECT
    p.customerNumber,
    p.checkNumber
FROM dbo.stg_payments p
LEFT JOIN dbo.stg_customers c
    ON p.customerNumber = c.customerNumber
WHERE c.customerNumber IS NULL;
--- Checking the amount field
SELECT *
FROM dbo.stg_payments
WHERE amount IS NULL
   OR amount < 0;