
--1) Check if there is a previous Dimension Table called 'Fact_Sales', and Dropping it if exists:
IF EXISTS ( 
		   SELECT 
					* 
		   FROM
				sys.tables
		   WHERE 
				name = 'Fact_Sales'
		   AND 
				type = 'U')
DROP TABLE Fact_Sales 
GO

create table Fact_sales (
sales_sk int identity(1,1)  primary key ,
book_id int , --
customer_id int, --
shippingmethod_id int, --
order_id int,
order_date_id int, 
total_cost money,
book_price money,
CONSTRAINT CustomerDim_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id_sk),
CONSTRAINT bookDim_fk FOREIGN KEY (book_id) REFERENCES book(book_id_sk),
CONSTRAINT shipping_methodDim_fk FOREIGN KEY (shippingmethod_id) REFERENCES shipping_method(shippingmethod_id_sk),
CONSTRAINT dateDim_fk FOREIGN KEY (order_date_id) REFERENCES DimDate(DateSK)
)