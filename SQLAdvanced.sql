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

delete from product_deatils where productid=1;

--STORED PROCEDURE IMPLEMENTING ERROR HANDLING---
CREATE or alter PROCEDURE INSERT_VALUES_ERROR_HANDLING @PRODUCT_NAME VARCHAR(100),@QUANTITY INT,@PRICE INT
AS
BEGIN
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
exec INSERT_VALUES_ERROR_HANDLING @PRODUCT_NAME='Chairs',@QUANTITY= 'abc',@PRICE=5000;
--exception handling----
BEGIN TRY
	BEGIN TRANSACTION
			INSERT INTO product_deatils VALUES ('chalks','abc',1000)
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT(error_message())
		rollback TRANSACTION
	END CATCH
