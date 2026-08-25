USE ClassicModelsDB;
GO
--- Creating the final production tables in order:
-- 1. offices
-- 2. employees
-- 3. customers
-- 4. productlines
-- 5. products
-- 6. orders
-- 7. orderdetails
-- 8. payments

--Offices
CREATE TABLE dbo.offices (
    officeCode INT NOT NULL,
    city NVARCHAR(50) NOT NULL,
    phone NVARCHAR(50) NOT NULL,
    addressLine1 NVARCHAR(100) NOT NULL,
    addressLine2 NVARCHAR(100) NULL,
    state NVARCHAR(50) NULL,
    country NVARCHAR(50) NOT NULL,
    postalCode NVARCHAR(20) NULL,
    territory NVARCHAR(20) NULL,

    CONSTRAINT PK_offices
        PRIMARY KEY (officeCode)
);
-- Employees
CREATE TABLE dbo.employees (
    employeeNumber INT NOT NULL,
    lastName NVARCHAR(50) NOT NULL,
    firstName NVARCHAR(50) NOT NULL,
    extension NVARCHAR(20) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    officeCode INT NOT NULL,
    reportsTo INT NULL,
    jobTitle NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_employees
        PRIMARY KEY (employeeNumber),

    CONSTRAINT FK_employees_offices
        FOREIGN KEY (officeCode)
        REFERENCES dbo.offices(officeCode),

    CONSTRAINT FK_employees_manager
        FOREIGN KEY (reportsTo)
        REFERENCES dbo.employees(employeeNumber)
);
-- Customers
CREATE TABLE dbo.customers (
    customerNumber INT NOT NULL,
    customerName NVARCHAR(150) NOT NULL,
    contactLastName NVARCHAR(100) NOT NULL,
    contactFirstName NVARCHAR(100) NOT NULL,
    phone NVARCHAR(50) NOT NULL,
    addressLine1 NVARCHAR(150) NOT NULL,
    addressLine2 NVARCHAR(150) NULL,
    city NVARCHAR(100) NOT NULL,
    state NVARCHAR(100) NULL,
    postalCode NVARCHAR(30) NULL,
    country NVARCHAR(100) NOT NULL,
    salesRepEmployeeNumber INT NULL,
    creditLimit DECIMAL(12,2) NULL,

    CONSTRAINT PK_customers
        PRIMARY KEY (customerNumber),

    CONSTRAINT FK_customers_employees
        FOREIGN KEY (salesRepEmployeeNumber)
        REFERENCES dbo.employees(employeeNumber)
);
-- Product Lines
CREATE TABLE dbo.productlines (
    productLine NVARCHAR(100) NOT NULL,
    textDescription NVARCHAR(MAX) NULL,
    htmlDescription NVARCHAR(MAX) NULL,
    image NVARCHAR(MAX) NULL,

    CONSTRAINT PK_productlines
        PRIMARY KEY (productLine)
);

CREATE TABLE dbo.products (
    productCode NVARCHAR(50) NOT NULL,
    productName NVARCHAR(150) NOT NULL,
    productLine NVARCHAR(100) NOT NULL,
    productScale NVARCHAR(30) NOT NULL,
    productVendor NVARCHAR(150) NOT NULL,
    quantityInStock INT NOT NULL,
    buyPrice DECIMAL(10,2) NOT NULL,
    MSRP DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_products
        PRIMARY KEY (productCode),

    CONSTRAINT FK_products_productlines
        FOREIGN KEY (productLine)
        REFERENCES dbo.productlines(productLine)
);
-- Orders
CREATE TABLE dbo.orders (
    orderNumber INT NOT NULL,
    orderDate DATE NOT NULL,
    requiredDate DATE NOT NULL,
    shippedDate DATE NULL,
    status NVARCHAR(50) NOT NULL,
    comments NVARCHAR(MAX) NULL,
    customerNumber INT NOT NULL,

    CONSTRAINT PK_orders
        PRIMARY KEY (orderNumber),

    CONSTRAINT FK_orders_customers
        FOREIGN KEY (customerNumber)
        REFERENCES dbo.customers(customerNumber)
);
-- Order Details
CREATE TABLE dbo.orderdetails (
    orderNumber INT NOT NULL,
    productCode NVARCHAR(50) NOT NULL,
    quantityOrdered INT NOT NULL,
    priceEach DECIMAL(10,2) NOT NULL,
    orderLineNumber INT NOT NULL,

    CONSTRAINT PK_orderdetails
        PRIMARY KEY (orderNumber, productCode),

    CONSTRAINT FK_orderdetails_orders
        FOREIGN KEY (orderNumber)
        REFERENCES dbo.orders(orderNumber),

    CONSTRAINT FK_orderdetails_products
        FOREIGN KEY (productCode)
        REFERENCES dbo.products(productCode)
);
-- Payments
CREATE TABLE dbo.payments (
    customerNumber INT NOT NULL,
    checkNumber NVARCHAR(50) NOT NULL,
    paymentDate DATE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,

    CONSTRAINT PK_payments
        PRIMARY KEY (customerNumber, checkNumber),

    CONSTRAINT FK_payments_customers
        FOREIGN KEY (customerNumber)
        REFERENCES dbo.customers(customerNumber)
);