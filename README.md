# 🚀 Data Ops & Analytics Portfolio

Welcome to my data engineering and analytics portfolio! This repository showcases end-to-end data solutions spanning automated ETL pipelines in Python, advanced SQL analytical modeling, data integrity audits, and interactive Power BI dashboards.

---

## 🛠️ General Tech Stack

* **Database & SQL:** PostgreSQL (CTEs, Window Functions, Data Integrity & Migration Audits).
* **Programming & ETL:** Python 3.x (`pandas`, `SQLAlchemy`, `openpyxl`, `logging`).
* **BI & Data Visualization:** Power BI (`.pbix`).
* **Version Control & Tooling:** VS Code, Git, GitHub CLI.

---

## 📦 Featured Projects

### 1. Supply Chain ETL Pipeline & Capital Allocation Analysis (Core Project)
* **Location:** `src/`, `main.py`, `supply_chain.sql/`
* **Description:** An end-to-end modular ETL pipeline that automates SKU risk classification based on fulfillment lead times and quantifies capital tied up in slow-moving inventory.
* **Technical Highlights:**
  * Advanced SQL queries utilizing CTEs and `SUM() OVER()` window functions to execute Pareto (80/20) risk distribution.
  * Production-grade Python orchestration featuring structured `logging` and robust `try/except` error handling.
  * Automated executive reporting generating stylized Excel workbooks (`data/*.xlsx`) via `openpyxl`.

#### 📊 Business Impact & Results:
* **Risk Identification:** Isolated **60 high-risk SKUs** exceeding the operational shipping threshold ($\ge 3.5$ days average).
* **Pareto Capital Concentration:** The **Top 10 SKUs** account for over **25% of total immobilized capital** in inventory.
* **Financial Optimization:** Liquidating or optimizing this stock unlocks **15%–20% of operational working capital** and reduces annual holding costs by **10%–12%**.

---

### 2. Advanced SQL Modeling & Business Cases
* **Location:** `northwind.sql/`, `formula1.sql/`
* **Description:** Comprehensive SQL script collection modeling complex business domains—including sales/inventory operations (Northwind) and time-series performance metrics (Formula 1).
* **Key Skills:** Complex multi-table joins, ranking window functions, and dynamic aggregation queries.

---

### 3. Data Integrity & Migration Audit
* **Location:** `data_integrity.ipynb`, `data_migration.ipynb`
* **Description:** Data quality and audit notebooks designed to validate schema consistency, detect duplicate records, and ensure data hygiene prior to cross-environment migrations.

---

### 4. Power BI Dashboards
* **Location:** `powerbi_movie_rentals.pbix`
* **Description:** An interactive dashboard analyzing movie rental performance, recurring revenue streams, and customer retention trends.

---

## ⚙️ How to Run the Supply Chain ETL Pipeline

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/williamperezesp232/portflio-data-ops.git](https://github.com/williamperezesp232/portflio-data-ops.git)
   cd portflio-data-ops