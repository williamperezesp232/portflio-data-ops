SELECT 
    "Product Card Id" AS product_id,
    "Product Name" AS product_name,
    SUM("Order Item Quantity") AS total_units_sold,
    AVG("Product Price") AS avg_price,
    ROUND(
        SUM("Order Item Quantity")::NUMERIC / NULLIF(COUNT(DISTINCT "Order Id"), 0), 2
    ) AS turnover_rate
FROM datacosupplychaindataset
GROUP BY "Product Card Id", "Product Name"
ORDER BY turnover_rate DESC;