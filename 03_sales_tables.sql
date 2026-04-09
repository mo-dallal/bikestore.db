-- ============================================================
--  Step 3: Sales Tables
--  stores → customers → staffs → orders → order_items
-- ============================================================

USE BikeStore;
GO

-- Sales.stores
IF OBJECT_ID('Sales.stores', 'U') IS NULL
BEGIN
    CREATE TABLE Sales.stores
    (
        store_id    INT           NOT NULL IDENTITY(1,1),
        store_name  NVARCHAR(255) NOT NULL,
        phone       VARCHAR(25)       NULL,
        email       NVARCHAR(255)     NULL,
        street      NVARCHAR(255)     NULL,
        city        NVARCHAR(255)     NULL,
        state       CHAR(2)           NULL,
        zip_code    VARCHAR(10)       NULL,
        CONSTRAINT PK_stores      PRIMARY KEY CLUSTERED (store_id),
        CONSTRAINT UQ_stores_name UNIQUE (store_name)
    );
    PRINT 'Sales.stores created.';
END
GO

-- Sales.customers
IF OBJECT_ID('Sales.customers', 'U') IS NULL
BEGIN
    CREATE TABLE Sales.customers
    (
        customer_id  INT           NOT NULL IDENTITY(1,1),
        first_name   NVARCHAR(255) NOT NULL,
        last_name    NVARCHAR(255) NOT NULL,
        phone        VARCHAR(25)       NULL,
        email        NVARCHAR(255) NOT NULL,
        street       NVARCHAR(255)     NULL,
        city         NVARCHAR(255)     NULL,
        state        CHAR(2)           NULL,
        zip_code     VARCHAR(10)       NULL,
        CONSTRAINT PK_customers       PRIMARY KEY CLUSTERED (customer_id),
        CONSTRAINT UQ_customers_email UNIQUE (email)
    );
    PRINT 'Sales.customers created.';
END
GO

-- Sales.staffs
IF OBJECT_ID('Sales.staffs', 'U') IS NULL
BEGIN
    CREATE TABLE Sales.staffs
    (
        staff_id    INT           NOT NULL IDENTITY(1,1),
        first_name  NVARCHAR(255) NOT NULL,
        last_name   NVARCHAR(255) NOT NULL,
        email       NVARCHAR(255) NOT NULL,
        phone       VARCHAR(25)       NULL,
        active      TINYINT       NOT NULL DEFAULT 1,
        store_id    INT           NOT NULL,
        manager_id  INT               NULL,

        CONSTRAINT PK_staffs        PRIMARY KEY CLUSTERED (staff_id),
        CONSTRAINT UQ_staffs_email  UNIQUE (email),
        CONSTRAINT CK_staffs_active CHECK (active IN (0,1)),

        CONSTRAINT FK_staffs_stores
            FOREIGN KEY (store_id)
            REFERENCES Sales.stores (store_id)
            ON UPDATE CASCADE ON DELETE NO ACTION,

        CONSTRAINT FK_staffs_manager
            FOREIGN KEY (manager_id)
            REFERENCES Sales.staffs (staff_id)
            ON UPDATE NO ACTION ON DELETE NO ACTION
    );
    PRINT 'Sales.staffs created.';
END
GO

-- Sales.orders
IF OBJECT_ID('Sales.orders', 'U') IS NULL
BEGIN
    CREATE TABLE Sales.orders
    (
        order_id       INT     NOT NULL IDENTITY(1,1),
        customer_id    INT         NULL,
        order_status   TINYINT NOT NULL,
        order_date     DATE    NOT NULL,
        required_date  DATE    NOT NULL,
        shipped_date   DATE        NULL,
        store_id       INT     NOT NULL,
        staff_id       INT     NOT NULL,

        CONSTRAINT PK_orders       PRIMARY KEY CLUSTERED (order_id),
        CONSTRAINT CK_order_status CHECK (order_status IN (1,2,3,4)),

        CONSTRAINT FK_orders_customers
            FOREIGN KEY (customer_id)
            REFERENCES Sales.customers (customer_id)
            ON UPDATE NO ACTION ON DELETE SET NULL,

        CONSTRAINT FK_orders_stores
            FOREIGN KEY (store_id)
            REFERENCES Sales.stores (store_id)
            ON UPDATE CASCADE ON DELETE NO ACTION,

        CONSTRAINT FK_orders_staffs
            FOREIGN KEY (staff_id)
            REFERENCES Sales.staffs (staff_id)
            ON UPDATE NO ACTION ON DELETE NO ACTION
    );
    PRINT 'Sales.orders created.';
END
GO

-- Production.stocks  (هون لأنها تحتاج Sales.stores + Production.products)
IF OBJECT_ID('Production.stocks', 'U') IS NULL
BEGIN
    CREATE TABLE Production.stocks
    (
        store_id    INT NOT NULL,
        product_id  INT NOT NULL,
        quantity    INT NOT NULL DEFAULT 0,

        CONSTRAINT PK_stocks   PRIMARY KEY CLUSTERED (store_id, product_id),
        CONSTRAINT CK_quantity CHECK (quantity >= 0),

        CONSTRAINT FK_stocks_products
            FOREIGN KEY (product_id)
            REFERENCES Production.products (product_id)
            ON UPDATE CASCADE ON DELETE CASCADE,

        CONSTRAINT FK_stocks_stores
            FOREIGN KEY (store_id)
            REFERENCES Sales.stores (store_id)
            ON UPDATE CASCADE ON DELETE CASCADE
    );
    PRINT 'Production.stocks created.';
END
GO

-- Sales.order_items
IF OBJECT_ID('Sales.order_items', 'U') IS NULL
BEGIN
    CREATE TABLE Sales.order_items
    (
        order_id    INT           NOT NULL,
        item_id     INT           NOT NULL,
        product_id  INT           NOT NULL,
        quantity    INT           NOT NULL,
        list_price  DECIMAL(10,2) NOT NULL,
        discount    DECIMAL(4,2)  NOT NULL DEFAULT 0,

        CONSTRAINT PK_order_items PRIMARY KEY CLUSTERED (order_id, item_id),
        CONSTRAINT CK_oi_quantity CHECK (quantity > 0),
        CONSTRAINT CK_oi_discount CHECK (discount BETWEEN 0 AND 1),

        CONSTRAINT FK_order_items_orders
            FOREIGN KEY (order_id)
            REFERENCES Sales.orders (order_id)
            ON UPDATE CASCADE ON DELETE CASCADE,

        CONSTRAINT FK_order_items_products
            FOREIGN KEY (product_id)
            REFERENCES Production.products (product_id)
            ON UPDATE NO ACTION ON DELETE NO ACTION
    );
    PRINT 'Sales.order_items created.';
END
GO
