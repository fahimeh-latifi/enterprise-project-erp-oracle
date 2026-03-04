-- =========================================
-- project_pkg.sql
-- Author: Fahimeh Latifi
-- Description: PL/SQL Package for Projects Module
-- =========================================

CREATE OR REPLACE PACKAGE project_pkg AS
    -- Create a new project under a contract
    PROCEDURE create_project(
        p_contract_id IN NUMBER,
        p_project_code IN VARCHAR2,
        p_project_name IN VARCHAR2,
        p_budget_amount IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE,
        p_description IN VARCHAR2
    );

    -- Update project status
    PROCEDURE update_project_status(
        p_project_id IN NUMBER,
        p_status IN VARCHAR2
    );
END project_pkg;
/

CREATE OR REPLACE PACKAGE BODY project_pkg AS

    PROCEDURE create_project(
        p_contract_id IN NUMBER,
        p_project_code IN VARCHAR2,
        p_project_name IN VARCHAR2,
        p_budget_amount IN NUMBER,
        p_start_date IN DATE,
        p_end_date IN DATE,
        p_description IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO projects(project_code, contract_id, project_name, budget_amount, start_date, end_date, status, description)
        VALUES(p_project_code, p_contract_id, p_project_name, p_budget_amount, p_start_date, p_end_date, 'ACTIVE', p_description);
    END create_project;

    PROCEDURE update_project_status(
        p_project_id IN NUMBER,
        p_status IN VARCHAR2
    ) IS
    BEGIN
        UPDATE projects SET status = p_status WHERE project_id = p_project_id;
    END update_project_status;

END project_pkg;
/