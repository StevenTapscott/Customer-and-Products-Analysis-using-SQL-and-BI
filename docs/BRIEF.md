## Project Origin and Scope

This project was developed from Dataquest's **Customers and Products Analysis Using SQL** guided project.

The original project places the analyst in the role of a data analyst for a scale model car company and focuses on using SQL to answer business questions relating to **product performance, inventory, customer segmentation, marketing, and customer acquisition**.

The original project objectives were to:

1. Explore the relational database schema and understand table relationships.
2. Use joins to combine data from multiple tables and analyse product sales.
3. Aggregate data to identify high-selling and low-inventory products requiring prioritisation.
4. Segment customers using purchase history and location to support targeted marketing.
5. Calculate metrics such as customer lifetime value to inform acquisition spending.
6. Translate the analysis into data-driven recommendations for business stakeholders.

Core SQL techniques covered by the original project include:

- Joins
- Subqueries
- Common Table Expressions (CTEs)
- Nested queries
- Aggregation
- Multi-table relational analysis

### Project Extension

This portfolio implementation substantially extends the original SQL guided project.

Rather than completing the analysis solely within the supplied SQLite environment, the project was expanded into an end-to-end SQL and business intelligence solution covering:

**SQLite → ETL & Migration → SQL Server → Data Validation → Extended SQL Analysis → Power BI Data Modelling → DAX → Interactive Dashboards → Business Recommendations**

Extensions include:

- migrating the original SQLite database into Microsoft SQL Server;
- validating the migrated database before analysis;
- developing and executing the analysis within SQL Server and SSMS;
- extending the original inventory analysis with Sales-to-Stock ratios, Low Stock Status, Replenishment Status, and Priority classifications;
- extending customer analysis with value and purchase-frequency segmentation;
- developing dedicated geographic customer analysis;
- calculating estimated gross profit and historical customer lifetime value;
- developing 10%, 20%, and 30% acquisition-investment scenarios;
- building dynamic What-if parameters for analytical threshold filtering;
- reproducing SQL analytical logic using DAX;
- reconciling SQL and Power BI outputs;
- developing multiple interactive Power BI overview and detail dashboards; and
- documenting analytical limitations and potential production enhancements.

The resulting project retains the original business problems while demonstrating a broader workflow across **database migration, ETL, SQL Server, data validation, SQL analysis, Power BI, DAX, data visualisation, and business intelligence**.
