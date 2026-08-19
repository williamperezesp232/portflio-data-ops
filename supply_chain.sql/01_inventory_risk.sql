WITH rango_tiempo AS (
    SELECT 
        COUNT(DISTINCT TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS total_dias_operativos
    FROM datacosupplychaindataset
),
metricas_sku AS (
    SELECT 
        "Product Card Id" AS sku_id,
        "Product Name" AS producto,
        SUM("Order Item Quantity") AS unidades_totales_vendidas,
        SUM("Order Item Quantity") * 1.0 / (SELECT total_dias_operativos FROM rango_tiempo) AS venta_diaria_promedio
    FROM datacosupplychaindataset
    GROUP BY "Product Card Id", "Product Name"
)
SELECT 
    sku_id,
    producto,
    unidades_totales_vendidas,
    ROUND(venta_diaria_promedio, 2) AS venta_diaria_promedio
FROM metricas_sku
WHERE venta_diaria_promedio > 0
ORDER BY venta_diaria_promedio DESC
LIMIT 10;