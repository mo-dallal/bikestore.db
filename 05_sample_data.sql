-- ============================================================
--  Step 5: Sample Data
-- ============================================================

USE BikeStore;
GO

INSERT INTO Production.brands (brand_name) VALUES
('Trek'),('Electra'),('Haro'),('Heller'),
('Pure Cycles'),('Ritchey'),('Strider'),('Sun Bicycles'),('Surly');
GO

INSERT INTO Production.categories (category_name) VALUES
('Children Bicycles'),('Comfort Bicycles'),('Cruisers Bicycles'),
('Cyclocross Bicycles'),('Electric Bikes'),('Mountain Bikes'),('Road Bikes');
GO

INSERT INTO Production.products (product_name, brand_id, category_id, model_year, list_price) VALUES
('Trek 820 - 2016',          1, 6, 2016, 379.99),
('Electra Townie 7D EQ',     2, 2, 2020, 619.99),
('Haro Flightline One ST',   3, 6, 2019, 299.99),
('Heller Shagamaw Frame',    4, 6, 2019, 4999.99),
('Pure Cycles Vine 8-Speed', 5, 7, 2020, 499.99);
GO

INSERT INTO Sales.stores (store_name, phone, email, street, city, state, zip_code) VALUES
('Santa Cruz Bikes', '(831) 476-4321', 'santacruz@bikes.shop', '3700 Portola Dr',   'Santa Cruz', 'CA', '95060'),
('Baldwin Bikes',    '(516) 379-8888', 'baldwin@bikes.shop',   '4200 Merrick Rd',   'Massapequa', 'NY', '11758'),
('Rowlett Bikes',    '(972) 530-5555', 'rowlett@bikes.shop',   '8000 Boat Club Rd', 'Rowlett',    'TX', '75088');
GO

INSERT INTO Production.stocks (store_id, product_id, quantity) VALUES
(1,1,27),(1,2,5),(1,3,10),(1,4,2),(1,5,8),
(2,1,10),(2,2,0),(2,3,8), (2,4,0),(2,5,5),
(3,1,3), (3,2,8),(3,3,15),(3,4,1),(3,5,12);
GO

INSERT INTO Sales.staffs (first_name, last_name, email, phone, active, store_id, manager_id) VALUES
('Fabiola', 'Jackson', 'fabiola.jackson@bikes.shop', '(831) 555-0101', 1, 1, NULL),
('Mireya',  'Copeland','mireya.copeland@bikes.shop', '(831) 555-0102', 1, 1, 1),
('Genna',   'Serrano', 'genna.serrano@bikes.shop',   '(516) 555-0201', 1, 2, NULL),
('Virgie',  'Castro',  'virgie.castro@bikes.shop',   '(972) 555-0301', 1, 3, NULL);
GO

INSERT INTO Sales.customers (first_name, last_name, phone, email, street, city, state, zip_code) VALUES
('Debra',  'Burks',  NULL,             'debra.burks@email.com',   '9273 Thorne Ave', 'Orchard Park', 'NY', '14127'),
('Kasha',  'Todd',   '(716) 555-0001', 'kasha.todd@email.com',    '6 Doughty St',    'Wantagh',      'NY', '11793'),
('Tameka', 'Fisher', '(831) 555-0301', 'tameka.fisher@email.com', '32 Elm St',       'Santa Cruz',   'CA', '95060'),
('Tiffany','Thornton','(972) 555-0401','tiffany.t@email.com',     '51 Oak Lane',     'Rowlett',      'TX', '75088');
GO

INSERT INTO Sales.orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id) VALUES
(1, 4, '2025-01-10', '2025-01-17', '2025-01-14', 2, 2),
(2, 4, '2025-02-05', '2025-02-12', '2025-02-10', 1, 1),
(3, 1, '2025-04-01', '2025-04-08', NULL,          1, 2),
(4, 2, '2025-04-05', '2025-04-12', NULL,          3, 4);
GO

INSERT INTO Sales.order_items (order_id, item_id, product_id, quantity, list_price, discount) VALUES
(1, 1, 1, 1, 379.99, 0.00),
(1, 2, 3, 1, 299.99, 0.05),
(2, 1, 2, 2, 619.99, 0.10),
(3, 1, 5, 1, 499.99, 0.00),
(4, 1, 4, 1, 4999.99, 0.15);
GO

PRINT 'Sample data inserted successfully.';
GO
