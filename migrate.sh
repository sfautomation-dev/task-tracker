#!/usr/bin/env bash
set -e
echo "Waiting for DB to be ready..."
until docker-compose exec db pg_isready -U ${POSTGRES_USER}; do
  echo "Waiting for postgres..."
  sleep 1
done

echo "Creating/refelecting tables..."
docker-compose exec web poetry run python - <<'PY'
from sqlalchemy import create_engine, MetaData
import os
DATABASE_URL = os.environ.get('DATABASE_URL')
engine = create_engine(DATABASE_URL)
meta = MetaData()
meta.reflect(bind=engine)
meta.create_all(bind=engine)
print('Tables now:', meta.tables.keys())
PY

echo "Done."
