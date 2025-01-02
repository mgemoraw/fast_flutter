from fastapi import APIRouter
from config.db import conn
from models.user import users, homes
from schemas.user import User, Home
from sqlalchemy.orm import Session as session

# create user router
router = APIRouter()


@router.get('/users/index', status_code=200, response_model=None)
async def fetch_users():
    result =  conn.execute(users.select()).fetchall()
    
    data = []

    for row in result:
        data.append(
            {'id': row[0], 'name': row[1], 'email': row[2], 'password': row[3]}
        )
    
    return data

@router.post('/users/create')
async def insert_user(user: User):
    try:
        conn.execute(users.insert().values(name=user.name, email=user.email, password=user.password))
    except:
        return {"done": False}
    # return conn.execute(users.select()).fetchall() 
    return {"done": True}


@router.put('/users/update/{id}')
async def update_user(id: int, user: User):
   return  conn.execute(users.update().values(name=user.name, email=user.email, password=user.password).where(users.c.id==id))


@router.delete('/users/delete/{id}')
async def delete_user(id: int):
    return  conn.execute(users.delete().where(users.c.id==id))




# testing api
@router.get('/data')
async def index():
    return  {"name": "First Data"}

@router.get("/blog/{id}")
async def index(id: int):
    return {'data': id}

@router.get("/blog/{id}")
async def comments(id: int):
    # fetch comments of the blog
    return {'data': {"1", "2"}}



@router.post("/homes/create")
async def insert_home(home: Home):
    try:
        return conn.execute(homes.insert().values(
            location=home.location,
            city=home.city,
        ))
    except:
        return {"done": True}


@router.get("/homes/index")
async def read_homes():
    result = conn.execute(homes.select())

    homes = []
    for row in result:
        homes.append(
             {'id': row[0], 'location': row[1], 'city': row[2],}
        )
        print(row)   
    return homes

