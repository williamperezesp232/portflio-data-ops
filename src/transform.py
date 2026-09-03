import pandas as pd
from extract import df_stock_days

def ranking_sku(avg_days_for_shipping_real):
    
    if avg_days_for_shipping_real > 4.0:
        return "Crítico"
    elif avg_days_for_shipping_real >= 3.0:
        return "Alerta"
    else:
        return "Normal"

    
def transform_stock_days(df):
    df_transformed = df.copy()
    df_transformed["categoria_inventario"] = df_transformed["avg_days_for_shipping_real"].apply(ranking_sku)
    return df_transformed


if __name__ == "__main__":
    
    df_clasificado = transform_stock_days(df_stock_days)

    print("\n--- RESULTADO DE LA TRANSFORMACIÓN (SKU CLASIFICADOS) ---")
    print(df_clasificado[["product_id", "product_name", "avg_days_for_shipping_real", "categoria_inventario"]].head(10))
    
    print("\n--- CONTEO POR CATEGORÍA ---")
    print(df_clasificado["categoria_inventario"].value_counts())