import logging
import os
import sys

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)],
)

sys.path.append(os.path.abspath("src"))


def run_pipeline():
    logging.info("🚀 Iniciando Pipeline ETL de Cadena de Suministro...")

    try:
        from analysis import calculate_abc_classification
        from capital_inmovilizado import extract_capital_inmovilizado
        from config import EXCEL_OUTPUT_PATH
        from extract import df_stock_days
        from load import export_to_excel_styled
        from transform import transform_stock_days


        logging.info("📥 Paso 1/4: Extrayendo datos de inventario base...")
        df_raw = df_stock_days
        if df_raw.empty:
            raise ValueError(
                "El DataFrame de inventario extraído está vacío."
            )
        logging.info(
            f"   -> Extracción exitosa. Filas obtenidas: {len(df_raw)}"
        )


        logging.info(
            "⚙️ Paso 2/4: Transformando y clasificando SKUs críticos..."
        )
        df_criticos = transform_stock_days(df_raw)

        logging.info("📊 Paso 3/4: Generando Clasificación ABC de Pareto...")
        df_abc = calculate_abc_classification(df_raw)

        df_capital = extract_capital_inmovilizado()


        logging.info(
            "📤 Paso 4/4: Exportando Reporte Ejecutivo a Excel multipestaña..."
        )

        df_resumen = (
            df_capital
            if not df_capital.empty
            else df_criticos.head(5)
        )

        export_to_excel_styled(
            executive_summary_df=df_resumen,
            critical_skus_df=df_criticos,
            abc_classification_df=df_abc,
            output_filepath=str(EXCEL_OUTPUT_PATH),
        )

        logging.info("🎉 ¡Pipeline ETL completado exitosamente!")

    except ModuleNotFoundError as e:
        logging.error(f"❌ Error de importación de módulos: {e}")
    except ValueError as e:
        logging.warning(f"⚠️ Advertencia en los datos: {e}")
    except Exception as e:
        logging.error(
            f"❌ Ocurrió un error inesperado durante el ETL: {e}",
            exc_info=True,
        )

if __name__ == "__main__":
    run_pipeline()