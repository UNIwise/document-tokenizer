"""Event entity repository"""

from sqlalchemy.sql import select
import pandas as pd

from database import connection
from database.entity.event import Event

db = connection.new_connection()


def get_event(test_id: int) -> Event:
    """Get all events from test_id"""
    with db.begin() as session:
        return session.query(Event).filter(Event.test_id == test_id).first()


def create_event(event: Event):
    with db.begin() as session:
        session.add(event)
