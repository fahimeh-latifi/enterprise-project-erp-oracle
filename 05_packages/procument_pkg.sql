-- =========================================
-- procurement_pkg.sql
-- Author: Fahimeh Latifi
-- Description: PL/SQL Package for Purchase Requests Module
-- =========================================

CREATE OR REPLACE PACKAGE procurement_pkg AS
    -- Create purchase request with multiple items
    PROCEDURE create_purchase_request(
        p_project_id IN NUMBER,
        p_items IN SYS.ODCIVARCHAR2LIST,
        p_quantities IN SYS.ODCINUMBERLIST,
        p_unit_prices IN SYS.ODCINUMBERLIST
    );

    -- Approve a request at a given level
    PROCEDURE approve_request(
        p_pr_id IN NUMBER,
        p_level_no IN NUMBER,
        p_approver_name IN VARCHAR2,
        p_approved_flag IN CHAR,
        p_comments IN VARCHAR2
    );
END procurement_pkg;
/

CREATE OR REPLACE PACKAGE BODY procurement_pkg AS

    PROCEDURE create_purchase_request(
        p_project_id IN NUMBER,
        p_items IN SYS.ODCIVARCHAR2LIST,
        p_quantities IN SYS.ODCINUMBERLIST,
        p_unit_prices IN SYS.ODCINUMBERLIST
    ) IS
        v_total NUMBER := 0;
        v_pr_id NUMBER;
    BEGIN
        -- Insert purchase request header
        INSERT INTO purchase_requests(project_id, request_date, requested_by, total_amount, status)
        VALUES(p_project_id, SYSDATE, USER, 0, 'PENDING_L1')
        RETURNING pr_id INTO v_pr_id;

        -- Insert items
        FOR i IN 1..p_items.COUNT LOOP
            INSERT INTO purchase_request_items(pr_id, item_code, item_desc, quantity, unit_price, total_price)
            VALUES(v_pr_id, p_items(i), p_items(i), p_quantities(i), p_unit_prices(i), p_quantities(i) * p_unit_prices(i));
            v_total := v_total + (p_quantities(i) * p_unit_prices(i));
        END LOOP;

        -- Update total_amount in header
        UPDATE purchase_requests SET total_amount = v_total WHERE pr_id = v_pr_id;
    END create_purchase_request;

    PROCEDURE approve_request(
        p_pr_id IN NUMBER,
        p_level_no IN NUMBER,
        p_approver_name IN VARCHAR2,
        p_approved_flag IN CHAR,
        p_comments IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO pr_approval(pr_id, level_no, approver_name, approved_flag, comments)
        VALUES(p_pr_id, p_level_no, p_approver_name, p_approved_flag, p_comments);

        -- Update header status
        CASE p_level_no
            WHEN 1 THEN UPDATE purchase_requests SET status = CASE WHEN p_approved_flag='Y' THEN 'PENDING_L2' ELSE 'REJECTED' END WHERE pr_id=p_pr_id;
            WHEN 2 THEN UPDATE purchase_requests SET status = CASE WHEN p_approved_flag='Y' THEN 'PENDING_L3' ELSE 'REJECTED' END WHERE pr_id=p_pr_id;
            WHEN 3 THEN UPDATE purchase_requests SET status = CASE WHEN p_approved_flag='Y' THEN 'APPROVED' ELSE 'REJECTED' END WHERE pr_id=p_pr_id;
        END CASE;
    END approve_request;

END procurement_pkg;
/