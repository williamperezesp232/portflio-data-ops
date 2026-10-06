# 🚀 Data Ops & Analytics Portfolio

¡Bienvenido a mi repositorio de proyectos de analítica de datos, ingeniería de datos y Business Intelligence! Aquí organizo soluciones de extremo a extremo que van desde consultas SQL avanzadas hasta pipelines modulares en Python y tableros en Power BI.

---

## 🛠️ Tech Stack General

* **Base de Datos & SQL:** PostgreSQL (CTEs, Window Functions, Auditoría de Integridad).
* **Lenguajes & Librerías:** Python 3.x (`pandas`, `SQLAlchemy`, `openpyxl`, `logging`).
* **BI & Visualización:** Power BI (`.pbix`).
* **Herramientas de Desarrollo:** VS Code, Git, GitHub CLI.

---

## 📦 Proyectos Destacados

### 1. Supply Chain ETL Pipeline & Capital Inmovilizado (Proyecto Principal)
* **Ubicación:** `src/`, `main.py`, `supply_chain.sql/`
* **Descripción:** Pipeline modular de extracción, transformación y carga (ETL) que automatiza la clasificación de SKUs según sus tiempos de envío y cuantifica el capital estancado en bodega.
* **Aspectos Técnicos:**
  * Consultas SQL complejas con CTEs y `SUM() OVER()` para análisis de Pareto (80/20).
  * Módulo modular en Python con manejo de logs y captura de excepciones (`try/except`).
  * Generación de reportes dinámicos en Excel (`data/*.xlsx`) con estilos formateados vía `openpyxl`.

#### 📊 Impacto Financiero & Resultados:
* **Identificación:** Se aislaron **60 SKUs principales** en riesgo ($\ge 3.5$ días de permanencia).
* **Análisis Pareto:** El **Top 10 de productos** concentra más del **25% del capital total inmovilizado**.
* **Optimización:** Permite liberar un **15% - 20% del flujo de caja operativo** y reducir costes de almacenamiento en un **10% - 12%**.

---

### 2. Análisis SQL Avanzado & Casos de Negocio
* **Ubicación:** `northwind.sql/`, `formula1.sql/`
* **Descripción:** Repositorio de scripts de modelado y analítica SQL sobre bases de datos complejas (gestión de ventas e inventarios con Northwind, análisis de rendimiento temporal con métricas de Formula 1).
* **Competencias:** Joins complejos, funciones de ventana para rankings y agregaciones dinámicas.

---

### 3. Data Integrity & Migration Audit
* **Ubicación:** `data_integrity.ipynb`, `data_migration.ipynb`
* **Descripción:** Notebooks de auditoría para la validación de consistencia, duplicados y calidad de datos previa a procesos de migración entre entornos.

---

### 4. Power BI Dashboards
* **Ubicación:** `powerbi_movie_rentals.pbix/assets/`
* **Descripción:** Tablero interactivo para el análisis de rendimiento de alquileres de películas, métricas de ingresos recurrentes y comportamiento del cliente.

---

## ⚙️ Cómo Ejecutar el Pipeline ETL de Supply Chain

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/williamperezesp232/portflio-data-ops.git](https://github.com/williamperezesp232/portflio-data-ops.git)
   cd portflio-data-ops