create database Product;
CREATE TABLE product_deatils (
	productid int identity(1,1) primary key,
    productname varchar(100),
    quantity int,
    price int,
);
SELECT * from product_deatils;

--CREATING VIEW 
CREATE VIEW details
AS
SELECT productid,price from product_deatils;
SELECT * FROM details;
--CREATING A STORED PROCEDURE AND EXECUTING IT--
CREATE PROCEDURE TO_VIEW_ID_NAME
AS
BEGIN
SELECT 
	productid, 
	productname
FROM 
	product_deatils
ORDER BY 
	productname;
END;
--EXECUTE STORED PROCEDURE--
EXECUTE TO_VIEW_ID_NAME;
CREATE PROCEDURE INSERT_ONLY_NAME
AS
BEGIN
INSERT INTO product_deatils(productname) VALUES('BOOK');
END;
EXECUTE INSERT_ONLY_NAME;
--CREATING TRIGGER AFTER INSERT AND DELETE EVENTS--

create table product_deatils_backup1(productid int, 
        productname varchar(100),
        quantity int, 
		price int,
        operation varchar(100) );
		
select * from  product_deatils_backup1;
Insert into product_deatils values('Bag',1,1000);

delete from product_deatils where productid=18;

--STORED PROCEDURE IMPLEMENTING ERROR HANDLING---nw
CREATE or alter PROCEDURE INSERT_VALUES_ERROR_HANDLING @PRODUCT_NAME VARCHAR(100),@QUANTITY INT,@PRICE INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO product_deatils VALUES (@PRODUCT_NAME,@QUANTITY,@PRICE)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT(error_message())
		rollback TRANSACTION
	END CATCH
END;
exec INSERT_VALUES_ERROR_HANDLING @PRODUCT_NAME=1000,@QUANTITY= 1,@PRICE=100;
--exception handling----w
BEGIN TRY
	BEGIN TRANSACTION
			INSERT INTO product_deatils VALUES ('chalks','abc',1000)
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_STATE() AS ErrorState,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
		rollback TRANSACTION
	END CATCH
---trial of error handling in stored procedure---nw
CREATE or alter PROCEDURE execute_catch
as
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
			select * from product_deatils;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_STATE() AS ErrorState,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
		
		rollback TRANSACTION
	END CATCH
END;
execute execute_catch 
select 10/0;
--to check if we have any indexes created for table----
--here productid is primary key and it automatically creates a clustered index in a table---
execute sp_helpindex product_deatils;

-- Indexes are used to retrieve data from the database more quickly.
-- Two main types of indexes Clustered(unique/primary keys),Nonclustered index(non-unique)--

---Using if else--
--declaring avariable and intializing it--
Declare @math int,@english int
set @math=95;
set @english=93
if(@math>28 and @english>35)
begin
	print 'Pass'
	declare @percentage float;
	set @percentage =((@math+@english)*100)/200;
	print concat('Your percentage :',@percentage);
end;
else 
begin
	print 'Fail';
end;
---- User defined scalar function--
create or  alter function dbo.TotalPrice(@column1 int,@column2 int)
returns int as
Begin
	return @column1*@column2;
end;

select * ,dbo.TotalPrice(price ,Quantity) as Total from product_deatils