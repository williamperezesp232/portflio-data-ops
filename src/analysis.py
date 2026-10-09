import pandas as pd


def calculate_abc_classification(df: pd.DataFrame) -> pd.DataFrame:
    """Calcula la clasificación ABC basada en el valor total de ventas acumuladas (Regla de Pareto 80/20).

    Agrega la columna 'abc_segment' (A, B o C) al DataFrame.
    """
    # 1. Asegurar que trabajamos con una copia
    data = df.copy()

    # 2. Calcular las ventas totales si no existe la columna
    if (
        "total_revenue" not in data.columns
        and "Order Item Quantity" in data.columns
        and "Product Price" in data.columns
    ):
        data["total_revenue"] = (
            data["Order Item Quantity"] * data["Product Price"]
        )

    # 3. Agrupar por producto para calcular ingresos por SKU
    group_cols = []
    if "Product Card Id" in data.columns:
        group_cols.append("Product Card Id")
    if "Product Name" in data.columns:
        group_cols.append("Product Name")

    if group_cols:
        abc_df = (
            data.groupby(group_cols)["total_revenue"].sum().reset_index()
        )
    else:
        abc_df = data.copy()

    # 4. Ordenar de mayor a menor ingreso
    abc_df = abc_df.sort_values(by="total_revenue", ascending=False)

    # 5. Calcular porcentaje acumulado del valor total de ventas
    total_sales = abc_df["total_revenue"].sum()
    abc_df["cumulative_revenue"] = abc_df["total_revenue"].cumsum()
    abc_df["cumulative_percentage"] = (
        abc_df["cumulative_revenue"] / total_sales
    ) * 100

    # 6. Asignar los segmentos A (<= 80%), B (80% - 95%) y C (> 95%)
    def assign_abc(pct):
        if pct <= 80.0:
            return "A"
        elif pct <= 95.0:
            return "B"
        else:
            return "C"

    abc_df["abc_segment"] = abc_df["cumulative_percentage"].apply(assign_abc)

    return abc_df


if __name__ == "__main__":
    # Prueba rápida unitaria del módulo con datos sintéticos
    sample_data = pd.DataFrame(
        {
            "Product Card Id": [101, 102, 103, 104, 105],
            "Product Name": [
                "Balón Padel Pro",
                "Pala Varlion",
                "Zapatillas Asics",
                "Grip",
                "Protector",
            ],
            "Order Item Quantity": [10, 50, 20, 5, 2],
            "Product Price": [15.0, 180.0, 90.0, 5.0, 4.0],
        }
    )

    result_df = calculate_abc_classification(sample_data)
    print("--- Clasificación ABC generada con éxito ---")
    print(
        result_df[
            [
                "Product Name",
                "total_revenue",
                "cumulative_percentage",
                "abc_segment",
            ]
        ]
    )