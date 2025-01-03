from logger import logger 
from fastapi import Request, HTTPException
from starlette.middleware.base import BaseHTTPMiddleware

import time 
import logging 
import jwt
import os 

SECRET_KEY = os.getenv("SECRET_KEY", "default_secret_key")
ALGORITHM = "HS256"

if SECRET_KEY == "default_secret_key":
    logger.warning("SECRET_KEY is not set. Using an insecure default key.")

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

async def log_middleware(request: Request, call_next):
    start = time.time()

    response = await call_next(request)

    process_time = time.time() - start 
    log_dict = {
        "url": request.url.path,
        "method": request.method,
        "process_time": process_time,
    }

    logger.info(log_dict, extra=log_dict)
    return response 



# Middleware for authentication
class AuthMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        excluded_paths = ["/docs", "/openapi.json", "/open-route"]
        if any(request.url.path.startswith(path) for path in excluded_paths):
            return await call_next(request)
        
        auth_header = request.headers.get("Authorization")
        if not auth_header or not self.verify_token(auth_header):
            logger.warning(f"Unauthorized access attempt on {request.url.path}")
            raise HTTPException(status_code=401, detail="Unauthorized")
        
        return await call_next(request)

    def verify_token(self, token: str) -> bool:
        try:
            jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            return True
        except jwt.ExpiredSignatureError:
            logger.warning("Token has expired")
        except jwt.InvalidTokenError:
            logger.warning("Invalid token")
        return False