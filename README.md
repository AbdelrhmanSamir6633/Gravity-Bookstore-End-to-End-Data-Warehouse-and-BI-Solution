### Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution


## Project Description
The Gravity Bookstore project is an end-to-end data solution designed to transform raw transactional data from a fictional bookstore into actionable business insights. The project encompasses data modeling, ETL processes, data warehousing, OLAP cube development, and BI reporting, making it a comprehensive data engineering and business intelligence implementation.

## Content:

1- Understand Business Case
2- Database Description
3-
4-






## (1/8) Problem Overview




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



## (3/8) Database Description


## (4/8) Data Warehouse ETL Process

This section provides a detailed overview of the SSIS (SQL Server Integration Services) packages used in the Gravity Book Store project to extract, transform, and load (ETL) data from the source database into the data warehouse (DWH). Each package is designed to handle specific types of data and uses appropriate methods for data loading.

## Packages Overview

### 1. DIM_Book_Package_SSIS

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


## (5/8) Data Model



## (6/8) Analysis Process/Methodology



## (7/8) Key Visualizations




## (8/8) Data Source & Project Files

- <a href="https://github.com/AbdelrhmanSamir6633/Analyzing-Sales-Performance-of-an-International-Company/blob/main/Data%20Source.xlsx">Data Source</a>

