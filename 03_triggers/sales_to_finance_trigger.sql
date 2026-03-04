-- =========================================
-- sales_to_finance_trigger.sql
-- Author: Fahimeh Latifi
-- Description: Trigger to auto-post Sales Orders to Finance (Ledger & Sub Accounts)
-- =========================================

-- Trigger: After inserting a new sales order, automatically post ledger entries
CREATE OR REPLACE TRIGGER trg_sales_to_finance
AFTER INSERT ON sales_orders
FOR EACH ROW
DECLARE
    v_sub_code VARCHAR2(30);
BEGIN
    -- Define sub account for sales order
    v_sub_code := 'SO' || :NEW.so_id;

    -- Insert sub_account if not exists
    BEGIN
        INSERT INTO sub_accounts(sub_code, sub_name, sub_type, description)
        VALUES(v_sub_code, 'Sales Order '|| :NEW.so_id, 'ORDER', 'Auto-created for Sales Order');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            NULL; -- already exists
    END;

    -- Post total_amount to ledger as debit (customer owes us)
    INSERT INTO account_ledger(
        account_code,
        sub_code,
        reference_type,
        reference_id,
        debit_amount,
        credit_amount,
        entry_date,
        description
    )
    VALUES(
        '4000',           -- Sales Revenue Account
        v_sub_code,
        'SALES_ORDER',
        :NEW.so_id,
        :NEW.total_amount,
        0,
        SYSDATE,
        'Auto-posted from Sales Order'
    );
END;
/