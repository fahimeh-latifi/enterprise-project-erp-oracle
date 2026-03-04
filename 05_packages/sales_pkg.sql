-- =========================================
-- sales_pkg.sql
-- Author: Fahimeh Latifi
-- Description: PL/SQL Package for Sales Orders Module
-- =========================================

CREATE OR REPLACE PACKAGE sales_pkg AS
    -- Create a sales order with multiple items
    PROCEDURE create_sales_order(
        p_project_id IN NUMBER,
        p_items IN SYS.ODCIVARCHAR2LIST,
        p_quantities IN SYS.ODCINUMBERLIST,
        p_unit_prices IN SYS.ODCINUMBERLIST
    );

    -- Update sales order status
    PROCEDURE update_sales_order_status(
        p_so_id IN NUMBER,
        p_status IN VARCHAR2
    );
END sales_pkg;
/

CREATE OR REPLACE PACKAGE BODY sales_pkg AS

    PROCEDURE create_sales_order(
        p_project_id IN NUMBER,
        p_items IN SYS.ODCIVARCHAR2LIST,
        p_quantities IN SYS.ODCINUMBERLIST,
        p_unit_prices IN SYS.ODCINUMBERLIST
    ) IS
        v_total NUMBER := 0;
        v_so_id NUMBER;
    BEGIN
        -- Insert sales order header
        INSERT INTO sales_orders(project_id, order_date, total_amount, status, created_by)
        VALUES(p_project_id, SYSDATE, 0, 'PENDING', USER)
        RETURNING so_id INTO v_so_id;

        -- Insert items
        FOR i IN 1..p_items.COUNT LOOP
            INSERT INTO sales_order_items(so_id, product_code, item_desc, quantity, unit_price, total_price)
            VALUES(v_so_id, p_items(i), p_items(i), p_quantities(i), p_unit_prices(i), p_quantities(i) * p_unit_prices(i));
            v_total := v_total + (p_quantities(i) * p_unit_prices(i));
        END LOOP;

        -- Update total_amount in header
        UPDATE sales_orders SET total_amount = v_total WHERE so_id = v_so_id;
    END create_sales_order;

    PROCEDURE update_sales_order_status(
        p_so_id IN NUMBER,
        p_status IN VARCHAR2
    ) IS
    BEGIN
        UPDATE sales_orders SET status = p_status WHERE so_id = p_so_id;
    END update_sales_order_status;

END sales_pkg;
/