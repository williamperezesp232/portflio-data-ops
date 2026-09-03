import os
import pandas as pd
from connection import engine

query_top_products = """
    SELECT
        "Product Card Id" as product_id,
        "Product Name" as product_name,
        SUM("Order Item Quantity") as total_order_quantity,
        SUM("Sales") as total_sales
    FROM 
        datacosupplychaindataset
    GROUP BY product_id, product_name
    order by total_sales DESC
    LIMIT 10;
"""

df_top_products = pd.read_sql(query_top_products, engine)

print("\n--- NULL VALUES ---")
print(df_top_products.isnull().sum())

print("Top 10 Products by Sales:")
print(df_top_products)

query_stock_days = """
    SELECT
        "Product Card Id" as product_id,
        "Product Name" as product_name,
        AVG("Days for shipping (real)") as avg_days_for_shipping_real,
        AVG("Days for shipment (scheduled)") as avg_days_for_shipping_planned,
        SUM("Order Item Quantity") as total_order_quantity
    FROM
        datacosupplychaindataset    
    GROUP BY product_id, product_name
    ORDER BY total_order_quantity DESC
    LIMIT 20;
"""

df_stock_days = pd.read_sql(query_stock_days, engine)

print("Top 20 Products by Order Quantity and Average Shipping Days:")
print(df_stock_days)

print("\n--- NULL VALUES ---")
print(df_stock_days.isnull().sum())

