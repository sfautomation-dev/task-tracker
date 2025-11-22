from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

import os

DATABASE_URL = os.environ.get("DATABASE_URL", "sqlite:///./local.db")

# create engine (future=True recommended for 2.0 behaviours)
engine = create_engine(DATABASE_URL, future=True, echo=False)

# SessionLocal factory — one session per request
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False, future=True)
