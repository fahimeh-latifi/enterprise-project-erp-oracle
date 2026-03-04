Enterprise Sales & Finance System
Oracle 19c | PL/SQL | Performance Optimization | Security & Partitioning

Author: Fahimeh Latifi
Database Developer | Oracle & Enterprise Systems
Toronto, Canada

📌 Project Overview

This project simulates a real-world Enterprise ERP-style database system covering:

Projects Management

Sales Operations

Procurement Workflow

Financial Ledger Integration (Debit/Credit)

Reporting & Analytics

Security & Performance Optimization

The system is built and tested on Oracle 23c Developer Edition and demonstrates advanced database engineering concepts used in enterprise environments.

🏗 Core Architecture
🔹 Projects Module

Project contracts, budgets, lifecycle tracking

Integrated financial sub-accounts

Linked to Sales and Procurement modules

🔹 Sales Module

Sales Orders & Order Items

Multi-level approval simulation

Auto-posting to financial ledger using triggers

🔹 Procurement Module

Purchase Requests & PR Items

Authorization workflow

Financial posting after approval

🔹 Finance Module

Double-entry ledger (Debit / Credit)

Payment tracking

Operational integration

📊 Reporting Layer
1️⃣ Project Profitability Report

Implemented using aggregated CTEs to prevent double counting caused by multi-level joins.

✔ Revenue aggregated independently
✔ Cost aggregated independently
✔ Joined safely at project level

Demonstrates understanding of:

Aggregation correctness

Join cardinality impact

Financial accuracy in reporting

2️⃣ Accounts Receivable Aging Report

Simulates enterprise AR tracking logic for overdue balances and customer exposure.

⚙ ETL Simulation

Bulk data load scripts

Transaction simulation

Supports analytics and performance testing

🔐 Security Implementation

Role-based access control:

Sales Role

Procurement Role

Finance Role

Admin Role

Read-only Analyst Role

Privilege assignments

Auditing simulation

Demonstrates enterprise security modeling.

🚀 Performance Engineering

Performance tuning was intentionally implemented and tested.

🔹 1. Index Optimization

Baseline execution plan captured before index creation.

After creating supporting index:

CREATE INDEX idx_sales_orders_project 
ON sales_orders(project_id);

Execution plan changed from:

FULL TABLE SCAN

to:

INDEX RANGE SCAN

Reducing query cost and improving efficiency.

Explain Plan format used:

DBMS_XPLAN.DISPLAY(format => 'TYPICAL +COST +BYTES +CARDINALITY')
🔹 2. Table Partitioning

Implemented Range Partitioning with Interval on sales_orders_partitioned table.

PARTITION BY RANGE (order_date)
INTERVAL (NUMTOYMINTERVAL(3,'MONTH'))

Features demonstrated:

✔ Automatic quarterly partition creation
✔ Future-proof design
✔ Foreign key integrity preserved

🔹 3. Partition Pruning Demonstration

Execution plan confirms:

PARTITION RANGE SINGLE

This proves Oracle scans only relevant partitions when filtering by date range.

Demonstrates:

Query performance optimization

Reduced I/O scanning

Enterprise-scale readiness

📂 Project Structure
01_schema/
02_sample_data/
03_triggers/
04_security/
05_packages/
06_etl_simulation/
07_performance/
08_reporting/
💡 Advanced Concepts Demonstrated

Enterprise data modeling

PL/SQL packages and triggers

Financial transaction processing

Double counting prevention

Index strategy design

Explain Plan analysis

Partition pruning

Role-based access control

ETL simulation logic

📈 Future Enhancements

Materialized views for analytics

Scheduler jobs

Advanced auditing policies

Performance benchmarking metrics

🎯 Purpose of This Project

This repository was built to demonstrate hands-on Oracle enterprise database development skills, including:

System design

Performance engineering

Financial workflow integration

Production-style database structuring

👩‍💻 Author

Fahimeh Latifi
Database Developer | Oracle & Enterprise Systems
Toronto, Canada