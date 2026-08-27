import os
import pandas as pd
from sqlalchemy import create_engine

USER = "postgres"
PASSWORD = "princesa" 
HOST = "localhost"
PORT = "5432"
DB_NAME = "supply_chain_db"      # <-- Cambia por el nombre de tu base de datos

DATABASE_URL = f"postgresql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB_NAME}"
engine = create_engine(DATABASE_URL)

try:
    with engine.connect() as connection:
        df = pd.read_sql("SELECT 1 AS conexion_exitosa;", connection)
        print("¡Conexión lograda con éxito!")
        print(df)
except Exception as e:
    print(f"Error al conectar: {e}")