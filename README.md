# Customers and Products Analysis Using SQL and Power BI

## Project Overview

This project analyses customer purchasing behaviour, product performance, inventory demand, geographic markets, customer segmentation, and customer lifetime value using SQL and Power BI.

The project was developed from the Classic Models relational database and extends the original SQL analysis into a multi-page Power BI business intelligence solution.

The objective was to transform transactional customer, order, product, and inventory data into decision-ready insights that could support:

- product portfolio management;
- inventory and replenishment decisions;
- customer targeting and segmentation;
- geographic marketing analysis;
- customer profitability analysis; and
- customer acquisition investment decisions.

The project combines relational data analysis, SQL querying, data modelling, DAX measures, business intelligence dashboard development, validation, and interpretation of analytical results.

---

## Business Objectives

The analysis was designed around several business questions:

1. Which products and product lines generate the strongest sales performance?
2. How does historical product demand compare with current inventory?
3. Which products may require replenishment attention?
4. How can customers be segmented using purchase history and purchasing behaviour?
5. Which customers and geographic markets generate the greatest value?
6. What is the historical lifetime profitability of customers?
7. How could customer lifetime value be used to establish indicative customer acquisition investment scenarios?

---

## Tools and Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Power BI Desktop
- Power Query
- DAX
- Relational data modelling
- Data visualisation
- Business intelligence reporting

---

## Data Model

The analysis uses relational tables covering customers, orders, order details, products, and related business information.

For customer and sales analysis, the primary relationship structure is:

```text
Customers
    1
    |
    *
Orders
    1
    |
    *
Order Details
```

For product profitability and inventory analysis, product information is connected to the transactional order-detail data:

```text
Products
    1
    |
    *
Order Details
```

The combined analytical structure can therefore be represented as:

```text
Customers
    1
    |
    *
Orders
    1
    |
    *
Order Details
    *
    |
    1
Products
```

This structure allows customer, order, sales, product, inventory, and profitability metrics to be analysed within a consistent relational model.

---

## SQL Analysis

SQL was used to explore and transform the relational source data before dashboard development.

The analysis included:

- joins across customer, order, order-detail, and product tables;
- aggregation of customer purchasing activity;
- product-level sales analysis;
- revenue calculations;
- inventory analysis;
- customer order frequency;
- average order value;
- geographic analysis;
- customer segmentation;
- customer lifetime profitability analysis; and
- validation of analytical outputs.

The SQL stage provided a reference point against which Power BI measures could subsequently be reconciled.

---

## Core Business Measures

### Total Revenue

Revenue is calculated from quantity ordered multiplied by the selling price of each order line.

```DAX
Total Revenue =
SUMX(
    orderdetails,
    orderdetails[quantityOrdered] *
    orderdetails[priceEach]
)
```

### Total Orders

```DAX
Total Orders =
DISTINCTCOUNT(orders[orderNumber])
```

### Total Units Purchased

```DAX
Total Units Purchased =
SUM(orderdetails[quantityOrdered])
```

### Purchasing Customers

```DAX
Purchasing Customers =
DISTINCTCOUNT(orders[customerNumber])
```

### Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Orders],
    0
)
```

---

## Product and Inventory Analysis

The inventory analysis compares current product stock with historical units sold to identify products where demand may be high relative to available inventory.

### Sales-to-Stock Ratio

A sales-to-stock ratio was developed to compare historical demand with current stock availability.

This supports identification of products where inventory may warrant further investigation.

The analysis also distinguishes products using:

- Low Stock Status
- Replenishment Status
- Priority Products

Conditional formatting was applied to the product-detail dashboard so that:

- **Low Stock** products are visually highlighted; and
- **Priority** replenishment products receive stronger highlighting.

A dynamic minimum sales-to-stock ratio control was also implemented, allowing users to restrict the detail table to products exceeding a selected demand-to-stock threshold.

---

## Customer Segmentation

Customers were segmented using purchasing behaviour and customer value.

### Customer Value Segments

Customers were classified into:

- High Value
- Upper Mid Value
- Lower Mid Value
- Low Value

### Purchase Frequency Segments

Customers were also classified into:

- Frequent Buyer
- Repeat Buyer
- Occasional Buyer
- No Purchases

This provides two complementary views of the customer base:

**Customer value** identifies the economic importance of the customer.

**Purchase frequency** describes how frequently the customer places orders.

The combination supports more targeted marketing and customer-management strategies.

---

## Customer Lifetime Value

The final analytical section estimates historical customer lifetime value using gross profit generated from completed purchasing activity.

### Estimated Gross Profit

```DAX
Estimated Gross Profit =
SUMX(
    orderdetails,
    orderdetails[quantityOrdered] *
    (
        orderdetails[priceEach] -
        RELATED(products[buyPrice])
    )
)
```

### Gross Margin %

```DAX
Gross Margin % =
DIVIDE(
    [Estimated Gross Profit],
    [Total Revenue],
    0
)
```

### Historical CLV

```DAX
Historical CLV =
[Estimated Gross Profit]
```

Historical CLV therefore represents the estimated gross profit generated by a customer over the period represented by the dataset.

### Average Customer CLV

```DAX
Average Customer CLV =
AVERAGEX(
    VALUES(customers[customerNumber]),
    [Historical CLV]
)
```

### Customer Lifespan

```DAX
First Order Date =
MIN(orders[orderDate])
```

```DAX
Last Order Date =
MAX(orders[orderDate])
```

```DAX
Customer Lifespan Days =
DATEDIFF(
    [First Order Date],
    [Last Order Date],
    DAY
)
```

---

## Customer Acquisition Scenarios

Historical CLV was used to create indicative acquisition-investment scenarios.

```DAX
Acquisition Budget 10% =
[Average Customer CLV] * 0.10
```

```DAX
Acquisition Budget 20% =
[Average Customer CLV] * 0.20
```

```DAX
Acquisition Budget 30% =
[Average Customer CLV] * 0.30
```

The validated results were approximately:

| Metric | Result |
|---|---:|
| Average Historical Customer CLV | £39,039.59 |
| 10% Acquisition Scenario | £3,903.96 |
| 20% Acquisition Scenario | £7,807.92 |
| 30% Acquisition Scenario | £11,711.88 |

These values are scenario benchmarks rather than recommended customer acquisition budgets.

---

## Dynamic CLV Filtering

The Customer Lifetime Value Detail dashboard includes a dynamic **Minimum Historical CLV** parameter.

A disconnected numeric parameter allows users to specify a minimum customer lifetime value.

A filtering measure determines whether individual customers satisfy the selected threshold:

```DAX
Show CLV Customer =
VAR MinCLV =
    SELECTEDVALUE(
        'Minimum Historical CLV'[Minimum Historical CLV],
        0
    )
RETURN
    IF(
        [Historical CLV] >= MinCLV,
        1,
        0
    )
