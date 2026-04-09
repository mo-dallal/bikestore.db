# 🚲 BikeStore Database

A complete SQL Server relational database for a multi-branch bike store, built with a **dual-schema architecture** (Production / Sales) supporting inventory management, orders, staff, and customers.

---

## Overview

**BikeStore** is a relational database project written for **Microsoft SQL Server**. It simulates a full bike store management system across multiple branches, covering product catalogs, inventory tracking, customer records, staff hierarchy, and order processing — with ready-to-use sample data for testing.

---

## File Structure

```
bikestore.db/
├── 01_create_database.sql   # Creates the database and schemas
├── 02_production_tables.sql # Production schema tables (brands, categories, products)
├── 03_sales_tables.sql      # Sales schema tables (stores, customers, staffs, orders)
├── 04_indexes.sql           # Performance indexes
├── 05_sample_data.sql       # Sample data for testing
└── 06_validate.sql          # Validation queries to verify the build
```

---

## Database Schema

### Schema: `Production`

| Table | Description |
|-------|-------------|
| `Production.brands` | Bike brands (Trek, Electra, Haro, ...) |
| `Production.categories` | Product categories (Mountain, Road, Electric, ...) |
| `Production.products` | Products with price and model year |
| `Production.stocks` | Inventory quantities per product per store |

### Schema: `Sales`

| Table | Description |
|-------|-------------|
| `Sales.stores` | Store branches with address and contact info |
| `Sales.customers` | Customer records |
| `Sales.staffs` | Staff with self-referencing manager hierarchy |
| `Sales.orders` | Orders with status and dates |
| `Sales.order_items` | Order line items with quantity and discount |

---

## Entity Relationships (ERD)

```
Production.brands ──────────┐
                             ├──► Production.products ◄──── Production.categories
                             │           │
                             │           ▼
                        Production.stocks
                             │
Sales.stores ────────────────┘
     │
     ├──► Sales.staffs ◄──── (self-ref: manager_id)
     │         │
     └──► Sales.orders ◄──── Sales.customers
               │
               └──► Sales.order_items ──► Production.products
```

---

## Indexes

| Index | Table | Purpose |
|-------|-------|---------|
| `IX_customers_last_name` | Sales.customers | Search by customer name |
| `IX_orders_customer_date` | Sales.orders | Orders per customer by date |
| `IX_orders_store_status` | Sales.orders | Store orders filtered by status |
| `IX_order_items_product` | Sales.order_items | Line items for a given product |
| `IX_products_category_brand` | Production.products | Filter by category and brand |
| `IX_stocks_product` | Production.stocks | Stock levels across stores |

---

## Getting Started

> **Requirements:** Microsoft SQL Server 2016 or later + SSMS or Azure Data Studio.

Run the scripts **in order**:

```sql
-- 1. Run against the master database first
01_create_database.sql

-- 2. Run the rest against the BikeStore database
02_production_tables.sql
03_sales_tables.sql
04_indexes.sql
05_sample_data.sql

-- 3. Verify the build
06_validate.sql
```

> **Note:** `01_create_database.sql` must be executed against the `master` database, not BikeStore.

---

## Sample Data

| Table | Rows |
|-------|------|
| brands | 9 |
| categories | 7 |
| products | 5 |
| stores | 3 (CA, NY, TX) |
| staffs | 4 |
| customers | 4 |
| orders | 4 |
| order_items | 5 |
| stocks | 15 |

---

## Order Status Values

| Value | Status |
|-------|--------|
| 1 | Pending |
| 2 | Processing |
| 3 | Rejected |
| 4 | Completed |

---

## Constraints & Data Integrity

- `CHECK` on `list_price >= 0` and `quantity >= 0`
- `CHECK` on `discount BETWEEN 0 AND 1`
- `UNIQUE` on brand names, category names, product names, store names, and email addresses
- `ON DELETE CASCADE` on `stocks` and `order_items`
- `ON DELETE SET NULL` on orders when a customer is deleted

---

## Use Cases

This project can be used as:
- A learning resource for SQL Server and T-SQL
- A training project for basic ERP-style systems
- A starting point for building a real retail application

---

**Author:** [mo-dallal](https://github.com/mo-dallal)
