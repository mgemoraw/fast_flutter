from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware


from routes import user

from logger import logger
from middleware import log_middleware, AuthMiddleware


app = FastAPI()
logger.info("Starting API...")


app.add_middleware(BaseHTTPMiddleware, dispatch=log_middleware)
# @app.middleware("http")
# async def log_middleware(request:Request, call_next):
#     log_dict = {
#         "url": request.url.path,
#         "method": request.method,
#     }

#     logger.info(log_dict)

#     response = await call_next(request)
#     return response 


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# app.add_middleware(AuthMiddleware)

app.include_router(user.router)

