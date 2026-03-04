-- =========================================
-- indexing_strategy.sql
-- Author: Fahimeh Latifi
-- Description: Indexing Strategy Examples for Performance
-- =========================================

-- Index on frequently queried columns
CREATE INDEX idx_sales_orders_project ON sales_orders(project_id);

CREATE INDEX idx_sales_orders_status ON sales_orders(status);

CREATE INDEX idx_sales_order_items_product ON sales_order_items(product_code);

CREATE INDEX idx_purchase_requests_status ON purchase_requests(status);

CREATE INDEX idx_account_ledger_subcode ON account_ledger(sub_code);

-- Composite Index Example
CREATE INDEX idx_sales_order_items_so_product ON sales_order_items(so_id, product_code);