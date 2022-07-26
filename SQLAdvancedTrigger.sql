USE [Product]
GO
/****** Object:  Trigger [dbo].[product_deatils_backup]    Script Date: 7/26/2022 10:51:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[product_deatils_backup]
ON [dbo].[product_deatils]
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO product_deatils_backup1(
        productid, 
        productname,
        quantity, 
		price,
        operation
    )
    SELECT
        i.productid,
        productname,
        quantity, 
        i.price,
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.productid,
        productname,
        quantity,
        d.price,
        'DEL'
    FROM
        deleted d;
END