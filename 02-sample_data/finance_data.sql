-- =========================================
-- 04_finance_data.sql
-- Sample Data for Ledger, Sub Accounts, Payments & Shipments
-- =========================================

-- Sub Accounts
INSERT INTO sub_accounts(sub_code, sub_name, sub_type, description)
VALUES('CUST001','ABC Corporation','PARTY','Customer Account');

INSERT INTO sub_accounts(sub_code, sub_name, sub_type, description)
VALUES('PROJ001','ERP Setup','PROJECT','ERP Project Sub Account');

INSERT INTO sub_accounts(sub_code, sub_name, sub_type, description)
VALUES('SO001','Sales Order 1','ORDER','Sales Order Account');

-- Ledger Entries
INSERT INTO account_ledger(account_code, sub_code, reference_type, reference_id, debit_amount, credit_amount, entry_date, description)
VALUES('4000','CUST001','SALES_ORDER',1,25000,0,TO_DATE('2026-02-01','YYYY-MM-DD'),'Invoice ERP License');

INSERT INTO account_ledger(account_code, sub_code, reference_type, reference_id, debit_amount, credit_amount, entry_date, description)
VALUES('2000','CUST001','PAYMENT',1,0,25000,TO_DATE('2026-02-02','YYYY-MM-DD'),'Payment Received');

-- Payments
INSERT INTO payments(reference_type, reference_id, payment_date, amount, payment_method, status, description)
VALUES('SALES_ORDER',1,TO_DATE('2026-02-02','YYYY-MM-DD'),25000,'Wire Transfer','COMPLETED','ERP License Payment');

-- Shipments
INSERT INTO shipments(so_id, shipped_date, delivery_date, shipment_status, carrier_name, tracking_no, description)
VALUES(1,TO_DATE('2026-02-03','YYYY-MM-DD'),TO_DATE('2026-02-05','YYYY-MM-DD'),'SHIPPED','FedEx','TRK123','ERP Software Delivery');