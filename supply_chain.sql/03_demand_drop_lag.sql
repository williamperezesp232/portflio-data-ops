WITH ventas_mensuales AS (
    SELECT 
        "Product Card Id" AS sku_id,
        "Product Name" AS producto,
        DATE_TRUNC('month', TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS mes,
        SUM("Order Item Quantity") AS unidades_vendidas
    FROM datacosupplychaindataset
    GROUP BY "Product Card Id", "Product Name", DATE_TRUNC('month', TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI'))
),
comparativa_mes_anterior AS (
    SELECT 
        sku_id,
        producto,
        mes,
        unidades_vendidas AS ventas_mes_actual,
        LAG(unidades_vendidas, 1) OVER (
            PARTITION BY sku_id 
            ORDER BY mes
        ) AS ventas_mes_anterior
    FROM ventas_mensuales
)
SELECT 
    sku_id,
    producto,
    TO_CHAR(mes, 'YYYY-MM') AS periodo,
    ventas_mes_anterior,
    ventas_mes_actual,
    (ventas_mes_actual - ventas_mes_anterior) AS diferencia_unidades,
    ROUND(
        ((ventas_mes_actual - ventas_mes_anterior) * 100.0 / NULLIF(ventas_mes_anterior, 0)), 
        2
    ) AS variacion_porcentual
FROM comparativa_mes_anterior
WHERE ventas_mes_anterior IS NOT NULL 
  AND ventas_mes_anterior > 0
  AND ((ventas_mes_actual - ventas_mes_anterior) * 100.0 / NULLIF(ventas_mes_anterior, 0)) < -25.00
ORDER BY variacion_porcentual ASC
LIMIT 15;