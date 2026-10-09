import os
import openpyxl
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils.dataframe import dataframe_to_rows
import pandas as pd


def export_to_excel_styled(
    executive_summary_df: pd.DataFrame,
    critical_skus_df: pd.DataFrame,
    abc_classification_df: pd.DataFrame,
    output_filepath: str = "data/supply_chain_executive_report.xlsx",
) -> str:
    """Exporta los DataFrames procesados a un archivo Excel con 3 pestañas y

    estilizado condicional avanzado usando openpyxl.
    """
    # Crear directorio si no existe
    os.makedirs(os.path.dirname(output_filepath), exist_ok=True)

    # Crear libro de trabajo
    wb = openpyxl.Workbook()
    # Eliminar hoja por defecto
    wb.remove(wb.active)

    # Definición de estilos profesionales
    header_fill = PatternFill(
        start_color="1F4E78", end_color="1F4E78", fill_type="solid"
    )  # Azul oscuro ejecutivo
    header_font = Font(name="Segoe UI", size=11, bold=True, color="FFFFFF")

    fill_a = PatternFill(
        start_color="D9EAD3", end_color="D9EAD3", fill_type="solid"
    )  # Verde suave (Bajo riesgo / Cat A)
    fill_b = PatternFill(
        start_color="FFF2CC", end_color="FFF2CC", fill_type="solid"
    )  # Amarillo suave (Riesgo medio / Cat B)
    fill_c = PatternFill(
        start_color="FCE5CD", end_color="FCE5CD", fill_type="solid"
    )  # Naranja/Rojo suave (Riesgo alto / Cat C)

    thin_border = Border(
        left=Side(style="thin", color="D9D9D9"),
        right=Side(style="thin", color="D9D9D9"),
        top=Side(style="thin", color="D9D9D9"),
        bottom=Side(style="thin", color="D9D9D9"),
    )

    sheets_data = [
        ("Resumen Ejecutivo", executive_summary_df),
        ("Detalle SKUs Críticos", critical_skus_df),
        ("Clasificación ABC", abc_classification_df),
    ]

    for sheet_name, df in sheets_data:
        ws = wb.create_sheet(title=sheet_name)
        ws.views.sheetView[0].showGridLines = True

        # Escribir DataFrame
        for r_idx, row in enumerate(
            dataframe_to_rows(df, index=False, header=True), 1
        ):
            ws.append(row)

        # Estilizar encabezados (Fila 1)
        for cell in ws[1]:
            cell.fill = header_fill
            cell.font = header_font
            cell.alignment = Alignment(
                horizontal="center", vertical="center", wrap_text=True
            )

        # Estilizar datos y aplicar colores condicionales por categoría de riesgo / segmento
        for row in ws.iter_rows(min_row=2, max_row=ws.max_row):
            for cell in row:
                cell.border = thin_border
                cell.font = Font(name="Segoe UI", size=10)

                val_str = str(cell.value).strip().upper()

                # Aplicar relleno según segmento ABC o Nivel de Riesgo
                if val_str in ["A", "LOW", "BAJO"]:
                    cell.fill = fill_a
                    cell.font = Font(
                        name="Segoe UI", size=10, bold=True, color="274E13"
                    )
                elif val_str in ["B", "MEDIUM", "MEDIO"]:
                    cell.fill = fill_b
                    cell.font = Font(
                        name="Segoe UI", size=10, bold=True, color="7F6000"
                    )
                elif val_str in ["C", "HIGH", "ALTO", "CRITICAL", "CRÍTICO"]:
                    cell.fill = fill_c
                    cell.font = Font(
                        name="Segoe UI", size=10, bold=True, color="A61C1C"
                    )

        # Ajustar ancho de columnas automáticamente
        for col in ws.columns:
            max_len = max(len(str(cell.value or "")) for cell in col)
            col_letter = openpyxl.utils.get_column_letter(col[0].column)
            ws.column_dimensions[col_letter].width = max(max_len + 3, 12)

    # Guardar libro de Excel
    wb.save(output_filepath)
    print(f" Reporte generado exitosamente en: {output_filepath}")
    return output_filepath


if __name__ == "__main__":
    # Prueba rápida unitaria del módulo load.py
    df_resumen = pd.DataFrame(
        {
            "Métrica": [
                "Total SKUs Analizados",
                "SKUs Riesgo Alto",
                "Capital Inmovilizado Total",
            ],
            "Valor": [1250, 48, "$342,500"],
            "Estatus Riesgo": ["BAJO", "ALTO", "MEDIO"],
        }
    )

    df_skus = pd.DataFrame(
        {
            "SKU": [101, 102, 103, 104],
            "Producto": [
                "Pala Padel Pro",
                "Grip",
                "Zapatillas Asics",
                "Protector",
            ],
            "Riesgo Stock": ["ALTO", "BAJO", "MEDIO", "ALTO"],
            "Días Stock": [5, 45, 18, 2],
        }
    )

    df_abc = pd.DataFrame(
        {
            "SKU": [101, 103, 102, 104],
            "Producto": [
                "Pala Padel Pro",
                "Zapatillas Asics",
                "Grip",
                "Protector",
            ],
            "Ventas Totales": [9000, 1800, 150, 25],
            "abc_segment": ["A", "B", "C", "C"],
        }
    )

    export_to_excel_styled(df_resumen, df_skus, df_abc)