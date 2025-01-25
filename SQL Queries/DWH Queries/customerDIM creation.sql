--1) Check if there is a previous FK called 'FK_FactSales_DIM_Customer' for Customer Table, and Dropping it if exists:
IF EXISTS ( 
		   SELECT 
					* 
		   FROM
				sys.foreign_keys
		   WHERE
				name = 'CustomerDim_fk'
		   AND 
				object_id = OBJECT_ID('Fact_Sales')
		  )

ALTER TABLE Fact_Sales 
DROP CONSTRAINT CustomerDim_fk
GO

--2) Check if there is a previous Dimension Table called 'DIM_Customer', and Dropping it if exists:
IF EXISTS (
		   SELECT 
					* 
		   FROM
				sys.tables
		   WHERE 
				name = 'customer'
		   AND 
				type = 'U'
		   )

DROP TABLE customer 
GO

create table customer(
customer_id_sk int identity(1,1)  primary key , --surrgoate key
customer_id_Bk int ,                            --business key 
f_name VARCHAR(200) ,
l_name VARCHAR(200) ,
email VARCHAR(350) ,
street_number VARCHAR(10),
street_name VARCHAR(200) ,
city VARCHAR(100) ,
country VARCHAR(200) ,
address_status VARCHAR(30),
start_date datetime not null default(getdate()),		--SCD	
end_date datetime null,									--SCD
is_current tinyint not null)                            --SCD 