"""
Env config loader
"""

from dataclasses import dataclass
from environs import Env


@dataclass
class Config:
    """Data class for config"""

    host: str
    port: int
    user: str
    password: str
    database: str
    secure: bool


def get_config() -> Config:
    """Load envs into config"""
    env = Env()
    env.read_env(".env", recurse=False)
    with env.prefixed("COCKROACH_"):
        return Config(
            host=env("HOST"),
            port=env("PORT"),
            user=env("USER"),
            password=env("PASSWORD", ""),
            database=env("DATABASE"),
            secure=env("SECURE", False),
        )
