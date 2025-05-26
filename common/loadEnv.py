import os
from dotenv import load_dotenv
load_dotenv('./common/.env', encoding="utf-8")
load_dotenv()
os.CPF_FRETO = os.getenv('CPF')
os.CPF_FRETO = os.getenv('CPF_FRETO')
os.CPF_FRETO = os.getenv('CPF_FRETO')
os.DB_HOST = os.getenv('DB_HOST')

print(os.CPF_FRETO, os.DB_HOST)