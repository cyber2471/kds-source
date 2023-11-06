BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[profile] (
    [id] INT NOT NULL IDENTITY(1,1),
    [bio] NVARCHAR(1000),
    [userId] INT NOT NULL,
    CONSTRAINT [profile_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Profile_userId_key] UNIQUE NONCLUSTERED ([userId])
);

-- CreateTable
CREATE TABLE [dbo].[post] (
    [id] INT NOT NULL IDENTITY(1,1),
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [post_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    [title] VARCHAR(255) NOT NULL,
    [content] NVARCHAR(1000),
    [published] BIT NOT NULL CONSTRAINT [post_published_df] DEFAULT 0,
    [authorId] INT NOT NULL,
    CONSTRAINT [post_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[user] (
    [id] INT NOT NULL IDENTITY(1,1),
    [email] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000),
    [jsondata] VARCHAR(1000) NOT NULL,
    [updatedAt] DATETIME2 NOT NULL CONSTRAINT [user_updatedAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [user_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[status] (
    [id] INT NOT NULL IDENTITY(1,1),
    [bill_no] NVARCHAR(1000),
    [proc_fg] NVARCHAR(1000),
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [status_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [status_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[order_table] (
    [id] INT NOT NULL IDENTITY(1,1),
    [order_no] VARCHAR(30) NOT NULL,
    [line_no] VARCHAR(4) NOT NULL,
    [goods_cd] VARCHAR(10) NOT NULL,
    [parent_goods_cd] VARCHAR(10) NOT NULL,
    [goods_nm] VARCHAR(20) NOT NULL,
    [qty] INT NOT NULL,
    CONSTRAINT [order_table_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [Post_authorId_fkey] ON [dbo].[post]([authorId]);

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
