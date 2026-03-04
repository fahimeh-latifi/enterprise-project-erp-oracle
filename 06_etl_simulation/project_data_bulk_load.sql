-- =========================================
-- project_data_bulk_load.sql
-- Author: Fahimeh Latifi
-- Description: Simulate bulk load of project-related data for ETL/Analytics
-- =========================================

-- -----------------------------
-- Step 1: Generate sample projects
-- -----------------------------
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO projects(project_code, contract_id, project_name, budget_amount, start_date, end_date, status, description)
        VALUES(
            'PRJ'||LPAD(i,3,'0'),
            MOD(i,10)+1, -- sample contract_id
            'Project '||i,
            50000 + DBMS_RANDOM.VALUE(0,100000),
            ADD_MONTHS(SYSDATE, -DBMS_RANDOM.VALUE(0,12)),
            ADD_MONTHS(SYSDATE, DBMS_RANDOM.VALUE(1,24)),
            'ACTIVE',
            'Generated sample project for ETL load'
        );
    END LOOP;
    COMMIT;
END;
/

-- -----------------------------
-- Step 2: Generate sample sales orders
-- -----------------------------
DECLARE
    v_items SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('ITEM001','ITEM002','ITEM003','ITEM004','ITEM005');
    v_quantities SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(10,5,2,7,1);
    v_unit_prices SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(100,200,50,150,300);
BEGIN
    FOR i IN 1..50 LOOP
        sales_pkg.create_sales_order(
            p_project_id => MOD(i,50)+1,
            p_items => v_items,
            p_quantities => v_quantities,
            p_unit_prices => v_unit_prices
        );
    END LOOP;
END;
/

-- -----------------------------
-- Step 3: Generate sample purchase requests
-- -----------------------------
DECLARE
    v_items SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('MAT001','MAT002','MAT003','MAT004','MAT005');
    v_quantities SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(20,15,5,10,8);
    v_unit_prices SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(50,30,100,25,200);
BEGIN
    FOR i IN 1..30 LOOP
        procurement_pkg.create_purchase_request(
            p_project_id => MOD(i,50)+1,
            p_items => v_items,
            p_quantities => v_quantities,
            p_unit_prices => v_unit_prices
        );
    END LOOP;
END;
/

-- -----------------------------
-- Step 4: Optional - Post payments for some sales orders
-- -----------------------------
BEGIN
    FOR i IN 1..30 LOOP
        finance_pkg.post_payment(
            p_reference_type => 'SALES_ORDER',
            p_reference_id => i,
            p_amount => 1000 + DBMS_RANDOM.VALUE(0,5000),
            p_payment_method => 'Credit Card'
        );
    END LOOP;
END;
/