-- =========================================
-- 03_procurement_data.sql
-- Sample Data for Purchase Requests & Approval Workflow
-- =========================================

-- Purchase Requests
INSERT INTO purchase_requests(project_id, request_date, requested_by, total_amount, status, description)
VALUES(1, TO_DATE('2026-02-03','YYYY-MM-DD'),'Alice',12000,'PENDING_L1','Request for ERP Servers');

INSERT INTO purchase_requests(project_id, request_date, requested_by, total_amount, status, description)
VALUES(2, TO_DATE('2026-02-06','YYYY-MM-DD'),'Bob',7000,'PENDING_L1','Request for Engineering Materials');

-- Purchase Request Items
INSERT INTO purchase_request_items(pr_id, item_code, item_desc, quantity, unit_price, total_price)
VALUES(1,'SRV001','Server Rack',2,5000,10000);

INSERT INTO purchase_request_items(pr_id, item_code, item_desc, quantity, unit_price, total_price)
VALUES(1,'SRV002','UPS Backup',2,1000,2000);

INSERT INTO purchase_request_items(pr_id, item_code, item_desc, quantity, unit_price, total_price)
VALUES(2,'ENG001','Mechanical Parts',10,500,5000);

INSERT INTO purchase_request_items(pr_id, item_code, item_desc, quantity, unit_price, total_price)
VALUES(2,'ENG002','Design Consultation',1,2000,2000);

-- Approval Workflow
INSERT INTO pr_approval(pr_id, level_no, approver_name, approved_flag, approved_date, comments)
VALUES(1,1,'Manager L1','Y',TO_DATE('2026-02-04','YYYY-MM-DD'),'Approved at L1');

INSERT INTO pr_approval(pr_id, level_no, approver_name, approved_flag, approved_date, comments)
VALUES(1,2,'Manager L2','N',NULL,NULL);

INSERT INTO pr_approval(pr_id, level_no, approver_name, approved_flag, approved_date, comments)
VALUES(2,1,'Manager L1','Y',TO_DATE('2026-02-07','YYYY-MM-DD'),'Approved at L1');