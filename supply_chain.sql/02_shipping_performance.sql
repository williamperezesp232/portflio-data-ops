WITH metricas_envio AS (
    SELECT 
        "Shipping Mode" AS modo_envio,
        "Order Region" AS region_pedido,
        COUNT("Order Id") AS total_pedidos,
        ROUND(AVG("Days for shipping (real)"), 2) AS promedio_dias_reales,
        ROUND(AVG("Days for shipment (scheduled)"), 2) AS promedio_dias_programados,
        SUM(CASE WHEN "Days for shipping (real)" > "Days for shipment (scheduled)" THEN 1 ELSE 0 END) AS pedidos_retrasados
    FROM datacosupplychaindataset
    GROUP BY "Shipping Mode", "Order Region"
)
SELECT 
    modo_envio,
    region_pedido,
    total_pedidos,
    promedio_dias_programados,
    promedio_dias_reales,
    pedidos_retrasados,
    ROUND((pedidos_retrasados * 100.0 / total_pedidos), 2) AS porcentaje_retraso
FROM metricas_envio
WHERE total_pedidos > 50
ORDER BY porcentaje_retraso DESC
LIMIT 15;