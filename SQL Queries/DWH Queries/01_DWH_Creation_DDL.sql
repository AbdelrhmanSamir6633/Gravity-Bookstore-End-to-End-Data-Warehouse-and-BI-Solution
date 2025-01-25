
-- Check if there is a previous DWH that's name is Gravity_BookStore_DWH or not:

IF EXISTS (
		   SELECT 
				name 
           FROM 
				sys.databases 
           WHERE 
				name = 'Gravity_BookStore_DWH'
		  )
DROP DATABASE Gravity_BookStore_DWH


--Create a new DWH:

CREATE DATABASE Gravity_BookStore_DWH


