-- =========================================
-- 02_sales_data.sql
-- Sample Data for Sales Orders & Items
-- =========================================

-- Sales Orders
INSERT INTO sales_orders(project_id, order_date, total_amount, status, created_by, description)
VALUES(1, TO_DATE('2026-02-01','YYYY-MM-DD'), 25000,'PENDING','Alice','Initial ERP License');

INSERT INTO sales_orders(project_id, order_date, total_amount, status, created_by, description)
VALUES(2, TO_DATE('2026-02-05','YYYY-MM-DD'), 15000,'PENDING','Bob','Engineering Materials');

-- Sales Order Items
INSERT INTO sales_order_items(so_id, product_code, item_desc, quantity, unit_price, total_price)
VALUES(1,'PROD001','ERP Software License',2,10000,20000);

INSERT INTO sales_order_items(so_id, product_code, item_desc, quantity, unit_price, total_price)
VALUES(1,'SERV001','ERP Setup Service',1,5000,5000);

INSERT INTO sales_order_items(so_id, product_code, item_desc, quantity, unit_price, total_price)
VALUES(2,'ENG001','Mechanical Parts',10,1000,10000);

INSERT INTO sales_order_items(so_id, product_code, item_desc, quantity, unit_price, total_price)
VALUES(2,'ENG002','Design Consultation',1,5000,5000);