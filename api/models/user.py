from sqlalchemy import Table, Column
from sqlalchemy.sql.sqltypes import Integer, String
from config.db import meta, engine


users = Table('users', meta, 
    Column('id', Integer, primary_key=True, index=True),
    Column('name', String(255)),
    Column('email', String(255)),
    Column('password', String(255)),
    )

homes = Table('homes', meta,
    Column('id', Integer, primary_key=True),
    Column('location', String(255)),    
    Column('city', String(255)),
    )


# creates table when run
meta.create_all(engine)
