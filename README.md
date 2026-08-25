# Customers and Products Analysis Using SQL and Power BI

## Project Overview

This project delivers an end-to-end data analytics and business intelligence solution covering **database migration, ETL, SQL analysis, data validation, Power BI modelling, DAX, interactive dashboard development, and business insight**.

The project began with the Classic Models database in **SQLite**. The source data was migrated into **Microsoft SQL Server**, where the relational database was reconstructed and validated before SQL analysis was performed. The analytical logic was then extended into Power BI to create interactive reporting covering product performance, inventory management, customer segmentation, geographic markets, and historical customer lifetime value.

The overall workflow was:

**SQLite Source → ETL & Migration → SQL Server → Data Validation → SQL Analysis → Power BI Data Model → DAX → Interactive Dashboards → Business Insights**

---

## Business Objectives

The analysis was designed around the following business questions:

1. Which products and product lines generate the strongest sales performance?
2. How does historical product demand compare with current inventory?
3. Which products may require replenishment attention?
4. How can customers be segmented using purchase history and purchasing behaviour?
5. Which customers and geographic markets generate the greatest value?
6. What is the historical lifetime profitability of customers?
7. How could customer lifetime value be used to establish indicative customer acquisition investment scenarios?

---

## Tools and Technologies

- SQLite
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Power BI Desktop
- Power Query
- DAX
- Relational data modelling
- Data visualisation
- Business intelligence reporting

---

# Data Engineering and ETL

## SQLite to SQL Server Migration

The source Classic Models database was originally provided in SQLite and was migrated into Microsoft SQL Server to create a more representative relational database environment for analysis and reporting.

The migration process involved:

1. Reviewing the SQLite source database and identifying the available tables and relationships.
2. Inspecting source column structures and data types.
3. Creating the corresponding database structure in SQL Server.
4. Migrating source data from SQLite into SQL Server.
5. Resolving compatibility differences between SQLite and SQL Server where required.
6. Checking primary and foreign-key relationships.
7. Validating migrated row counts and table structures.
8. Checking for missing, unexpected, or incorrectly transformed values.
9. Confirming that the migrated database supported the required analytical queries.
10. Using the validated SQL Server database as the foundation for downstream analysis and Power BI reporting.

This ensured that analysis was performed against a validated SQL Server implementation rather than directly against the original source database.

## ETL and Reporting Workflow

```text
Classic Models SQLite Database
              |
              v
      Source Inspection
              |
              v
       Data Extraction
              |
              v
 Transformation / Type Handling
              |
              v
     Microsoft SQL Server
              |
              v
       Data Validation
              |
              v
        SQL Analysis
              |
              v
       Power BI Model
              |
              v
       DAX Measures
              |
              v
 Interactive BI Dashboards
              |
              v
     Business Findings
```

---

# SQL Analysis Process

Following migration and validation, SQL was used as the primary analytical layer before Power BI development.

## 1. Define the Business Requirement

Each analytical section began with a defined business question covering areas including:

- product performance;
- inventory and replenishment;
- customer purchasing behaviour;
- customer segmentation;
- geographic performance; and
- customer lifetime value.

## 2. Identify Required Tables and Relationships

Relevant relational tables were identified before queries were developed.

Core tables included:

- `customers`
- `orders`
- `orderdetails`
- `products`
- `productlines`

This allowed the analysis to move between customer, order, order-line, product, and product-line levels while maintaining the appropriate analytical granularity.

## 3. Develop SQL Analysis

SQL was used to transform transactional records into business-level analytical outputs using techniques including:

- multi-table `JOIN` operations;
- `WHERE` filtering;
- `GROUP BY` aggregation;
- `ORDER BY`;
- aggregate functions;
- calculated expressions;
- conditional logic;
- customer-level aggregation;
- product-level aggregation; and
- relational analysis across multiple tables.

The resulting queries supported analysis of revenue, order activity, product performance, inventory, customer behaviour, geographic markets, segmentation, and customer profitability.

## 4. Validate SQL Results

Outputs were validated before being used as business findings or reproduced in Power BI.

Checks included:

- row counts;
- customer counts;
- order counts;
- revenue totals;
- units sold;
- inventory metrics;
- customer segmentation totals; and
- customer lifetime value calculations.

## 5. Translate Results into Business Metrics

SQL outputs were interpreted in business terms to identify:

- leading products and product lines;
- products exposed to inventory pressure;
- high-value customers;
- frequent and repeat customers;
- customers with no recorded purchases;
- high-value geographic markets; and
- customers generating the greatest historical gross profit.

