"""
Entry point for the application.
"""

import logging
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, APIRouter, HTTPException, status
from pydantic import BaseModel
from service import service


def run():
    """
    Initial function
    """
    server = FastAPI()

    prefix_router = APIRouter(prefix="/event")

    origins = ["*"]

    server.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    @prefix_router.get("/{test_id}")
    async def fetch(test_id: int):
        try:
            return service.get_event(test_id)
        except Exception as error:
            logging.error(error)
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)

    class EventRequest(BaseModel):
        test_id: int
        content: str

    @prefix_router.post("/")
    async def create(event: EventRequest):
        try:
            service.create(event.test_id, event.content)
            return
        except Exception as error:
            logging.error(error)
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)

    server.include_router(prefix_router)

    return server
