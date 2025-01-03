from fastapi import APIRouter, Depends
from fastapi.security import HTTPBasic, HTTPBasicCredentials

from config.db import conn
from models.user import users, homes
from schemas.user import User, Home
from sqlalchemy.orm import Session as session
import asyncio


from dotenv import load_dotenv
import os
import secrets
import logging
import jwt  # Install with `pip install pyjwt`

# create user router
router = APIRouter()
security = HTTPBasic()



# Load environment variables
load_dotenv()


logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Security setup
security = HTTPBasic()
SECRET_KEY = os.getenv("SECRET_KEY", "default_secret_key")
ALGORITHM = "HS256"

if SECRET_KEY == "default_secret_key":
    logger.warning("SECRET_KEY is not set. Using an insecure default key.")

# Dummy user database
users_db = {
    "user1": "password1",
    "user2": "password2"
}




# Utility functions
def generate_token(username: str) -> str:
    payload = {"sub": username}
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

def authenticate_user(credentials: HTTPBasicCredentials = Depends(security)):
    if not secrets.compare_digest(credentials.password, users_db.get(credentials.username, "")):
        raise HTTPException(status_code=401, detail="Incorrect username or password")
    return credentials.username

# Routes
@router.get("/token")
async def get_token(credentials: HTTPBasicCredentials = Depends(authenticate_user)):
    username = credentials.username
    token = generate_token(username)
    return {"token": token}

@router.get('/users/index', status_code=200, response_model=None)
async def fetch_users():
    result =  conn.execute(users.select()).fetchall()
    conn.commit()
    
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
        conn.commit()
    except:
        return {"done": False}
    # return conn.execute(users.select()).fetchall() 
    return {"done": True}


@router.put('/users/update/{id}')
async def update_user(id: int, user: User):
    conn.execute(users.update().values(name=user.name, email=user.email, password=user.password).where(users.c.id==id))
    conn.commit()
    return {"done": True}

@router.delete('/users/delete/{id}')
async def delete_user(id: int):
    
    conn.execute(users.delete().where(users.c.id==id))
    conn.commit()
    return {"done": True}



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


@router.post("/upload/videos")
async def upload_videos() -> dict :
    await asyncio.sleep(1.5)
    return {"message": "Video uploaded"}

