# Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution


## Project Description
The Gravity Bookstore project is an end-to-end data solution designed to transform raw transactional data from a fictional bookstore into actionable business insights. The project encompasses data modeling, ETL processes, data warehousing, OLAP cube development, and BI reporting, making it a comprehensive data engineering and business intelligence implementation.

## Contents 

**1) Business Case.**

**2) OLTP Database Description.**

**3) Data Warehouse Modeling.**

**4) Data Warehouse ETL Process Using SSIS.**

**5) Data Analysis Using SSAS.**

**6) Key Visualizations Using PowerBI.**

**7) Data Source & Project Files.**


## (1/7) Business Case

### 1.1 Overview
The Gravity Book Store DWH model is designed to support **sales performance analysis**, **customer insights**, **shipping efficiency evaluation**, and **time-based reporting**. This model enables the business to make data-driven decisions and optimize operations.

### 1.2 Key Business Questions

#### 1.2.1 Sales Performance
- What are the total sales generated over a specific period?
- Which books are the best-selling, and which are underperforming?
- How do shipping costs impact overall profitability?

#### 1.2.2 Customer Behavior
- Who are the most frequent customers, and what are their purchasing patterns?
- Which cities or countries generate the most sales?
- How do customer demographics influence sales?

#### 1.2.3 Shipping Efficiency
- Which shipping methods are most cost-effective and efficient?
- Are there delays or issues with specific shipping methods?
- How does shipping method choice correlate with customer satisfaction?

#### 1.2.4 Time-Based Analysis
- What are the sales trends over time (daily, monthly, quarterly, yearly)?
- Are there seasonal patterns in book sales?
- How do sales perform during holidays or special events?


## (2/7) OLTP Database Description

### 2.1 Overview
Gravity Bookstore OLTP Database
The Gravity Bookstore database is a transactional system designed to manage real-time operations for a fictional bookstore. It includes comprehensive tables for managing books, authors, customers, orders, inventory, and shipping. It serves as the foundation for building a data warehouse and creating advanced BI solutions.

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