## 6. Reproduce and Extend the Analysis in Power BI

Validated SQL results provided benchmarks for the Power BI implementation.

DAX measures reproduced and extended the SQL calculations while allowing results to respond dynamically to report filter context.

The reconciliation process followed:

```text
Source Data
    ↓
SQL Result
    ↓
Power BI / DAX Result
    ↓
Reconciliation
    ↓
Dashboard
```

This provided an additional validation layer before analytical results were presented to report users.

---

# Data Model

Power BI models were constructed according to the requirements of each analytical dashboard rather than importing unnecessary tables into every report.

## Customer Analysis

```text
customers (1)
     |
     *
orders (1)
     |
     *
orderdetails
```

## Customer Profitability and CLV Analysis

```text
customers
    1
    |
    *
orders
    1
    |
    *
orderdetails
    *
    |
    1
products
```

The addition of `products` enabled `buyPrice` to be combined with transactional selling prices to calculate estimated gross profit and historical customer lifetime value.

Relationships were validated before DAX measures and report visuals were developed.

---

# Core Business Measures

## Total Revenue

Revenue was calculated from the quantity ordered multiplied by the selling price of each order line.

```DAX
Total Revenue =
SUMX(
    orderdetails,
    orderdetails[quantityOrdered] *
    orderdetails[priceEach]
)
```

## Total Orders

```DAX
Total Orders =
DISTINCTCOUNT(orders[orderNumber])
```

## Total Units Purchased

```DAX
Total Units Purchased =
SUM(orderdetails[quantityOrdered])
```

## Purchasing Customers

```DAX
Purchasing Customers =
DISTINCTCOUNT(orders[customerNumber])
```

## Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Orders],
    0
)
```

---

# Product and Inventory Analysis

The product and inventory analysis examines historical product demand alongside current inventory levels to identify commercially important products and potential replenishment requirements.

The analysis includes:

- product and product-line revenue;
- units sold;
- current stock;
- Sales-to-Stock Ratio;
- Low Stock Status;
- Replenishment Status; and
- Priority Products.

Rather than relying exclusively on absolute stock levels, historical demand was incorporated into the inventory analysis to provide additional context around potential replenishment requirements.

## Sales-to-Stock Analysis

A Sales-to-Stock Ratio was used to compare historical sales volume with available inventory.

This helps distinguish between products with low stock but limited historical demand and products where historical sales are comparatively high relative to current stock.

Dynamic filtering allows report users to specify a minimum Sales-to-Stock Ratio and investigate products exceeding the selected threshold.

Conditional formatting was also applied to detailed inventory reporting so that:

- **Low Stock** products are highlighted; and
- **Priority** replenishment products receive targeted highlighting.

---

# Customer Segmentation

Customers were segmented using both economic value and purchasing frequency.

## Customer Value Segments

Customers were classified into:

- High Value
- Upper Mid Value
- Lower Mid Value
- Low Value

This provides a value-based view of the customer portfolio and supports identification of commercially important accounts.

## Purchase Frequency Segments

Customers were also classified into:

- Frequent Buyer
- Repeat Buyer
- Occasional Buyer
- No Purchases

The two classifications provide complementary perspectives.

**Customer value** represents the economic importance of a customer, while **purchase frequency** describes purchasing behaviour.

Combining the two dimensions provides a stronger basis for targeted marketing, retention, and re-engagement decisions than either measure alone.

---

# Customer Lifetime Value

The final analytical section estimates historical customer lifetime value using estimated gross profit generated from recorded purchasing activity.

The project deliberately refers to this metric as **Historical CLV** because the available dataset supports analysis of realised historical profitability rather than prediction of future customer value.

## Estimated Gross Profit

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

## Gross Margin %

```DAX
Gross Margin % =
DIVIDE(
    [Estimated Gross Profit],
    [Total Revenue],
    0
)
```

## Historical CLV

```DAX
Historical CLV =
[Estimated Gross Profit]
```

Historical CLV therefore represents the estimated gross profit generated by each customer during the period represented by the dataset.

## Average Customer CLV

```DAX
Average Customer CLV =
AVERAGEX(
    VALUES(customers[customerNumber]),
    [Historical CLV]
)
```

The validated Average Historical Customer CLV was approximately:

**£39,039.59**

## Customer Lifespan

Customer lifespan was also calculated from the first and last recorded order dates.

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

This provides additional behavioural context when investigating customer-level historical profitability.

---

# Customer Acquisition Scenarios

Historical CLV was used to create indicative acquisition-investment scenarios.

Rather than presenting a single assumed acquisition budget, three scenarios were created representing 10%, 20%, and 30% of Average Historical Customer CLV.

## 10% Scenario

```DAX
Acquisition Budget 10% =
[Average Customer CLV] * 0.10
```

## 20% Scenario

```DAX
Acquisition Budget 20% =
[Average Customer CLV] * 0.20
```

## 30% Scenario

```DAX
Acquisition Budget 30% =
[Average Customer CLV] * 0.30
```

The validated results were:

| Metric | Result |
|---|---:|
| Average Historical Customer CLV | £39,039.59 |
| 10% Acquisition Scenario | £3,903.96 |
| 20% Acquisition Scenario | £7,807.92 |
| 30% Acquisition Scenario | £11,711.88 |

These values represent **scenario benchmarks rather than recommended customer acquisition budgets**.

Actual Customer Acquisition Cost (CAC) data would be required before determining whether a specific acquisition-spend level is economically justified.

---

# Dynamic CLV Filtering

The Customer Lifetime Value Detail dashboard includes a dynamic **Minimum Historical CLV** parameter.

A disconnected numeric parameter allows users to specify the minimum historical customer value they wish to investigate.

A filtering measure evaluates each customer against the selected threshold:

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

The measure is applied as a visual-level filter.

This allows users to dynamically answer questions such as:

> Which customers have generated at least £50,000 in historical lifetime gross profit?

The parameter was tested at multiple threshold values to confirm that the detail table responded correctly.

---

# Power BI Dashboards

The Power BI solution combines analytical overview dashboards with detailed investigation pages.

Dashboard designs were intentionally limited to a small number of primary visuals to maintain readability and avoid overcrowding.

---

## Product Sales Performance

The Product Sales Performance analysis examines commercial performance across individual products and product lines.

The dashboard supports investigation of:

- total revenue;
- units sold;
- product performance;
- product-line performance; and
- relative commercial contribution.

This provides the commercial foundation for the subsequent inventory analysis.

---

## Inventory & Replenishment Analysis

The Inventory & Replenishment Analysis provides an executive-level view of inventory health.

The dashboard combines stock information with historical sales activity to identify products where inventory levels may warrant further investigation.

Analysis includes:

- current stock;
- historical demand;
- low-stock products;
- replenishment status; and
- priority products.

---

## Inventory Demand Analysis

The Inventory Demand Analysis compares current inventory with historical product demand.

The dashboard includes analysis of:

- Total Stock
- Total Units Sold
- Low Stock Products
- Highest Sales-to-Stock Ratio
- Priority Products
- Demand vs Current Stock
- Stock vs Historical Sales by Product Line

A scatter analysis is used to compare historical product demand with current inventory.

Reference lines provide additional context when identifying products with unusual combinations of stock and historical demand.

---

## Product Inventory Detail

The Product Inventory Detail dashboard provides a customer-style drill-down experience at product level.

The table includes:

- Product Name
- Product Line
- Total Stock
- Total Units Sold
- Sales-to-Stock Ratio
- Low Stock Status
- Replenishment Status

Interactive filters allow users to investigate particular product lines, products, replenishment categories, order periods, and minimum Sales-to-Stock Ratio thresholds.

Conditional formatting highlights **Low Stock** and **Priority** products so that products requiring attention can be identified quickly.

---

## Customer Segmentation Overview

The Customer Segmentation Overview analyses customer value and purchasing behaviour.

Headline measures include:

- Purchasing Customers
- Total Revenue
- Revenue per Customer
- High Value Customers
- Frequent Buyers

The dashboard contains three primary analytical visuals:

1. Revenue by Customer Segment
2. Top 10 Customers by Revenue
3. Customers by Purchase Frequency

The purchase-frequency analysis includes customers classified as:

- Frequent Buyer
- Repeat Buyer
- Occasional Buyer
- No Purchases

Interactive slicers allow the analysis to be filtered by:

- Customer Segment
- Purchase Frequency
- Country
- Order Date

---

## Geographic Marketing Analysis

A dedicated geographic dashboard was developed to prevent the customer segmentation dashboard from becoming overcrowded.

Headline metrics include:

- Countries
- Purchasing Customers
- Top Revenue Country
- Top Country Revenue

The analysis identified customers across **27 countries**.

The **USA** was identified as the highest-revenue geographic market, generating approximately:

**£3.27M**

A Power BI Shape Map was used to visualise geographic revenue distribution.

Interactive controls allow users to investigate geographic performance alongside customer value and purchase-frequency classifications.

---

## Customer Segmentation Detail

The Customer Segmentation Detail dashboard provides customer-level purchasing and segmentation information.

The table includes:

- Customer Name
- Country
- Total Orders
- Total Units Purchased
- Total Revenue
- Average Order Value
- Customer Segment
- Purchase Frequency
- Customer Count

Interactive filters allow users to investigate customers according to:

- Customer Segment
- Purchase Frequency
- Country
- Order Date

Validation confirmed:

- **122 total customers**
- **98 purchasing customers**
- **24 customers with no purchases**

Filtering specifically for **No Purchases** returned 24 customers, while excluding that classification returned 98 purchasing customers.

The two populations therefore reconcile exactly:

**98 Purchasing Customers + 24 No Purchase Customers = 122 Total Customers**

The detail view enables users to identify high-value and frequent customers while also isolating customers with no recorded purchases for potential re-engagement activity.

---

## Customer Lifetime Value & Acquisition Analysis

The Customer Lifetime Value & Acquisition Analysis evaluates historical customer profitability and indicative acquisition-investment scenarios.

Headline metrics include:

- Average Customer CLV
- Acquisition Budget 10%
- Acquisition Budget 20%
- Acquisition Budget 30%
- Purchasing Customers

The dashboard contains three primary analytical visuals:

1. **Orders vs Historical CLV**
2. **Historical CLV by Customer Segment**
3. **Top 10 Customers by Historical CLV**

The scatter analysis examines the relationship between purchasing frequency and historical profitability.

Customer-segment analysis demonstrates how lifetime profitability is distributed across the customer value classifications.

The Top 10 analysis identifies the individual customer accounts responsible for the greatest historical gross profit.

The dashboard intentionally excludes an Order Date slicer because Historical CLV is designed to represent lifetime-to-date value within the available dataset rather than value generated within an arbitrarily selected reporting period.

---

## Customer Lifetime Value Detail

The Customer Lifetime Value Detail dashboard provides detailed customer-level profitability and lifetime-value analysis.

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

Customers are ranked by **Historical CLV descending**, allowing the most economically valuable customers to be identified immediately.

Interactive controls include:

- Country
- Customer Name
- Minimum Historical CLV

The dynamic Minimum Historical CLV parameter allows users to isolate customers above a selected lifetime-profitability threshold.

---

# Validation and Reconciliation

Validation was incorporated throughout the complete analytical workflow rather than being treated solely as a final-stage activity.

The validation framework followed:

**Source Validation → Migration Validation → SQL Validation → Power BI Validation → Interactive Filter Testing**

Key reconciled results include:

| Metric | Validated Result |
|---|---:|
| Total Customers | 122 |
| Purchasing Customers | 98 |
| Customers with No Purchases | 24 |
| Total Orders | 326 |
| Total Units Purchased/Sold | 105,516 |
| Total Revenue | £9.60M |
| Estimated Gross Profit | £3.83M |
| Gross Margin | 39.84% |
| Average Historical Customer CLV | £39.04K |
| 10% Acquisition Scenario | £3.90K |
| 20% Acquisition Scenario | £7.81K |
| 30% Acquisition Scenario | £11.71K |

SQL outputs were used as reference points when developing Power BI measures.

This allowed the analytical workflow to verify that DAX calculations reproduced the expected SQL results before the measures were incorporated into dashboards.

Interactive filtering was also tested.

For example:

- customer segmentation filters reconciled 98 purchasing customers and 24 no-purchase customers to the 122-customer population;
- Minimum Historical CLV filtering was tested at different threshold values; and
- dashboard measures were checked to ensure they responded appropriately to report filter context.

---

# Key Findings

## Product and Inventory Performance

Historical product demand varies considerably relative to available inventory.

The analysis demonstrates that inventory requirements cannot be assessed reliably from absolute stock levels alone.

Combining current inventory with historical sales activity provides a stronger indication of potential replenishment pressure and enables products requiring further attention to be prioritised.

Low Stock and Priority classifications provide users with a straightforward way of identifying products requiring investigation.

---

## Customer Segmentation

The customer base contains substantial differences in both purchasing behaviour and economic value.

The dataset contains:

- **122 total customers**
- **98 purchasing customers**
- **24 customers with no recorded purchases**

The 24 customers with no purchases represent a distinct group that can be isolated by country and investigated for potential re-engagement activity.

Value segmentation also allows commercially important customers to be distinguished from lower-value customer groups.

Purchase-frequency segmentation provides a complementary behavioural perspective by separating frequent, repeat, occasional, and non-purchasing customers.

---

## Geographic Performance

Customers are distributed across **27 countries**.

The **USA** represents the strongest geographic market by revenue, generating approximately:

**£3.27M**

This indicates substantial geographic concentration and provides a basis for prioritising high-value markets while investigating growth opportunities elsewhere.

---

## Customer Lifetime Value

The 98 purchasing customers generated approximately:

- **£9.60M Total Revenue**
- **£3.83M Estimated Gross Profit**
- **39.84% Overall Gross Margin**

Average Historical Customer CLV was approximately:

**£39.04K**

Customer lifetime profitability is highly concentrated.

The strongest individual customers included:

- **Euro+ Shopping Channel — approximately £326.5K Historical CLV**
- **Mini Gifts Distributors Ltd. — approximately £236.8K Historical CLV**

There is a substantial decline after these leading customers, demonstrating that historical customer profitability is not evenly distributed across the customer base.

The High Value customer segment generated approximately:

**£1.77M Historical CLV**

compared with approximately:

- **£0.96M — Upper Mid Value**
- **£0.67M — Lower Mid Value**
- **£0.42M — Low Value**

Higher purchasing frequency is generally associated with greater historical CLV, although frequency alone does not determine customer profitability.

Revenue, order behaviour, product mix, and gross margin combine to produce materially different customer-value outcomes.

---

# Key Analysis

## Customer Segmentation Analysis

Customer-level segmentation combines **purchase value, order frequency, units purchased, average order value, and geographic location** to provide a detailed view of customer behaviour.

Customers can be filtered by value segment, purchase frequency, country, and order date, enabling users to identify:

- high-value accounts;
- frequent buyers;
- repeat customers;
- occasional customers; and
- customers with no recorded purchases.

The analysis therefore provides a basis for targeted retention, re-engagement, and marketing activity rather than treating the entire customer population as a homogeneous group.

---

## Customer Lifetime Value Analysis

The CLV analysis indicates that customer profitability is concentrated among a relatively small group of high-value customers.

This suggests that customer acquisition and retention strategies should not treat all customers as economically equivalent.

Characteristics associated with higher customer value — including purchasing frequency, revenue generation, and gross profitability — provide a basis for identifying customer profiles where greater marketing and retention investment may be justified.

The acquisition-budget scenarios translate historical customer profitability into practical investment benchmarks.

At an Average Historical Customer CLV of approximately **£39.04K**, allocating 10%–30% of historical value would correspond to approximately:

**£3.90K–£11.71K per customer**

These figures should be interpreted as **scenario benchmarks rather than recommended acquisition budgets**, because the dataset does not contain actual Customer Acquisition Cost, retention probabilities, or future churn information.

The analysis therefore provides a historical profitability-based framework for acquisition decision-making rather than a predictive CLV model.

---

# Business Recommendations

## Prioritise High-Value Customer Retention

High-value customers contribute a disproportionate amount of historical profitability.

Retention activity should therefore prioritise these relationships, particularly the highest-value repeat and frequent buyers.

---

## Use CLV to Inform Acquisition Decisions

Historical customer profitability provides a benchmark against which potential acquisition investment can be evaluated.

The 10%, 20%, and 30% CLV scenarios provide indicative investment ranges rather than fixed acquisition budgets.

Actual acquisition costs should be incorporated before making production investment decisions.

---

## Target Marketing by Customer Segment

Different strategies can be developed for:

- High Value customers
- Upper Mid Value customers
- Lower Mid Value customers
- Low Value customers
- Frequent Buyers
- Repeat Buyers
- Occasional Buyers
- Customers with No Purchases

This enables marketing activity to be aligned more closely with customer behaviour and economic value.

---

## Investigate Non-Purchasing Customers

The **24 customers with no recorded purchases** represent a distinct group that may warrant investigation or re-engagement activity.

Geographic and customer-level filtering can be used to identify these accounts for further analysis.

---

## Prioritise Inventory Using Historical Demand

Products with relatively strong historical demand and limited current inventory should receive greater replenishment attention than products with substantial inventory relative to historical sales.

The Sales-to-Stock Ratio, Low Stock Status, and Replenishment Status provide complementary indicators for prioritising investigation.

---

## Use Geographic Performance for Market Prioritisation

High-revenue geographic markets can support targeted marketing investment, while lower-performing markets can be investigated for potential growth opportunities.

The strong revenue contribution from the USA demonstrates the importance of understanding geographic concentration rather than analysing customer performance solely at an aggregate level.

---

# Analytical Limitations

## Historical Rather Than Predictive CLV

Historical CLV in this project represents **realised historical gross profit**, not a predictive estimate of future customer lifetime value.

The available dataset does not contain all information required for a full forward-looking CLV model, including:

- actual Customer Acquisition Cost (CAC);
- customer retention probabilities;
- future churn probabilities;
- marketing expenditure;
- future purchase probabilities; and
- discount rates for future cash flows.

The acquisition scenarios should therefore be interpreted as analytical benchmarks rather than recommended marketing budgets.

A production implementation could extend the analysis by incorporating predictive CLV and actual CAC.

This would enable calculation of metrics such as:

**CLV:CAC Ratio**

and provide a stronger basis for evaluating expected returns from customer acquisition expenditure.

---

## Historical Demand and Inventory

Historical sales activity provides useful context for inventory analysis but does not constitute a demand forecast.

Future inventory decisions could also incorporate:

- sales forecasts;
- supplier lead times;
- reorder points;
- safety stock;
- seasonality;
- service-level targets; and
- outstanding purchase orders.

This would enable the inventory analysis to evolve from historical monitoring into a more comprehensive replenishment-planning solution.

---

# External Geographic Data

The Geographic Marketing Analysis uses external world boundary data to support the Power BI Shape Map.

**World Atlas TopoJSON (`countries-110m.json`)** was used to provide country-level geographic boundaries.

Source:

**TopoJSON World Atlas — `topojson/world-atlas` GitHub repository**

The geographic boundary source should be retained with the appropriate source and licence attribution when distributing the project.

---

# Skills Demonstrated

## Database and ETL

- SQLite
- Microsoft SQL Server
- SQL Server Management Studio
- SQLite to SQL Server migration
- ETL
- Source-to-target migration
- Relational database structures
- Data-type handling
- Data validation
- Data reconciliation
- Data integrity checking

## SQL

- Multi-table joins
- Filtering
- Aggregation
- Grouping
- Sorting
- Calculated expressions
- Conditional logic
- Customer-level analysis
- Product-level analysis
- Revenue analysis
- Inventory analysis
- Geographic analysis
- Customer segmentation
- Profitability analysis
- Customer lifetime value analysis

## Power BI and DAX

- Power BI Desktop
- Power Query
- Relational data modelling
- Table relationships
- DAX measures
- Filter context
- Iterator functions
- `SUMX`
- `AVERAGEX`
- `RELATED`
- `DIVIDE`
- `DISTINCTCOUNT`
- `SELECTEDVALUE`
- Dynamic What-if parameters
- Measure-driven visual filtering
- Conditional formatting
- Interactive slicers
- Shape Map geographic analysis
- Scatter analysis
- KPI reporting
- Dashboard design
- Detailed analytical reporting

## Business and Analytical Skills

- Product performance analysis
- Inventory and replenishment analysis
- Customer segmentation
- Customer behaviour analysis
- Geographic market analysis
- Customer profitability analysis
- Historical customer lifetime value
- Acquisition-spend scenario analysis
- Data validation and reconciliation
- Translating technical analysis into business findings
- Developing actionable business recommendations
- Identifying analytical limitations

---

# Project Outcome

The completed project demonstrates an end-to-end analytical workflow:

**SQLite → ETL → SQL Server → SQL Analysis → Validation → Power BI → DAX → Interactive Reporting → Business Insight**

The project moves beyond descriptive dashboard development by combining upstream database migration and SQL analysis with downstream business intelligence and decision-support reporting.

The resulting solution addresses practical business questions including:

- Which products generate the greatest commercial value?
- Which products may require inventory attention?
- How does historical demand compare with current stock?
- Which customers generate the greatest revenue and profitability?
- Which customer groups should marketing activity target?
- Which geographic markets contribute the greatest value?
- Which customers represent potential re-engagement opportunities?
- What is the historical lifetime profitability of the customer base?
- How could historical customer value inform acquisition-investment scenarios?

The project demonstrates how relational data can be migrated, validated, analysed, modelled, and transformed into an interactive business intelligence solution supporting product, inventory, customer, marketing, and acquisition decisions.
