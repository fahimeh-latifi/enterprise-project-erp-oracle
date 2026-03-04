-- =========================================
-- aging_report.sql
-- Author: Fahimeh Latifi
-- Description: Accounts receivable aging report
-- =========================================

-- Create a view for AR Aging by project / customer
CREATE OR REPLACE VIEW vw_aging_report AS
SELECT
    so.so_id,
    p.project_name,
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    so.total_amount,
    SUM(NVL(pay.amount,0)) AS paid_amount,
    so.total_amount - SUM(NVL(pay.amount,0)) AS outstanding_amount,
    TRUNC(SYSDATE - so.order_date) AS days_overdue,
    CASE
        WHEN TRUNC(SYSDATE - so.order_date) <= 30 THEN '0-30 Days'
        WHEN TRUNC(SYSDATE - so.order_date) <= 60 THEN '31-60 Days'
        WHEN TRUNC(SYSDATE - so.order_date) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END AS aging_bucket
FROM sales_orders so
JOIN projects p ON so.project_id = p.project_id
JOIN customers c ON so.customer_id = c.customer_id
LEFT JOIN payments pay ON so.so_id = pay.reference_id AND pay.reference_type='SALES_ORDER'
GROUP BY so.so_id, p.project_name, c.customer_id, c.first_name, c.last_name, so.total_amount, so.order_date
ORDER BY aging_bucket, days_overdue DESC;