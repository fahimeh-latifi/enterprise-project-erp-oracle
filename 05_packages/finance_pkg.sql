-- =========================================
-- finance_pkg.sql
-- Author: Fahimeh Latifi
-- Description: PL/SQL Package for Finance Module (Ledger, Payments, Shipments)
-- =========================================

CREATE OR REPLACE PACKAGE finance_pkg AS
    -- Post payment to ledger
    PROCEDURE post_payment(
        p_reference_type IN VARCHAR2,
        p_reference_id IN NUMBER,
        p_amount IN NUMBER,
        p_payment_method IN VARCHAR2
    );

    -- Post shipment
    PROCEDURE post_shipment(
        p_so_id IN NUMBER,
        p_carrier_name IN VARCHAR2,
        p_tracking_no IN VARCHAR2
    );
END finance_pkg;
/

CREATE OR REPLACE PACKAGE BODY finance_pkg AS

    PROCEDURE post_payment(
        p_reference_type IN VARCHAR2,
        p_reference_id IN NUMBER,
        p_amount IN NUMBER,
        p_payment_method IN VARCHAR2
    ) IS
        v_sub_code VARCHAR2(30);
    BEGIN
        -- Determine Sub Account
        IF p_reference_type = 'SALES_ORDER' THEN
            SELECT 'SO'||p_reference_id INTO v_sub_code FROM dual;
        ELSE
            v_sub_code := 'PR'||p_reference_id;
        END IF;

        -- Insert into Payments
        INSERT INTO payments(reference_type, reference_id, payment_date, amount, payment_method, status)
        VALUES(p_reference_type, p_reference_id, SYSDATE, p_amount, p_payment_method, 'COMPLETED');

        -- Insert into Ledger
        INSERT INTO account_ledger(account_code, sub_code, reference_type, reference_id, debit_amount, credit_amount, entry_date, description)
        VALUES('2000', v_sub_code, p_reference_type, p_reference_id, 0, p_amount, SYSDATE, 'Payment Posted');
    END post_payment;

    PROCEDURE post_shipment(
        p_so_id IN NUMBER,
        p_carrier_name IN VARCHAR2,
        p_tracking_no IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO shipments(so_id, shipped_date, delivery_date, shipment_status, carrier_name, tracking_no, description)
        VALUES(p_so_id, SYSDATE, SYSDATE+3, 'SHIPPED', p_carrier_name, p_tracking_no, 'Shipment Posted');
    END post_shipment;

END finance_pkg;
/