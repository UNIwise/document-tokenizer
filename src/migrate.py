"""
    Database migration
"""

from database.connection import connection
from database.entity.event import Event

if __name__ == "__main__":
    with connection.begin() as session:
        session.execute("CREATE DATABASE IF NOT EXISTS test")
        Event.__table__.create(session.get_bind())
