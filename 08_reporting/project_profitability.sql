-- =========================================
-- project_profitability.sql
-- Enterprise-Safe Version
-- =========================================
CREATE OR REPLACE VIEW vw_project_profitability AS

WITH revenue AS (
    SELECT 
        so.project_id,
        SUM(soi.total_price) AS total_revenue
    FROM sales_orders so
    JOIN sales_order_items soi ON so.so_id = soi.so_id
    GROUP BY so.project_id
),
costs AS (
    SELECT 
        pr.project_id,
        SUM(pri.total_price) AS total_cost
    FROM purchase_requests pr
    JOIN purchase_request_items pri ON pr.pr_id = pri.pr_id
    GROUP BY pr.project_id
)

SELECT
    p.project_id,
    p.project_name,
    NVL(r.total_revenue, 0) AS total_revenue,
    NVL(c.total_cost, 0) AS total_cost,
    NVL(r.total_revenue, 0) - NVL(c.total_cost, 0) AS profit
FROM projects p
LEFT JOIN revenue r ON p.project_id = r.project_id
LEFT JOIN costs c ON p.project_id = c.project_id
ORDER BY profit DESC;