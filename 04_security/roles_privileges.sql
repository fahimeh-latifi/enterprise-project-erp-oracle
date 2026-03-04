-- =========================================
-- roles_privileges.sql
-- Author: Fahimeh Latifi
-- Description: Roles and Privileges for ERP System
-- =========================================

-- -----------------------------
-- 1. Create Roles
-- -----------------------------
-- Read-only role for analysts
CREATE ROLE read_only_analyst;

-- Role for Sales team
CREATE ROLE sales_role;

-- Role for Procurement team
CREATE ROLE procurement_role;

-- Role for Finance team
CREATE ROLE finance_role;

-- Role for Project Management
CREATE ROLE project_manager_role;

-- Admin role
CREATE ROLE erp_admin_role;

-- -----------------------------
-- 2. Grant Privileges to Roles
-- -----------------------------
-- Read-only analyst
GRANT SELECT ON projects TO read_only_analyst;
GRANT SELECT ON contracts TO read_only_analyst;
GRANT SELECT ON sales_orders TO read_only_analyst;
GRANT SELECT ON sales_order_items TO read_only_analyst;
GRANT SELECT ON purchase_requests TO read_only_analyst;
GRANT SELECT ON purchase_request_items TO read_only_analyst;
GRANT SELECT ON account_ledger TO read_only_analyst;

-- Sales role
GRANT SELECT, INSERT, UPDATE ON sales_orders TO sales_role;
GRANT SELECT, INSERT, UPDATE ON sales_order_items TO sales_role;

-- Procurement role
GRANT SELECT, INSERT, UPDATE ON purchase_requests TO procurement_role;
GRANT SELECT, INSERT, UPDATE ON purchase_request_items TO procurement_role;
GRANT SELECT, INSERT, UPDATE ON pr_approval TO procurement_role;

-- Finance role
GRANT SELECT, INSERT, UPDATE, DELETE ON account_ledger TO finance_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON payments TO finance_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON shipments TO finance_role;

-- Project Manager role
GRANT SELECT, INSERT, UPDATE ON projects TO project_manager_role;
GRANT SELECT, INSERT, UPDATE ON contracts TO project_manager_role;

-- Admin role: full access
GRANT ALL PRIVILEGES TO erp_admin_role;

-- -----------------------------
-- 3. Create Users and Assign Roles
-- -----------------------------
-- Example Users
CREATE USER alice IDENTIFIED BY Alice123 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
CREATE USER bob IDENTIFIED BY Bob123 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
CREATE USER charlie IDENTIFIED BY Charlie123 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;

-- Assign Roles
GRANT read_only_analyst TO charlie;
GRANT sales_role TO alice;
GRANT procurement_role TO bob;
GRANT erp_admin_role TO alice;  -- Example: admin user

-- -----------------------------
-- 4. Optional: system privileges for roles (if needed)
-- -----------------------------
-- Example: allow roles to create session and use sequences
GRANT CREATE SESSION TO sales_role;
GRANT CREATE SESSION TO procurement_role;
GRANT CREATE SESSION TO finance_role;
GRANT CREATE SESSION TO project_manager_role;
GRANT CREATE SESSION TO read_only_analyst;