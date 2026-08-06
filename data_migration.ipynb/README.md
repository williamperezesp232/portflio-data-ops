# Legal Data Migration & Data Quality Audit

## 📋 Project Overview
This repository contains a Python data cleaning, validation, and reconciliation pipeline (`Practica5Migration.ipynb`). The project simulates a real-world **legacy database migration scenario** where records from an old system (`Old_System`) and flat-file imports (`Excel_Import`) are audited, sanitized, and unified to establish high-standard data quality metrics.

The workflow addresses critical migration challenges including mixed date formats, non-numeric noise in financial fields, unstandardized case statuses, missing client identities, and multi-source financial discrepancies.

---

## 🎯 Key Objectives
- **Data Sanitization & Parsing:** Normalize multi-format date strings (`YYYY-MM-DD`, `MM/DD/YYYY`, `DD-MM-YYYY`, `YYYY/MM/DD`) into consistent datetime objects.
- **Financial Cleaning:** Coerce string noise (`N/A`) and non-positive legal fees ($\le 0$) into missing values (`NaN`) to prevent statistical bias.
- **Categorical Normalization:** Clean whitespace and fix casing inconsistencies across status records (e.g., standardizing `closed `, `OPEN`, and `Pending`).
- **Identity & Text Normalization:** Handle missing client names via fallback defaults (`UNKNOWN_CLIENT`) and normalize diacritics/accents using `unicodedata` (NFKD).
- **Cross-System Reconciliation:** Compare inner-joined records between legacy systems to detect financial settlement variances.

---

## 🛠️ Tech Stack & Dependencies
- **Language:** Python 3.x
- **Core Libraries:** `pandas`, `numpy`, `random`, `unicodedata`
- **Visualization:** `matplotlib`
- **Export Utility:** `openpyxl`

---

## 🏗️ Audit & Migration Workflow

```text
📁 Data Migration Pipeline
 ├── 1. Synthetic Bug Injection & Migration Setup (8,000 Records)
 ├── 2. Categorical Casing & String Whitespace Normalization
 ├── 3. Robust Datetime & Numeric Type Coercion
 ├── 4. Garbage Value Detection & Text Accents Removal
 ├── 5. Cross-System Reconciliation (Old_System vs. Excel_Import)
 └── 6. Data Quality Metrics & Status Distribution Plotting