"""
Generic Service
"""

from database.repository import event_repository
from database.entity.event import Event


def get_event(test_id: int) -> Event:
    """Test get method"""
    return event_repository.get_event(test_id)


def create(test_id: int, content: str):
    """Test create method"""
    event_repository.create_event(Event(test_id=test_id, content=content))
