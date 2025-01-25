--1) Check if there is a previous FK called 'FK_FactSales_DIM_Shipping' for Shipping Table, and Dropping it if exists:
IF EXISTS ( 
		   SELECT 
					* 
		   FROM
				sys.foreign_keys
		   WHERE 
				name = 'shipping_methodDim_fk'
		   AND 
				object_id= OBJECT_ID('Fact_Sales')
		   )

ALTER TABLE Fact_Sales 
DROP CONSTRAINT shipping_methodDim_fk
GO

--2) Check if there is a previous Dimension Table called 'DIM_Shipping', and Dropping it if exists:
IF EXISTS (
		   select 
					* 
		   from
				sys.tables
		   where
				name = 'shipping_method'
		   and 
				type = 'U'
		   )
DROP TABLE shipping_method 
GO



create table shipping_method(
	shippingmethod_id_sk int identity(1,1)  primary key , --surrgoate key
	shippingmethod_id_Bk int ,                            --business key 
    Method_Name VARCHAR(100),
	start_date datetime not null default(getdate()),		--SCD	
	end_date datetime null,									--SCD
	is_current tinyint not null)                            --SCD