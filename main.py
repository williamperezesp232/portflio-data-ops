import os
import sys
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout)
    ]
)

sys.path.append(os.path.abspath("src"))

def run_pipeline():
    logging.info("🚀 Initiate ETL Pipeline...")

    try:
        from extract import df_stock_days
        from transform import transform_stock_days
        from load import export_excel

        
        logging.info("📥 Paso 1/3: Extracting data...")
        df_raw = df_stock_days
        if df_raw.empty:
            raise ValueError("El DataFrame extraído está vacío.")
        logging.info(f"   -> Extracción exitosa. Filas obtenidas: {len(df_raw)}")
        
        
        logging.info("⚙️ Paso 2/3: Transformando y clasificando inventario...")
        df_clasificado = transform_stock_days(df_raw)
        logging.info("   -> Transformación completada correctamente.")
        
        
        logging.info("📤 Paso 3/3: Exportando reporte a Excel...")
        ruta_salida = os.path.join("data", "reporte_clasificacion_sku.xlsx")
        export_excel(df_clasificado, ruta_salida)
        
        logging.info("🎉 ¡Pipeline ETL completado con éxito!")

    except ModuleNotFoundError as e:
        logging.error(f"❌ Error de importación de módulos: {e}")
    except ValueError as e:
        logging.warning(f"⚠️ Advertencia en los datos: {e}")
    except Exception as e:
        logging.error(f"❌ Ocurrió un error inesperado durante el ETL: {e}", exc_info=True)

if __name__ == "__main__":
    run_pipeline()