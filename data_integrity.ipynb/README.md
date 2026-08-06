# Data Integrity & System Migration Audit: Legal Portfolio Analysis

## 📋 Project Overview
This repository contains an end-to-end data integrity audit, reconciliation script, and ETL pipeline simulation (`DataIntegrityGTAKG.ipynb`). The project models a complex data migration scenario from a **Legacy System** to a **New System** for legal case management, simulating real-world data corruption bugs, financial discrepancies, and schema inconsistencies.

The primary goal is to validate data quality, resolve identity conflicts, audit financial deviations, and reconcile settlement metrics to establish a **Single Source of Truth (SSOT)**.

---

## 🎯 Objectives
- **Data Reconciliation:** Compare and reconcile 8,000+ legal records between source systems (`legacy` vs. `new`).
- **Identity Normalization:** Resolve typography issues, special accents/diacritics, and duplicate entities using fuzzy normalization and custom Python logic (`unicodedata`).
- **Financial Risk Mitigation:** Identify critical data entry bugs, including **Factor-10 scale truncations**, negative legal fees, and missing decimal precision.
- **Audit Logging & Reporting:** Generate automated Excel audit reports for legal and accounting teams to review edge cases without halting pipeline execution.

---

## 🛠️ Tech Stack & Dependencies
- **Python 3.x**
- **Data Manipulation:** `pandas`, `numpy`
- **Text & Encoding Normalization:** `unicodedata`
- **Visualization:** `matplotlib`, `seaborn`
- **Audit File Generation:** `openpyxl` / Excel engine

---

## 🏗️ Architecture & Workflow

```text
📁 Data Integrity Pipeline
 ├── 1. Data Generation (Synthetic Bug Injection)
 ├── 2. Identity Normalization & Deduplication
 ├── 3. Field & Schema Validation
 ├── 4. System Reconciliation & Financial Auditing
 └── 5. Audit Reporting & Metrics Visualization