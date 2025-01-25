### Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution


## Project Description
The Gravity Bookstore project is an end-to-end data solution designed to transform raw transactional data from a fictional bookstore into actionable business insights. The project encompasses data modeling, ETL processes, data warehousing, OLAP cube development, and BI reporting, making it a comprehensive data engineering and business intelligence implementation.

## Contents 

- **(1/7) Business Case.**
- **(2/7) Database Description.**
- **(3/7) Dataware house Description.**
- **(4/7) Data Warehouse ETL Process.**
- **(5/7) Data Analysis Using SSAS.**
- **(6/7) Analysis Process/Methodology.**
- **(7/7) Data Source & Project Files.**




## (1/8) Business Case

## Overview
The Gravity Book Store DWH model is designed to support **sales performance analysis**, **customer insights**, **shipping efficiency evaluation**, and **time-based reporting**. This model enables the business to make data-driven decisions and optimize operations.

## Key Business Questions
1. **Sales Performance:**
   - What are the total sales generated over a specific period?
   - Which books are the best-selling, and which are underperforming?
   - How do shipping costs impact overall profitability?

2. **Customer Behavior:**
   - Who are the most frequent customers, and what are their purchasing patterns?
   - Which cities or countries generate the most sales?
   - How do customer demographics influence sales?

3. **Shipping Efficiency:**
   - Which shipping methods are most cost-effective and efficient?
   - Are there delays or issues with specific shipping methods?
   - How does shipping method choice correlate with customer satisfaction?

4. **Time-Based Analysis:**
   - What are the sales trends over time (daily, monthly, quarterly, yearly)?
   - Are there seasonal patterns in book sales?
   - How do sales perform during holidays or special events?


## (2/8) Database Description

#### 1) Book Table:
- Contains a list of all books available in the store.
- Relationship:
  - Many-to-Many with the `author` table via the `book_author` table.

#### 2) Book_Author Table:
- Represents the many-to-many relationship between books and authors.
- Contains references to:
  - `book` table (via `book_id`).
  - `author` table (via `author_id`).

#### 3) Author Table:
- Contains a list of all authors.

#### 4) Book_Language Table:
- Contains a list of possible languages for books.
- Relationship:
  - Linked to the `book` table.

#### 5) Publisher Table:
- Contains a list of publishers for books.
- Relationship:
  - Linked to the `book` table.

#### 6) Customer Table:
- Contains a list of customers of the bookstore.

#### 7) Customer_Address Table:
- Represents the many-to-many relationship between customers and addresses.
- Contains references to:
  - `customer` table (via `customer_id`).
  - `address` table (via `address_id`).

#### 8) Address Table:
- Contains a list of addresses.
- Relationship:
  - One-to-Many with the `customer_address` table.
  - One-to-Many with the `address_status` table (indicates current or old status).

#### 9) Address_Status Table:
- Contains the status of an address (e.g., current, old).

#### 10) Country Table:
- Contains a list of countries.
- Relationship:
  - Linked to the `address` table.

#### 11) Cust_Order Table:
- Contains orders placed by customers.
- Relationship:
  - One-to-Many with the `order_line` table (each order can have multiple items).
  - Linked to `customer` table (via `customer_id`).
  - Linked to `shipping_method` table.

#### 12) Order_Line Table:
- Represents the list of books in an order.
- Contains references to:
  - `cust_order` table.
  - `book` table.

#### 13) Shipping_Method Table:
- Contains possible shipping methods for an order.

#### 14) Order_History Table:
- Tracks the history of an order (e.g., ordered, cancelled, delivered).
- Relationship:
  - Linked to `cust_order` table.

#### 15) Order_Status Table:
- Contains the possible statuses of an order.

### Summary of Key Relationships:
- **Many-to-Many**: `book` ↔ `author` (via `book_author`), `customer` ↔ `address` (via `customer_address`).
- **One-to-Many**: `cust_order` ↔ `order_line`, `address` ↔ `customer_address`, `cust_order` ↔ `order_history`.