```

The measure is applied as a visual-level filter, allowing users to dynamically identify customers above a selected profitability threshold.

---

# Power BI Dashboard

The Power BI solution was designed as a multi-page analytical report combining executive-level dashboards with detailed investigation pages.

## Inventory Demand Analysis

This dashboard compares historical product demand with current inventory availability.

Key elements include:

- Total Stock
- Total Units Sold
- Low Stock Products
- Highest Sales-to-Stock Ratio
- Priority Products
- Demand vs Current Stock scatter analysis
- Stock vs Historical Sales by Product Line
- Product and date filtering

Constant reference lines were added to the scatter analysis to provide additional context for interpreting stock and historical demand.

---

## Product Inventory Detail

This page provides detailed product-level inventory analysis.

The table includes:

- Product Name
- Product Line
- Total Stock
- Total Units Sold
- Sales-to-Stock Ratio
- Low Stock Status
- Replenishment Status

Dynamic filtering allows users to investigate specific product lines, products, replenishment priorities, order periods, and minimum sales-to-stock ratios.

Conditional formatting highlights products requiring attention.

---

## Customer Segmentation Overview

This dashboard analyses customer value and purchasing behaviour.

Headline metrics include:

- Purchasing Customers
- Total Revenue
- Revenue per Customer
- High Value Customers
- Frequent Buyers

Visual analysis includes:

- Revenue by Customer Segment
- Top 10 Customers by Revenue
- Customers by Purchase Frequency

Interactive slicers allow the analysis to be filtered by:

- Customer Segment
- Purchase Frequency
- Country
- Order Date

---

## Geographic Marketing Analysis

A dedicated geographic dashboard was developed to avoid overcrowding the customer segmentation overview.

Headline metrics include:

- Countries
- Purchasing Customers
- Top Revenue Country
- Top Country Revenue

A Shape Map visual displays revenue distribution geographically.

The dashboard identified the **USA** as the highest-revenue country, generating approximately **£3.27M**.

Interactive controls allow geographic performance to be investigated alongside customer segment and purchase frequency.

---

## Customer Segmentation Detail

The detailed customer dashboard provides customer-level purchasing and segmentation information.

The table includes:

- Customer
- Country
- Orders
- Units Purchased
- Revenue
- Average Order Value
- Customer Segment
- Purchase Frequency

The analysis includes both purchasing and non-purchasing customers.

Validation confirmed:

- **122 total customers**
- **98 purchasing customers**
- **24 customers with no purchases**

This distinction is important because customers without transactions would otherwise disappear when measures derived from the Orders table are used.

---

## Customer Lifetime Value & Acquisition Analysis

This dashboard evaluates historical customer profitability and potential acquisition investment scenarios.

Headline metrics include:

- Average Customer CLV
- Acquisition Budget – 10%
- Acquisition Budget – 20%
- Acquisition Budget – 30%
- Purchasing Customers

The dashboard contains three primary analytical visuals:

1. Orders vs Historical CLV
2. Historical CLV by Customer Segment
3. Top 10 Customers by Historical CLV

The design intentionally limits the number of visuals to maintain readability and prevent dashboard overcrowding.

---

## Customer Lifetime Value Detail

The final dashboard provides detailed customer-level profitability analysis.

The table includes:

- Customer Name
- Country
- Total Orders
- Total Revenue
- Estimated Gross Profit
- Gross Margin %
- Historical CLV
- Customer Lifespan Days
- Customer Segment
- Purchase Frequency

Customers are ranked by Historical CLV, allowing the most economically valuable customers to be identified immediately.

A dynamic Minimum Historical CLV control allows users to investigate customers exceeding a selected lifetime-profitability threshold.

---

# Key Findings

## Inventory and Demand

Historical demand varies considerably relative to available inventory.

The inventory analysis identified products where historical units sold are high compared with current stock, supporting more targeted replenishment investigation.

Low-stock and priority classifications make these products immediately visible to dashboard users.

---

## Customer Segmentation

The customer base contains substantial differences in both purchasing frequency and economic value.

The segmentation model separates customers according to value while purchase-frequency categories distinguish frequent, repeat, occasional, and non-purchasing customers.

Of the 122 customers represented:

- 98 made purchases;
- 24 made no purchases.

This creates opportunities for different marketing strategies across active, high-value, lower-value, and inactive customer groups.

---

## Geographic Performance

Customers are distributed across 27 countries.

The USA represents the strongest geographic market by revenue, generating approximately **£3.27M**.

Geographic analysis can therefore support market prioritisation and regional marketing decisions.

---

## Customer Lifetime Value

The 98 purchasing customers generated approximately:

- **£9.60M total revenue**
- **£3.83M estimated gross profit**
- **39.84% overall gross margin**

Average historical customer CLV was approximately:

**£39.04K**

Customer profitability is highly concentrated.

The strongest customers included:

- **Euro+ Shopping Channel — approximately £326.5K Historical CLV**
- **Mini Gifts Distributors Ltd. — approximately £236.8K Historical CLV**

A substantial decline occurs after these leading customers, demonstrating that customer profitability is not evenly distributed.

The High Value customer segment generated approximately:

**£1.77M Historical CLV**

compared with approximately:

- £0.96M — Upper Mid Value
- £0.67M — Lower Mid Value
- £0.42M — Low Value

Higher purchasing frequency is generally associated with greater historical customer value, although frequency alone does not determine profitability.

---

# Business Recommendations

The analysis supports several potential business actions.

### Prioritise High-Value Customer Retention

High-value customers contribute a disproportionate amount of historical profitability.

Retention activity should therefore prioritise these relationships, particularly the highest-value repeat and frequent buyers.

### Use CLV to Inform Acquisition Decisions

Historical customer profitability provides a benchmark against which acquisition investment can be evaluated.

The 10%, 20%, and 30% CLV scenarios provide indicative spending ranges rather than fixed acquisition budgets.

### Target Marketing by Customer Segment

Different strategies can be developed for:

- high-value customers;
- frequent buyers;
- repeat buyers;
- occasional buyers; and
- customers with no purchasing history.

### Investigate Non-Purchasing Customers

The 24 customers with no recorded purchases represent a distinct group that may warrant investigation or re-engagement activity.

### Prioritise Inventory Using Demand

Products with relatively high historical demand and low current inventory should receive greater replenishment attention than products with substantial stock relative to historical sales.

### Use Geographic Performance for Market Prioritisation

High-revenue markets can support targeted marketing investment while lower-performing markets can be assessed for growth opportunities.

---

# Validation and Data Quality

Validation was incorporated throughout the project.

SQL outputs were used to reconcile Power BI measures and dashboard results.

Key validated figures include:

| Metric | Validated Result |
|---|---:|
| Total Customers | 122 |
| Purchasing Customers | 98 |
| Customers with No Purchases | 24 |
| Total Revenue | £9.60M |
| Estimated Gross Profit | £3.83M |
| Gross Margin | 39.84% |
| Average Historical Customer CLV | £39.04K |
| 10% Acquisition Scenario | £3.90K |
| 20% Acquisition Scenario | £7.81K |
| 30% Acquisition Scenario | £11.71K |

Interactive filters and threshold parameters were also tested to confirm that visual-level calculations responded correctly to filter context.

---

# Analytical Limitations

Historical CLV in this project represents **realised historical gross profit**, not a predictive estimate of future customer lifetime value.

The dataset does not contain all information required for a full forward-looking CLV model, including:

- actual customer acquisition cost;
- customer retention probabilities;
- future churn probabilities;
- marketing expenditure;
- future purchase probabilities; and
- discount rates for future cash flows.

The acquisition scenarios should therefore be interpreted as analytical benchmarks rather than recommended marketing budgets.

A production implementation could extend the model using predictive CLV and calculate **CLV:CAC ratios** to assess the expected return from customer acquisition expenditure.

---

# Skills Demonstrated

This project demonstrates practical experience in:

- SQL querying
- Relational database analysis
- Multi-table joins
- Data aggregation
- Data validation and reconciliation
- Power BI data modelling
- DAX measure development
- Filter context
- Iterator functions
- `RELATED`
- `DIVIDE`
- `DISTINCTCOUNT`
- `AVERAGEX`
- `SELECTEDVALUE`
- Dynamic parameter-driven filtering
- Conditional formatting
- Customer segmentation
- Customer lifetime value analysis
- Inventory demand analysis
- Geographic analysis
- Profitability analysis
- Dashboard design
- Business intelligence
- Translating analytical findings into business recommendations

---

# Project Outcome

The completed project transforms relational transactional data into an interactive business intelligence solution covering products, inventory, customers, geographic markets, segmentation, profitability, and customer lifetime value.

Rather than focusing solely on descriptive sales reporting, the project connects operational data with business decisions such as:

**Which products require inventory attention?**

**Which customers generate the greatest economic value?**

**Which customer groups should marketing activity target?**

**Which geographic markets generate the strongest revenue?**

**How much customer acquisition investment could potentially be supported by historical customer profitability?**

The resulting SQL and Power BI solution demonstrates an end-to-end analytical workflow from relational data exploration and validation through to interactive reporting and decision-focused business insight.
