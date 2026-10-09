import pandas as pd


def calculate_abc_classification(df: pd.DataFrame) -> pd.DataFrame:
    """Calcula la clasificación ABC basada en el principio de Pareto (80/15/5).

    Detecta automáticamente la columna de ingresos/ventas en el DataFrame.
    """
    if df.empty:
        return df

    abc_df = df.copy()

    # Detectar dinámicamente la columna de ingresos o ventas
    revenue_col = None
    possible_cols = [
        "total_revenue",
        "revenue",
        "total_sales",
        "sales",
        "ingresos",
        "ventas",
        "valor_total",
    ]

    for col in possible_cols:
        if col in abc_df.columns:
            revenue_col = col
            break

    # Si no coincide con los nombres estándar, tomar la primera columna numérica que no sea un ID/SKU
    if not revenue_col:
        numeric_cols = [
            c
            for c in abc_df.select_dtypes(include=["number"]).columns
            if "sku" not in c.lower() and "id" not in c.lower()
        ]
        if numeric_cols:
            revenue_col = numeric_cols[0]
        else:
            raise KeyError(
                f"No se encontró ninguna columna de ingresos/ventas. Columnas disponibles: {list(abc_df.columns)}"
            )

    # Ordenar descendente por ingresos/ventas
    abc_df = abc_df.sort_values(by=revenue_col, ascending=False).reset_index(
        drop=True
    )

    # Cálculo del porcentaje acumulado de ingresos
    total_val = abc_df[revenue_col].sum()
    if total_val > 0:
        abc_df["cum_sum"] = abc_df[revenue_col].cumsum()
        abc_df["cum_perc"] = abc_df["cum_sum"] / total_val
    else:
        abc_df["cum_perc"] = 0

    # Asignación de segmentos ABC según Pareto
    def assign_abc(cum_perc):
        if cum_perc <= 0.80:
            return "A"
        elif cum_perc <= 0.95:
            return "B"
        else:
            return "C"

    abc_df["abc_segment"] = abc_df["cum_perc"].apply(assign_abc)

    return abc_df