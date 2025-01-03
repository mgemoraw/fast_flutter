from sqlalchemy import create_engine, MetaData

password = 'sgetme'
user = 'sgetme'
host = 'localhost'
port = "3306"
database = "test"

engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}:{port}/{database}')
# engine = create_engine(f"psql+psycopg://{user}:{password}@{host}:{port}/{database}")

meta = MetaData()
conn = engine.connect()


 