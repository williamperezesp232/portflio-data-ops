WITH ventas_anuales_region AS (
    -- 1. AGRUPAR (A)
    SELECT 
        "Order Region" AS region,
        DATE_TRUNC('year', TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS anio,
        SUM("Sales") AS ventas_actuales,
        -- 2. COMPARAR (C)
        LAG(SUM("Sales"), 1) OVER (
            PARTITION BY "Order Region" 
            ORDER BY DATE_TRUNC('year', TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI'))
        ) AS ventas_anio_anterior
    FROM datacosupplychaindataset
    GROUP BY "Order Region", DATE_TRUNC('year', TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI'))
)
-- 3. OPERAR (O)
SELECT 
    region,
    TO_CHAR(anio, 'YYYY') AS periodo_anio,
    ROUND(ventas_anio_anterior::numeric, 2) AS ventas_anterior,
    ROUND(ventas_actuales::numeric, 2) AS ventas_actual,
    ROUND(
        ((ventas_actuales - ventas_anio_anterior) * 100.0 / NULLIF(ventas_anio_anterior, 0))::numeric, 
        2
    ) AS crecimiento_porcentual
FROM ventas_anuales_region
WHERE ventas_anio_anterior IS NOT NULL
  AND ((ventas_actuales - ventas_anio_anterior) * 100.0 / NULLIF(ventas_anio_anterior, 0)) > 30.00
ORDER BY crecimiento_porcentual DESC;