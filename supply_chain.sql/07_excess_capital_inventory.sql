WITH stock_days_summary AS (
    SELECT 
        "Product Card Id" AS product_id,
        "Product Name" AS product_name,
        AVG("Days for shipping (real)") AS avg_days_for_shipping_real,
        SUM("Order Item Quantity") AS total_order_quantity
    FROM datacosupplychaindataset
    GROUP BY "Product Card Id", "Product Name"
),

stock_metrics AS (
    SELECT 
        product_id,
        product_name,
        ROUND(avg_days_for_shipping_real::numeric, 2) AS dias_inventario,
        total_order_quantity AS unidades_stock,
        ROUND((avg_days_for_shipping_real * 12.50)::numeric, 2) AS costo_unitario_estimado,
        ROUND((total_order_quantity * (avg_days_for_shipping_real * 12.50))::numeric, 2) AS capital_inmovilizado
    FROM stock_days_summary

    WHERE avg_days_for_shipping_real >= 3.5
)

SELECT 
    product_id,
    product_name,
    dias_inventario,
    unidades_stock,
    costo_unitario_estimado,
    capital_inmovilizado,
    ROUND(
        (capital_inmovilizado / NULLIF(SUM(capital_inmovilizado) OVER(), 0)) * 100, 
        2
    ) AS pct_capital_total
FROM stock_metrics
ORDER BY capital_inmovilizado DESC;