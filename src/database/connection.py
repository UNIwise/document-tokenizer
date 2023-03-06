"""
Handling of the database connection.
"""

from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from database import config


def new_connection() -> sessionmaker:
    """
    Creates a new connection to the database
    """
    conf = config.get_config()

    query = {}
    if not conf.secure:
        query["sslmode"] = "disable"

    url = URL.create(
        drivername="cockroachdb",
        username=conf.user,
        password=conf.password,
        host=conf.host,
        port=conf.port,
        database=conf.database,
        query=query,
    )

    engine = create_engine(url, echo=False, pool_pre_ping=True)

    return sessionmaker(bind=engine, expire_on_commit=False)


connection: sessionmaker = new_connection()
