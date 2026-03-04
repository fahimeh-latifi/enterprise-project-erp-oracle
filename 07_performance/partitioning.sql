CREATE TABLE sales_orders_partitioned
(
    so_id NUMBER,
    project_id NUMBER,
    order_date DATE NOT NULL,
    total_amount NUMBER,
    status VARCHAR2(20),
    created_by VARCHAR2(50),

    CONSTRAINT pk_sales_orders_part PRIMARY KEY (so_id)
)
PARTITION BY RANGE (order_date)
INTERVAL (NUMTOYMINTERVAL(3,'MONTH'))  -- Automatic quarterly partitions
(
    PARTITION p_start VALUES LESS THAN (DATE '2026-01-01')
);

-- Foreign Key
ALTER TABLE sales_orders_partitioned
ADD CONSTRAINT fk_sales_project
FOREIGN KEY (project_id)
REFERENCES projects(project_id);