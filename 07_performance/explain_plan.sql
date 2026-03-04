-- =========================================
-- explain_plan.sql
-- Author: Fahimeh Latifi
-- Description: Example Explain Plan Queries
-- =========================================
-- Step 1: Baseline Query (Before Index)
EXPLAIN PLAN FOR
SELECT so.so_id, so.total_amount, soi.item_desc, soi.quantity
FROM sales_orders so
JOIN sales_order_items soi ON so.so_id = soi.so_id
WHERE so.project_id = 1
ORDER BY so.order_date;

SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'TYPICAL +COST +BYTES +CARDINALITY'));


-- Step 2: Create Supporting Index

CREATE INDEX idx_sales_orders_project 
ON sales_orders(project_id);


-- Step 3: Re-run Explain Plan After Index

EXPLAIN PLAN FOR
SELECT so.so_id, so.total_amount, soi.item_desc, soi.quantity
FROM sales_orders so
JOIN sales_order_items soi ON so.so_id = soi.so_id
WHERE so.project_id = 1
ORDER BY so.order_date;

SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'TYPICAL +COST +BYTES +CARDINALITY'));