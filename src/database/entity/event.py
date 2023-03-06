"""Event table entity"""
from typing import Any

from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base: Any = declarative_base()


class Event(Base):  # pylint: disable=too-few-public-methods
    """Event entity"""

    __tablename__ = "events"

    id = Column(Integer, primary_key=True)

    test_id = Column(Integer)
    content = Column(String)
