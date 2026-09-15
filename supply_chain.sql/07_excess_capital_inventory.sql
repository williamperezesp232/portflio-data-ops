WITH stock_metrics AS (
    SELECT 
        product_id,
        product_name,
        avg_days_for_shipping_real AS dias_inventario,
        total_order_quantity AS unidades_stock,
        
        ROUND((avg_days_for_shipping_real * 12.50)::numeric, 2) AS costo_unitario_estimado,
        
        ROUND((total_order_quantity * (avg_days_for_shipping_real * 12.50))::numeric, 2) AS capital_inmovilizado
    FROM stock_days_summary
    WHERE avg_days_for_shipping_real > 90
)

SELECT 
    product_id,
    product_name,
    dias_inventario,
    unidades_stock,
    costo_unitario_estimado,
    capital_inmovilizado,
    -- Porcentaje del capital total estancado que representa este producto (Pareto)
    ROUND(
        (capital_inmovilizado / SUM(capital_inmovilizado) OVER()) * 100, 
        2
    ) AS pct_capital_total
FROM stock_metrics
ORDER BY capital_inmovilizado DESC;