/*
  Warnings:

  - You are about to drop the `order_table` table. If the table is not empty, all the data it contains will be lost.

*/
BEGIN TRY

BEGIN TRAN;

-- DropTable
DROP TABLE [dbo].[order_table];

-- CreateTable
CREATE TABLE [dbo].[order] (
    [id] INT NOT NULL IDENTITY(1,1),
    [order_no] VARCHAR(30) NOT NULL,
    [line_no] VARCHAR(4) NOT NULL,
    [goods_cd] VARCHAR(10) NOT NULL,
    [parent_goods_cd] VARCHAR(10) NOT NULL,
    [goods_nm] VARCHAR(20) NOT NULL,
    [qty] INT NOT NULL,
    CONSTRAINT [order_pkey] PRIMARY KEY CLUSTERED ([id])
);

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
