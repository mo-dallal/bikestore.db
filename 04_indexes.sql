-- ============================================================
--  Step 4: Indexes
-- ============================================================

USE BikeStore;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('Sales.customers') AND name = 'IX_customers_last_name')
    CREATE NONCLUSTERED INDEX IX_customers_last_name
        ON Sales.customers (last_name, first_name);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('Sales.orders') AND name = 'IX_orders_customer_date')
    CREATE NONCLUSTERED INDEX IX_orders_customer_date
        ON Sales.orders (customer_id, order_date DESC)
        INCLUDE (order_status, store_id, staff_id);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('Sales.orders') AND name = 'IX_orders_store_status')
    CREATE NONCLUSTERED INDEX IX_orders_store_status
        ON Sales.orders (store_id, order_status)
        INCLUDE (order_date, shipped_date);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('Sales.order_items') AND name = 'IX_order_items_product')
    CREATE NONCLUSTERED INDEX IX_order_items_product
        ON Sales.order_items (product_id)
        INCLUDE (quantity, list_price, discount);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('Production.products') AND name = 'IX_products_category_brand')
    CREATE NONCLUSTERED INDEX IX_products_category_brand
        ON Production.products (category_id, brand_id)
        INCLUDE (product_name, model_year, list_price);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('Production.stocks') AND name = 'IX_stocks_product')
    CREATE NONCLUSTERED INDEX IX_stocks_product
        ON Production.stocks (product_id)
        INCLUDE (store_id, quantity);
GO

PRINT 'All indexes created.';
GO
