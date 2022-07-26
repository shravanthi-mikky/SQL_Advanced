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
