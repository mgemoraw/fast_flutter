from pydantic import BaseModel


class User(BaseModel):
    id: int
    name: str
    email: str
    password: str

    class Config:
        orm_mode = True
        
class Home(BaseModel):
    location: str
    city: str

