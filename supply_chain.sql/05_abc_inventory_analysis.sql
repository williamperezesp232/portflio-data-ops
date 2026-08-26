WITH ventas_por_sku AS (
    -- 1. Calcular el ingreso total generado por cada producto
    SELECT 
        "Product Card Id" AS sku_id,
        "Product Name" AS producto,
        SUM("Sales") AS ingresos_totales
    FROM datacosupplychaindataset
    GROUP BY "Product Card Id", "Product Name"
),
acumulado_ingresos AS (
    -- 2. Calcular la suma acumulada y el porcentaje acumulado global usando SUM() OVER()
    SELECT 
        sku_id,
        producto,
        ingresos_totales,
        SUM(ingresos_totales) OVER (ORDER BY ingresos_totales DESC) AS ingreso_acumulado,
        SUM(ingresos_totales) OVER () AS ingreso_global_total
    FROM ventas_por_sku
)
-- 3. Asignar la categoría A, B o C según el porcentaje de ingresos acumulado
SELECT 
    sku_id,
    producto,
    ROUND(ingresos_totales::numeric, 2) AS ingresos_totales,
    ROUND((ingreso_acumulado * 100.0 / ingreso_global_total)::numeric, 2) AS pct_acumulado,
    CASE 
        WHEN (ingreso_acumulado * 100.0 / ingreso_global_total) <= 80.0 THEN 'Clase A (Crítico)'
        WHEN (ingreso_acumulado * 100.0 / ingreso_global_total) <= 95.0 THEN 'Clase B (Moderado)'
        ELSE 'Clase C (Bajo Impacto)'
    END AS clasificacion_abc
FROM acumulado_ingresos
ORDER BY ingresos_totales DESC;