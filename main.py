import os
import sys

sys.path.append(os.path.abspath("src"))

from extract import df_stock_days
from transform import transform_stock_days
from load import export_excel

def run_pipeline():
    print("🚀 Iniciando Pipeline ETL de Inventario...\n")


    print("📥 Paso 1/3: Extrayendo datos desde PostgreSQL...")
    df_raw = df_stock_days
    print(f"   -> Extraction completed. Rows obtained: {len(df_raw)}")

    print("⚙️ Paso 2/3: Clasificando riesgo de inventario (SKU)...")
    df_clasificado = transform_stock_days(df_raw)
    print("   -> Transformation completed successfully.")

    print("📤 Paso 3/3: Generando reporte Excel con formato condicional...")
    ruta_salida = os.path.join("data", "reporte_clasificacion_sku.xlsx")
    export_excel(df_clasificado, ruta_salida)

    print("\n🎉 ETL completed successfully!")


if __name__ == "__main__":
    run_pipeline()