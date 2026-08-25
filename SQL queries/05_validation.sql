SELECT 'offices' AS table_name, COUNT(*) AS row_count FROM dbo.offices
UNION ALL
SELECT 'staging_offices' AS table_name, COUNT(*) AS row_count FROM dbo.stg_offices
UNION ALL
SELECT 'employees', COUNT(*) FROM dbo.employees
UNION ALL
SELECT 'staging_employees', COUNT(*) FROM dbo.stg_employees
UNION ALL
SELECT 'customers', COUNT(*) FROM dbo.customers
UNION ALL
SELECT 'staging_customers', COUNT(*) FROM dbo.stg_customers
UNION ALL
SELECT 'productlines', COUNT(*) FROM dbo.productlines
UNION ALL
SELECT 'staging_productlines', COUNT(*) FROM dbo.stg_productlines
UNION ALL
SELECT 'products', COUNT(*) FROM dbo.products
UNION ALL
SELECT 'staging_products', COUNT(*) FROM dbo.stg_products
UNION ALL
SELECT 'orders', COUNT(*) FROM dbo.orders
UNION ALL
SELECT 'staging_orders', COUNT(*) FROM dbo.stg_orders
UNION ALL
SELECT 'orderdetails', COUNT(*) FROM dbo.orderdetails
UNION ALL
SELECT 'staging_orderdetails', COUNT(*) FROM dbo.stg_orderdetails
UNION ALL
SELECT 'payments', COUNT(*) FROM dbo.payments
UNION ALL
SELECT 'staging_payments', COUNT(*) FROM dbo.stg_payments;