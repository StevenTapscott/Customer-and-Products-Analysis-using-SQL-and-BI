USE ClassicModelsDB;
GO

CREATE TABLE stg_offices (
	officeCode INT NULL,
	city NVARCHAR(100) NULL,
	phone NVARCHAR(50) NULL,
	addressLine1 NVARCHAR(150) NULL,
	addressLine2 NVARCHAR(150) NULL,
	state NVARCHAR(100) NULL,
	country NVARCHAR(100) NULL,
	postalCode NVARCHAR(30) NULL,
	territory NVARCHAR(50) NULL
);

CREATE TABLE stg_employees (
	employeeNumber INT NULL,
	lastName NVARCHAR(100) NULL,
	firstName NVARCHAR(100) NULL,
	extension NVARCHAR(30) NULL,
	email NVARCHAR(150) NULL,
	officeCode INT NULL,
	reportsTo NVARCHAR(50)NULL,
	jobTitle NVARCHAR(100) NULL
);

CREATE TABLE stg_customers (
	customerNumber INT NULL,
	customerName NVARCHAR(150) NULL,
	 contactLastName NVARCHAR(100) NULL,
    contactFirstName NVARCHAR(100) NULL,
    phone NVARCHAR(50) NULL,
    addressLine1 NVARCHAR(150) NULL,
    addressLine2 NVARCHAR(150) NULL,
    city NVARCHAR(100) NULL,
    state NVARCHAR(100) NULL,
    postalCode NVARCHAR(30) NULL,
    country NVARCHAR(100) NULL,
    salesRepEmployeeNumber NVARCHAR(50) NULL,
    creditLimit DECIMAL(12,2) NULL
);

CREATE TABLE stg_productlines (
    productLine NVARCHAR(100) NULL,
    textDescription NVARCHAR(MAX) NULL,
    htmlDescription NVARCHAR(MAX) NULL,
    image NVARCHAR(MAX) NULL
);

CREATE TABLE stg_products (
    productCode NVARCHAR(50) NULL,
    productName NVARCHAR(150) NULL,
    productLine NVARCHAR(100) NULL,
    productScale NVARCHAR(30) NULL,
    productVendor NVARCHAR(150) NULL,
    quantityInStock INT NULL,
    buyPrice DECIMAL(10,2) NULL,
    MSRP DECIMAL(10,2) NULL
);

CREATE TABLE stg_orders (
    orderNumber INT NULL,
    orderDate NVARCHAR(50) NULL,
    requiredDate NVARCHAR(50) NULL,
    shippedDate NVARCHAR(50) NULL,
    status NVARCHAR(50) NULL,
    comments NVARCHAR(MAX) NULL,
    customerNumber INT NULL
);

CREATE TABLE stg_orderdetails (
    orderNumber INT NULL,
    productCode NVARCHAR(50) NULL,
    quantityOrdered INT NULL,
    priceEach DECIMAL(10,2) NULL,
    orderLineNumber INT NULL
);

CREATE TABLE stg_payments (
    customerNumber INT NULL,
    checkNumber NVARCHAR(50) NULL,
    paymentDate NVARCHAR(50) NULL,
    amount DECIMAL(12,2) NULL
);