## (3/7) Data Warehouse Modeling
![Gravity bookstore Diagram DWH](https://github.com/user-attachments/assets/e5708a2a-2b6f-49ec-ac7c-054d036b1507)

### 3.1 Why We Use Star Schema

#### 3.1.1 Simplicity
- Easy to understand and implement.

#### 3.1.2 Query Performance
- Optimizes query performance by reducing joins.

#### 3.1.3 Scalability
- Flexible for future business needs.

#### 3.1.4 Analytical Efficiency
- Ideal for BI and reporting.

#### 3.1.5 Data Integrity
- Ensures consistency across the data warehouse.

### 3.2. How the Model Design Supports the Business Case

#### 1) DIM_Book
- **Purpose:** Stores book-related information for sales analysis.
- **Key Attributes:** `Book_SK`, `Book_NK`, `Title`, `Author_Name`, `Publisher_Name`, `Publication_Date`, `Start_Date`, `End_Date`, `Is_Current`.

#### 2) DIM_Customer
- **Purpose:** Stores customer details for segmentation and behavior analysis.
- **Key Attributes:** `Customer_SK`, `Customer_NK`, `Frame`, `Iname`, `Email`, `Street_Number`, `Street_Name`, `City`, `Country`, `Address_Status`, `Start_Date`, `End_Date`, `Is_Current`.

#### 3) DIM_Shipping
- **Purpose:** Tracks shipping methods for efficiency and cost-effectiveness analysis.
- **Key Attributes:** `Shipping_SK`, `Shipping_NK`, `Method_Name`, `Start_Date`, `End_Date`, `Is_Current`.

#### 4) DIM_Date
- **Purpose:** Provides time-based analysis for sales trends.
- **Key Attributes:** `Date_SK`, `Year`, `Quarter`, `Month`, `Day`.

#### 5) Fact_Sales
- **Purpose:** Captures sales transactions for detailed performance analysis.
- **Key Attributes:** `Sales_SK`, `Order_id`, `Book_K`, `Customer_K`, `Shipping_K`, `Date_K`, `Shipping_Cost`, `Book_Price`.

### 3.3 Business Use Cases

#### 3.3.1 Sales Performance Dashboard
- Monitor and analyze total sales, best-selling books, and profitability.

#### 3.3.2 Customer Segmentation and Targeting
- Identify customer groups and tailor marketing strategies based on purchasing patterns.

#### 3.3.3 Shipping Method Optimization
- Evaluate and optimize shipping methods for cost-effectiveness and efficiency.

#### 3.3.4 Time-Based Sales Analysis
- Analyze sales trends over time, including seasonal patterns and holiday performance.

## (4/7) Data Warehouse ETL Process Using SSIS

### 4.1 Overview

This section provides a detailed overview of the SSIS (SQL Server Integration Services) packages used in the Gravity Book Store project to extract, transform, and load (ETL) data from the source database into the data warehouse (DWH). Each package is designed to handle specific types of data and uses appropriate methods for data loading.

### 4.2 Packages Overview

### 1) DIM_Book Package
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

### 2) DIM_Customer Package
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

### 3) DIM_ShippingMethod Package
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

### 4) FactSales Package
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

Each SSIS package is designed to ensure accurate and efficient data loading into the respective tables in the data warehouse, maintaining data integrity and supporting business intelligence and reporting needs.


## (5/7) Data Analysis Using SSAS

### 5.1 Tabular Mode in SSAS
![05_ Fact_Sales_SSAS_Cube](https://github.com/user-attachments/assets/9545b002-ea1e-4d0f-9776-ea3e8de581f8)

We use **Tabular Mode** in SSAS as it is a modern and efficient modeling method for building analytical models. It uses a columnar database and an in-memory analytics engine, providing rapid query performance and intuitive modeling techniques. The **Gravity Bookstore** project leverages SSAS Tabular Mode for creating a robust analytical solution.

### 5.2 Measures in Tabular Mode (SSAS)

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


# (6/7) Key Visualizations Using PowerBI.

### 6.1 Overview of Power BI Dashboard
The Power BI dashboard provides actionable insights into the Gravity Book Store business operations. It is divided into multiple pages, each focusing on a specific aspect of the business: **Books Report**, **Sales Report**, **Total Due With Status by Country**, and **Conclusion**.

### Page 01: Sales Report

![p1](https://github.com/user-attachments/assets/5979f937-ea07-47f1-9210-4d2b3e2515d6)

### Charts and Insights
1. **Total Due, Total Sales, Total Shipping Cost, Average Sales (KPI Cards):**  
   - *Business Question:* What are the total sales, shipping costs, and average sales per order?
2. **Top 7 Countries by Total Due (Bar Chart):**  
   - *Business Question:* Which countries generate the most revenue?
3. **Total Due by Month (Line Chart):**  
   - *Business Question:* What are the monthly sales trends, and are there any seasonal patterns?
4. **Matrix Bookmark**
   - Bookmark is used to convert between line bookmark and matrix bookmark, as shown below:
![Bookmark](https://github.com/user-attachments/assets/4e5c7729-910a-41b3-8d3d-b459550fba2c)
   - 4.1 **Top 5 Authors by Total Sales (Matrix Table)**
     - *Business Question:* How many books have been sold for **each author** of the **Top 5 Authors**?
     - *Business Question:* What is the **total sales** for **each author** of the **Top 5 Authors**?
   - 4.2 **Total Orders (KPI Card):**  
      - *Business Question:* How many orders have been made?
   - 4.3 **Top 5 Authors' Sold Books**
      - *Business Question:* How many Books have been sold for the ONLY **Top 5 Authors**?
   
## Page 02: Books Report

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

## Page 03: Conclusion

![p3](https://github.com/user-attachments/assets/bf887a5e-b20e-4498-ae63-ae92d10279e9)

### Charts and Insights
1. **Total Due with Status by Country (Matrix Table):**  
   - *Business Question:* Which Country generates the most Revenue?
2. **Top 13 Books Sold (Matrix Table):**  
   - *Business Question:* Which top 13 books contributes the most to revenue?
3. **Top 13 Authors (Matrix Table):**  
   - *Business Question:* Which top 13 authors contribute the most to revenue?
4. **Order Status by year (Matrix Table):**  
   - *Business Question:* How orders' status is affected versus time?
5. **Total Due by Country (Map Visualization):**  
   - *Business Question:* Which regions generate the most revenue geographically?


## ToolTip Page: Total Due With Status by Country

![WhatsApp Image 2025-01-25 at 21 01 41_5c0b9010](https://github.com/user-attachments/assets/aa616260-9b4a-418a-9e5d-2702f48f626d)



## (7/7) Data Source & Project Files

- <a href="https://github.com/sarahfikry22/Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution/tree/main/gravity_bookstore%20DB">gravity_bookstore DB</a>
    - Contents:
      - OLTP DB Diagram.
      - OLTP DB ERD.
      - OLTP DB Mapping.
- <a href="https://github.com/sarahfikry22/Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution/tree/main/SQL%20Queries">SQL Queries</a>
   - Contents:
      - OLTP DB SQL Queries.
      - DWH SQL Queries.
- <a href="https://github.com/sarahfikry22/Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution/tree/main/Gravity_bookstore_DWH">Gravity_bookstore_DWH</a>
   - Contents:
      - DWH Modeling.
      - DWH Backup (.bak file).
- <a href="https://github.com/sarahfikry22/Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution/tree/main/Gravity_BookStore_SSIS_Packages">Gravity_BookStore_SSIS_Packages</a>
   - Contents:
      - DIM_Book SSIS Package.
      - DIM_Customer SSIS Package.
      - DIM_ShippingMethod SSIS Package.
      - FactSales SSIS Package.
- <a href="https://github.com/sarahfikry22/Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution/tree/main/Gravity_BookStore_SSAS_Cubes">Gravity_BookStore_SSAS_Cubes</a>
   - Contents:
      - DIM_Book SSAS Cube.
      - DIM_Customer SSAS Cube.
      - DIM_ShippingMethod SSAS Cube.
      - DIM_Date SSAS Cube.
      - FactSales SSAS Cube.
- <a href="https://github.com/sarahfikry22/Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution/tree/main/Power%20BI%20Dashboard">Power BI Dashboard</a>
   - Contents:
      - Sales Report.
      - Book Report.
      - Conclusion Report.
      - Bookmark.
      - ToolTip Page.
      - PowerBI Dashboard (.pbix file).
    
## Work Environment & Contributors

### Jira Work Environment:

- <a href="https://sarahfikry91.atlassian.net/jira/software/projects/KAN/list">Jira Work Environment</a>

This project was collaboratively managed using Jira, ensuring efficient task tracking, sprint planning, and progress monitoring. Jira facilitated clear communication and assignment of responsibilities among the team members, allowing seamless coordination and timely completion of deliverables. The development team consisted of:

### Contributors: 

1) <a href="https://github.com/sarahfikry22">Sarah Fikry Ezzat.</a>
2) <a href="https://github.com/AbdelrhmanSamir6633">Abdelrhman Samir Ebrahim Hassan.</a> 
3) <a href="https://github.com/abdelrahmansaleh22">Abdelrahman Mahmoud Mahmoud Saleh.</a>  
4) <a href="https://github.com/AhmeddMahmoudd98">Ahmed Mahmoud Attya.</a>   
5) <a href="https://github.com/Nafisa455">Nafisa Abdelaziz Farag Elkady.</a>  

Each team member played a critical role in achieving the project's objectives, leveraging Jira to stay aligned on priorities and updates throughout the development lifecycle.