## (3/8) Dataware house Description
![Gravity bookstore Diagram DWH](https://github.com/user-attachments/assets/e5708a2a-2b6f-49ec-ac7c-054d036b1507)

### Why We Use Star Schema
1. **Simplicity:** Easy to understand and implement.
2. **Query Performance:** Optimizes query performance by reducing joins.
3. **Scalability:** Flexible for future business needs.
4. **Analytical Efficiency:** Ideal for BI and reporting.
5. **Data Integrity:** Ensures consistency across the data warehouse.

### How the Model Design Supports the Business Case

#### 1. DIM_Book
- **Purpose:** Stores book-related information for sales analysis.
- **Key Attributes:** `Book_SK`, `Book_NK`, `Title`, `Author_Name`, `Publisher_Name`, `Publication_Date`, `Start_Date`, `End_Date`, `Is_Current`.

#### 2. DIM_Customer
- **Purpose:** Stores customer details for segmentation and behavior analysis.
- **Key Attributes:** `Customer_SK`, `Customer_NK`, `Frame`, `Iname`, `Email`, `Street_Number`, `Street_Name`, `City`, `Country`, `Address_Status`, `Start_Date`, `End_Date`, `Is_Current`.

#### 3. DIM_Shipping
- **Purpose:** Tracks shipping methods for efficiency and cost-effectiveness analysis.
- **Key Attributes:** `Shipping_SK`, `Shipping_NK`, `Method_Name`, `Start_Date`, `End_Date`, `Is_Current`.

#### 4. DIM_Date
- **Purpose:** Provides time-based analysis for sales trends.
- **Key Attributes:** `Date_SK`, `Year`, `Quarter`, `Month`, `Day`.

#### 5. Fact_Sales
- **Purpose:** Captures sales transactions for detailed performance analysis.
- **Key Attributes:** `Sales_SK`, `Order_id`, `Book_K`, `Customer_K`, `Shipping_K`, `Date_K`, `Shipping_Cost`, `Book_Price`.

### Business Use Cases
1. **Sales Performance Dashboard**
2. **Customer Segmentation and Targeting**
3. **Shipping Method Optimization**
4. **Time-Based Sales Analysis**

### Conclusion
The Gravity Book Store DWH model provides actionable insights to optimize operations, improve customer satisfaction, and drive revenue growth.

## (4/8) Data Warehouse ETL Process

This section provides a detailed overview of the SSIS (SQL Server Integration Services) packages used in the Gravity Book Store project to extract, transform, and load (ETL) data from the source database into the data warehouse (DWH). Each package is designed to handle specific types of data and uses appropriate methods for data loading.

## Packages Overview

### 1. DIM_Book_Package_SSIS
![01_DIM_Book_Package_SSIS](https://github.com/user-attachments/assets/f9005b86-842d-4e91-8161-a35d74415ccb)

**Purpose:**  
Loads data into the `DIM_Book` dimension table, which contains information about books such as title, author, publisher, and publication date.

**Method:**  
- **Slowly Changing Dimension (SCD):** Manages historical and current data changes.
  - **Historical Attribute Inserts Output:** Captures historical changes in book attributes.
  - **Changing Attribute Updates Output:** Updates current attributes.
  - **Derived Column:** Modifies or creates columns as needed.
  - **OLE DB Command:** Executes SQL commands for updates or inserts.
  - **Union All:** Combines multiple data flows.
  - **Insert Destination:** Inserts processed data into the `DIM_Book` table.

### 2. DIM_Customer_Package_SSIS
![02_DIM_Customer_Package_SSIS](https://github.com/user-attachments/assets/1434aae0-af01-4f7c-88c8-380065106bbf)

**Purpose:**  
Loads data into the `DIM_Customer` dimension table, which stores customer information such as name, email, address, and status.

**Method:**  
- **Slowly Changing Dimension (SCD):** Manages historical and current data changes.
  - **Historical Attribute Inserts Output:** Captures historical changes in customer attributes.
  - **Changing Attribute Updates Output:** Updates current attributes.
  - **Derived Column:** Modifies or creates columns as needed.
  - **OLE DB Command:** Executes SQL commands for updates or inserts.
  - **Union All:** Combines multiple data flows.
  - **Insert Destination:** Inserts processed data into the `DIM_Customer` table.

### 3. DIM_ShippingMethod_Package_SSIS
![03_DIM_ShippingMethod_Package_SSIS](https://github.com/user-attachments/assets/525b6e14-1f5f-402a-a6d1-0cca4cc9825e)

**Purpose:**  
Loads data into the `DIM_Shipping` dimension table, which contains information about shipping methods.

**Method:**  
- **Slowly Changing Dimension (SCD):** Manages historical and current data changes.
  - **Historical Attribute Inserts Output:** Captures historical changes in shipping attributes.
  - **Derived Column:** Modifies or creates columns as needed.
  - **OLE DB Command:** Executes SQL commands for updates or inserts.
  - **Union All:** Combines multiple data flows.
  - **Insert Destination:** Inserts processed data into the `DIM_Shipping` table.

### 4. FactSales_Package_SSIS
![04_FactSales_Package_SSIS](https://github.com/user-attachments/assets/23ca5b1d-891a-49a9-a033-dd03686d62dc)

**Purpose:**  
Loads data into the `Fact_Sales` fact table, which records sales transactions, including order details, book, customer, shipping, and date information.

**Method:**  
- **Lookup Transformation:** Matches and retrieves related data from dimension tables.
  - **DIM_Date_Lookup:** Retrieves the corresponding date key from the `DIM_Date` table.
  - **DIM_Customer_Lookup:** Retrieves the customer key from the `DIM_Customer` table.
  - **DIM_Shipping_Lookup:** Retrieves the shipping key from the `DIM_Shipping` table.
  - **DIM_Book_Lookup:** Retrieves the book key from the `DIM_Book` table.
  - **Lookup Match Output:** Outputs matched data for further processing.
  - **OLEDB Destination:** Inserts processed data into the `Fact_Sales` table.

## Summary

- **Dimension Tables (`DIM_Book`, `DIM_Customer`, `DIM_Shipping`):**  
  These tables are loaded using the **Slowly Changing Dimension (SCD)** method to handle historical and current data changes.

- **Fact Table (`Fact_Sales`):**  
  This table is loaded using the **Lookup** method to retrieve and match keys from dimension tables, ensuring referential integrity and accurate data aggregation.

Each SSIS package is designed to ensure accurate and efficient data loading into the respective tables in the data warehouse, maintaining data integrity and supporting business intelligence and reporting needs.


## (5/8) Data Analysis Using SSAS
### Tabular Mode in SSAS
![05_ Fact_Sales_SSAS_Cube](https://github.com/user-attachments/assets/9545b002-ea1e-4d0f-9776-ea3e8de581f8)

We use **Tabular Mode** in SSAS as it is a modern and efficient modeling method for building analytical models. It uses a columnar database and an in-memory analytics engine, providing rapid query performance and intuitive modeling techniques. The **Gravity Bookstore** project leverages SSAS Tabular Mode for creating a robust analytical solution.

---

## Measures in Tabular Mode (SSAS)

### 1) Total Shipping Cost
- **Description**: Calculates the total shipping cost by summing the maximum cost per order.
- **Formula**:
  ```DAX
  SUMX(VALUES(Fact_sales[order_id]), CALCULATE(MAX(Fact_sales[total_cost])))
### 2) Number of Orders
- **Description**: Counts the distinct number of orders.
- **Formula**:
  ```DAX
  DISTINCTCOUNT(Fact_sales[order_id])

### 3) Number of Books
- **Description**: Counts the distinct number of books in the store.
- **Formula**:
  ```DAX
  DISTINCTCOUNT(book[book_id_Bk])
  
### 4) Number of Customers
- **Description**: Counts the distinct number of customers who placed orders.
- **Formula**:
  ```DAX
  DISTINCTCOUNT(customer[customer_id_Bk])

### 5) Total Sales
- **Description**: Sums up the book prices for all sales.
- **Formula**:
  ```DAX
  SUM(Fact_sales[book_price])
  
### 6) Average Sales
- **Description**: Computes the average book price across all sales.
- **Formula**:
  ```DAX
  AVERAGE(Fact_sales[book_price])
  
### 7) Execution Time
- **Description**: Tracks the date and time of the last cube execution.
- **Formula**:
  ```DAX
  "Executed : " & FORMAT(NOW(), "YYYY-MM-DD || HH:mm")

### 8) Total Sales (All)
- **Description**: Calculates the total sales, ignoring filters on the customer country.
- **Formula**:
  ```DAX
  CALCULATE([Total Sales], ALL(customer[country]))

### 9) Percentage of Sales
- **Description**: Calculates the percentage of sales relative to total sales across all customers.
- **Formula**:
  ```DAX
  DIVIDE([Total Sales], [Total Sales All]) * 100 & "%"


# (6/8) Analysis Process/Methodology

## Overview of Power BI Dashboard
The Power BI dashboard provides actionable insights into the Gravity Book Store business operations. It is divided into multiple pages, each focusing on a specific aspect of the business: **Books Report**, **Sales Report**, **Total Due With Status by Country**, and **Conclusion**.

## Page 1: Books Report

![p2](https://github.com/user-attachments/assets/e82b4645-9942-4c0a-8750-0bc2f37bb8af)

### Charts and Insights
1. **Total Due (KPI Card):**  
   - *Business Question:* What is the total revenue generated from book sales?
2. **No. Sold Books by Author Name (Matrix Visualization):**  
   - *Business Question:* Which authors have the highest number of books sold?
3. **Top 5 Authors by Total Due (Bar Chart):**  
   - *Business Question:* Which authors contribute the most to revenue?
4. **Total Due by Book Title (Bar Chart):**  
   - *Business Question:* Which books generate the most revenue?
5. **Shipping Method (Donut Chart):**  
   - *Business Question:* Which shipping methods are most commonly used?

## Page 2: Sales Report

![p1](https://github.com/user-attachments/assets/5979f937-ea07-47f1-9210-4d2b3e2515d6)

### Charts and Insights
1. **Total Due, Total Sales, Total Shipping Cost, Average Sales (KPI Cards):**  
   - *Business Question:* What are the total sales, shipping costs, and average sales per order?
2. **Top 7 Countries by Total Due (Bar Chart):**  
   - *Business Question:* Which countries generate the most revenue?
3. **Total Due by Month (Line Chart):**  
   - *Business Question:* What are the monthly sales trends, and are there any seasonal patterns?

## ToolTip Page: Total Due With Status by Country

![WhatsApp Image 2025-01-25 at 21 01 41_5c0b9010](https://github.com/user-attachments/assets/aa616260-9b4a-418a-9e5d-2702f48f626d)

### Charts and Insights
1. **Total Due With Status by Country (Table):**  
   - *Business Question:* Which countries contribute the most to revenue, and what is their active/inactive status?
2. **Top 13 Books Sold (Table):**  
   - *Business Question:* Which books are the best-selling, and how much revenue do they generate?

## Page 4: Conclusion

![p3](https://github.com/user-attachments/assets/bf887a5e-b20e-4498-ae63-ae92d10279e9)

### Charts and Insights
1. **Total Shipping Cost by Shipping Method (Bar Chart):**  
   - *Business Question:* Which shipping methods incur the highest costs?
2. **Total Due by Country (Map Visualization):**  
   - *Business Question:* Which regions generate the most revenue geographically?

## Conclusion
The Gravity Book Store Dashboard provides a comprehensive view of the business, enabling stakeholders to make data-driven decisions. Each page and chart is designed to answer specific business questions, ensuring that the insights are actionable and aligned with business goals.







## (8/8) Data Source & Project Files

- <a href="https://github.com/AbdelrhmanSamir6633/Analyzing-Sales-Performance-of-an-International-Company/blob/main/Data%20Source.xlsx">Data Source</a>

