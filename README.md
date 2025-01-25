### Gravity-Bookstore-End-to-End-Data-Warehouse-and-BI-Solution


## Project Description
The Gravity Bookstore project is an end-to-end data solution designed to transform raw transactional data from a fictional bookstore into actionable business insights. The project encompasses data modeling, ETL processes, data warehousing, OLAP cube development, and BI reporting, making it a comprehensive data engineering and business intelligence implementation.

## Content:

1- Understand Business Case
2- Database Description
3-







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



## (4/8) Tools and Technologies Used

## (5/8) Data Model



## (6/8) Analysis Process/Methodology



## (7/8) Key Visualizations




## (8/8) Data Source & Project Files

- <a href="https://github.com/AbdelrhmanSamir6633/Analyzing-Sales-Performance-of-an-International-Company/blob/main/Data%20Source.xlsx">Data Source</a>

