from fastapi import APIRouter
from config.db import conn
from models.user import users, homes
from schemas.user import User, Home
from sqlalchemy.orm import Session as session

# create user router
router = APIRouter()


@router.get('/', status_code=200, response_model=None)
async def fetch_users():
    result =  conn.execute(users.select()).fetchall()
    
    data = []

    for row in result:
        data.append(
            {'id': row[0], 'name': row[1], 'email': row[2], 'password': row[3]}
        )
    
    return data

@router.post('/')
async def insert_user(user: User):
    try:
        conn.execute(users.insert().values(name=user.name, email=user.email, password=user.password))
    except:
        return {"done": False}
    # return conn.execute(users.select()).fetchall() 
    return {"done": True}


@router.put('/{id}')
async def update_user(id: int, user: User):
   return  conn.execute(users.update().values(name=user.name, email=user.email, password=user.password).where(users.c.id==id))


@router.delete('/{id}')
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



@router.post("/data")
async def insert_home(home: Home):
    return conn.execute(homes.insert().values(
        location=home.location,
        city=home.city,
    ))


@router.get("/homes")
async def read_homes():
    result = conn.execute(homes.select())
    print((result))
    print(dict(result))
    
    for row in result:
        print(row)
    return {}

    # return None