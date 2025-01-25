--1) Check if there is a previous FK called 'FK_FactSales_DIMBook' for Book Table, and Dropping it if exists:
IF EXISTS ( 
		   SELECT 
					* 
		   FROM
				sys.foreign_keys
		   WHERE 
				name = 'bookDim_fk'
		   AND 
				object_id = OBJECT_ID('Fact_Sales')
		  )

ALTER TABLE Fact_Sales 
DROP CONSTRAINT bookDim_fk
GO

--2) Check if there is a previous Dimension Table called 'DIM_Book', and Dropping it if exists:
IF EXISTS (
		   SELECT
					* 
		   FROM
				sys.tables
		   WHERE 
				name = 'book'
		   AND 
				type = 'U'
		  )
DROP TABLE book 
GO


create table book(
	book_id_sk int identity(1,1)  primary key , --surrgoate key
	book_id_Bk int ,                            --business key 
	title VARCHAR(400),
    isbn13 VARCHAR(13),
	num_pages INT,
    publication_date DATE,
	language_name VARCHAR(50),
	author_name VARCHAR(400),
	publisher_name VARCHAR(400),
	start_date datetime not null default(getdate()),		--SCD	
	end_date datetime null,									--SCD
	is_current tinyint not null)                            --SCD