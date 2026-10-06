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
        from capital_inmovilizado import extract_capital_inmovilizado

        # -------------------------------------------------------------
        # FLUJO 1: Clasificación de SKUs e Inventario
        # -------------------------------------------------------------
        logging.info("📥 Paso 1/4: Extracting data de inventario base...")
        df_raw = df_stock_days
        if df_raw.empty:
            raise ValueError("El DataFrame de inventario extraído está vacío.")
        logging.info(f"   -> Extracción exitosa. Filas obtenidas: {len(df_raw)}")
        
        logging.info("⚙️ Paso 2/4: Transformando y clasificando inventario...")
        df_clasificado = transform_stock_days(df_raw)
        logging.info("   -> Transformación completada correctamente.")
        
        logging.info("📤 Paso 3/4: Exportando reporte de clasificación a Excel...")
        ruta_salida_clasificacion = os.path.join("data", "reporte_clasificacion_sku.xlsx")
        export_excel(df_clasificado, ruta_salida_clasificacion)
        
        # -------------------------------------------------------------
        # FLUJO 2: Análisis de Capital Inmovilizado (Caso de Negocio)
        # -------------------------------------------------------------
        logging.info("💰 Paso 4/4: Extrayendo y exportando reporte de Capital Inmovilizado...")
        df_capital = extract_capital_inmovilizado()
        
        if df_capital.empty:
            logging.warning("   -> No se encontraron registros para capital inmovilizado.")
        else:
            ruta_salida_capital = os.path.join("data", "reporte_capital_inmovilizado.xlsx")
            export_excel(df_capital, ruta_salida_capital)
            logging.info(f"   -> Reporte de Capital Inmovilizado generado ({len(df_capital)} filas).")

        logging.info("🎉 ¡Pipeline ETL completado con éxito!")

    except ModuleNotFoundError as e:
        logging.error(f"❌ Error de importación de módulos: {e}")
    except ValueError as e:
        logging.warning(f"⚠️ Advertencia en los datos: {e}")
    except Exception as e:
        logging.error(f"❌ Ocurrió un error inesperado durante el ETL: {e}", exc_info=True)

if __name__ == "__main__":
    run_pipeline()