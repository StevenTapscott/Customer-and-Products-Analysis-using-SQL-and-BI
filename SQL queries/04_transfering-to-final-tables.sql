--- Migrating the stg tables into the final tables
-- Office
INSERT INTO dbo.offices (
    officeCode,
    city,
    phone,
    addressLine1,
    addressLine2,
    state,
    country,
    postalCode,
    territory
)
SELECT
    officeCode,
    city,
    phone,
    addressLine1,
    addressLine2,
    state,
    country,
    postalCode,
    territory
FROM dbo.stg_offices;

-- Employees
INSERT INTO dbo.employees (
    employeeNumber,
    lastName,
    firstName,
    extension,
    email,
    officeCode,
    reportsTo,
    jobTitle
)
SELECT
    employeeNumber,
    lastName,
    firstName,
    extension,
    email,
    officeCode,
    TRY_CONVERT(INT, reportsTo),
    jobTitle
FROM dbo.stg_employees;

-- Customers
INSERT INTO dbo.customers (
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    salesRepEmployeeNumber,
    creditLimit
)
SELECT
    customerNumber,
    customerName,
    contactLastName,
    contactFirstName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    TRY_CONVERT(INT, salesRepEmployeeNumber),
    creditLimit
FROM dbo.stg_customers;

-- Product Lines
INSERT INTO dbo.productlines (
    productLine,
    textDescription,
    htmlDescription,
    image
)
SELECT
    productLine,
    textDescription,
    htmlDescription,
    image
FROM dbo.stg_productlines;

-- Products
INSERT INTO dbo.products (
    productCode,
    productName,
    productLine,
    productScale,
    productVendor,
    quantityInStock,
    buyPrice,
    MSRP
)
SELECT
    productCode,
    productName,
    productLine,
    productScale,
    productVendor,
    quantityInStock,
    buyPrice,
    MSRP
FROM dbo.stg_products;
);

-- Orders
INSERT INTO dbo.orders (
    orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    comments,
    customerNumber
)
SELECT
    orderNumber,
    TRY_CONVERT(DATE, orderDate),
    TRY_CONVERT(DATE, requiredDate),
    TRY_CONVERT(DATE, shippedDate),
    status,
    comments,
    customerNumber
FROM dbo.stg_orders;

--Order Details
INSERT INTO dbo.orderdetails (
    orderNumber,
    productCode,
    quantityOrdered,
    priceEach,
    orderLineNumber
)
SELECT
    orderNumber,
    productCode,
    quantityOrdered,
    priceEach,
    orderLineNumber
FROM dbo.stg_orderdetails;

-- Payments
INSERT INTO dbo.payments (
    customerNumber,
    checkNumber,
    paymentDate,
    amount
)
SELECT
    customerNumber,
    checkNumber,
    TRY_CONVERT(DATE, paymentDate),
    amount
FROM dbo.stg_payments;
