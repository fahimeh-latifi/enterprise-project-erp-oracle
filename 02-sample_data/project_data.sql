-- =========================================
-- 01_projects_data.sql
-- Sample Data for Projects & Contracts
-- =========================================

-- Business Parties
INSERT INTO business_parties(party_code, party_name, party_type, tax_id, contact_info)
VALUES('CUST001','ABC Corporation','CUSTOMER','TAX123','abc@example.com');

INSERT INTO business_parties(party_code, party_name, party_type, tax_id, contact_info)
VALUES('SUPP001','XYZ Supplies','SUPPLIER','TAX456','xyz@example.com');

INSERT INTO business_parties(party_code, party_name, party_type, tax_id, contact_info)
VALUES('CONT001','John Contractor','CONTRACTOR','TAX789','john.contractor@example.com');

-- Contracts
INSERT INTO contracts(contract_number, party_id, contract_amount, start_date, end_date, status, description)
VALUES('CNTR001',1,100000,TO_DATE('2026-01-01','YYYY-MM-DD'),TO_DATE('2026-12-31','YYYY-MM-DD'),'ACTIVE','ERP Implementation');

INSERT INTO contracts(contract_number, party_id, contract_amount, start_date, end_date, status, description)
VALUES('CNTR002',3,50000,TO_DATE('2026-02-01','YYYY-MM-DD'),TO_DATE('2026-08-31','YYYY-MM-DD'),'ACTIVE','Engineering Project');

-- Projects
INSERT INTO projects(project_code, contract_id, project_name, budget_amount, start_date, end_date, status, description)
VALUES('PROJ001',1,'ERP Setup',80000,TO_DATE('2026-01-05','YYYY-MM-DD'),TO_DATE('2026-12-15','YYYY-MM-DD'),'ACTIVE','Core ERP Module');

INSERT INTO projects(project_code, contract_id, project_name, budget_amount, start_date, end_date, status, description)
VALUES('PROJ002',2,'Design & Implementation',45000,TO_DATE('2026-02-10','YYYY-MM-DD'),TO_DATE('2026-08-20','YYYY-MM-DD'),'ACTIVE','Engineering Module');