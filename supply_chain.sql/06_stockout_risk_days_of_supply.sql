WITH rango_fechas AS (
    SELECT 
        GREATEST(
            (MAX(TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) - MIN(TO_DATE("order date (DateOrders)", 'MM/DD/YYYY HH24:MI'))),
            1
        ) AS dias_totales_periodo
    FROM datacosupplychaindataset
),
ventas_diarias_sku AS (
    SELECT 
        "Product Card Id" AS sku_id,
        "Product Name" AS producto,
        SUM("Order Item Quantity") AS unidades_totales_vendidas,
        ROUND(
            (SUM("Order Item Quantity") * 1.0 / (SELECT dias_totales_periodo FROM rango_fechas)), 
            4
        ) AS venta_diaria_promedio
    FROM datacosupplychaindataset
    GROUP BY "Product Card Id", "Product Name"
)
SELECT 
    sku_id,
    producto,
    unidades_totales_vendidas,
    venta_diaria_promedio,
    ROUND(
        (unidades_totales_vendidas * 1.0 / NULLIF(venta_diaria_promedio, 0)), 
        2
    ) AS dias_inventario_disponible
FROM ventas_diarias_sku
WHERE venta_diaria_promedio > 0
ORDER BY venta_diaria_promedio DESC
LIMIT 10;