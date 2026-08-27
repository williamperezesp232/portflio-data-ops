import os
from pathlib import Path
import pandas as pd
from dotenv import dotenv_values
from sqlalchemy import create_engine

# Carga las variables directamente como un diccionario omitiendo el entorno del sistema
env_path = Path(__file__).resolve().parent.parent / '.env'
config = dotenv_values(dotenv_path=env_path, encoding='utf-8-sig')

USER = config.get('DB_USER')
PASSWORD = config.get('DB_PASSWORD')
HOST = config.get('DB_HOST')
PORT = config.get('DB_PORT')
DB_NAME = config.get('DB_NAME')

DATABASE_URL = f"postgresql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB_NAME}"
engine = create_engine(DATABASE_URL)

try:
    with engine.connect() as connection:
        df = pd.read_sql('SELECT 1 AS conexion_exitosa;', connection)
        print('Conexion segura lograda con exito usando .env')
        print(df)
except Exception as e:
    print(f'Error al conectar: {e}')
