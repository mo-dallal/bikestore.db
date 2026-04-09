-- ============================================================
--  Step 2: Production Tables
--  brands → categories → products → stocks
-- ============================================================

USE BikeStore;
GO

-- Production.brands
IF OBJECT_ID('Production.brands', 'U') IS NULL
BEGIN
    CREATE TABLE Production.brands
    (
        brand_id    INT           NOT NULL IDENTITY(1,1),
        brand_name  NVARCHAR(255) NOT NULL,
        CONSTRAINT PK_brands      PRIMARY KEY CLUSTERED (brand_id),
        CONSTRAINT UQ_brands_name UNIQUE (brand_name)
    );
    PRINT 'Production.brands created.';
END
GO

-- Production.categories
IF OBJECT_ID('Production.categories', 'U') IS NULL
BEGIN
    CREATE TABLE Production.categories
    (
        category_id    INT           NOT NULL IDENTITY(1,1),
        category_name  NVARCHAR(255) NOT NULL,
        CONSTRAINT PK_categories      PRIMARY KEY CLUSTERED (category_id),
        CONSTRAINT UQ_categories_name UNIQUE (category_name)
    );
    PRINT 'Production.categories created.';
END
GO

-- Production.products
IF OBJECT_ID('Production.products', 'U') IS NULL
BEGIN
    CREATE TABLE Production.products
    (
        product_id    INT           NOT NULL IDENTITY(1,1),
        product_name  NVARCHAR(255) NOT NULL,
        brand_id      INT           NOT NULL,
        category_id   INT           NOT NULL,
        model_year    SMALLINT      NOT NULL,
        list_price    DECIMAL(10,2) NOT NULL,

        CONSTRAINT PK_products      PRIMARY KEY CLUSTERED (product_id),
        CONSTRAINT UQ_products_name UNIQUE (product_name),
        CONSTRAINT CK_list_price    CHECK (list_price >= 0),

        CONSTRAINT FK_products_brands
            FOREIGN KEY (brand_id)
            REFERENCES Production.brands (brand_id)
            ON UPDATE CASCADE ON DELETE NO ACTION,

        CONSTRAINT FK_products_categories
            FOREIGN KEY (category_id)
            REFERENCES Production.categories (category_id)
            ON UPDATE CASCADE ON DELETE NO ACTION
    );
    PRINT 'Production.products created.';
END
GO
