USE ClassicModelsDB;
GO
-- I imported Offices first through SSIS
-- Row count
SELECT COUNT(*) AS office_rows
FROM dbo.stg_offices;

-- Cleaning 'NULLS' into Actual SQL style NULLS due to csv import
UPDATE dbo.stg_offices
SET
    addressLine2 = NULLIF(addressLine2, 'NULL'),
    state        = NULLIF(state, 'NULL'),
    postalCode   = NULLIF(postalCode, 'NULL'),
    territory    = NULLIF(territory, 'NULL');

-- Actual SQL NULL values
SELECT * FROM dbo.stg_offices
WHERE addressLine2 IS NULL
	OR state is NULL
	OR postalCode IS NULL
	OR territory IS NULL;

-- Literal text values contatining the work 'NULL'
SELECT * FROM dbo.stg_offices
WHERE addressLine2 = 'NULL'
	OR state = 'NULL'
	OR postalCode = 'NULL'
	OR territory  = 'NULL';

-- Final validation
SELECT COUNT(*) AS total_rows,
COUNT(DISTINCT officeCode) AS unique_offices,
SUM(CASE WHEN officeCode IS NULL THEN 1 ELSE 0 END)
AS missing_office_codes
FROM dbo.stg_offices;