# task-tracker/Dockerfile - robust Poetry install via pip
FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    POETRY_VERSION=1.8.3

# Install system deps needed for building packages and Postgres client libs
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl build-essential libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Ensure pip is up-to-date and install poetry via pip (reliable inside build)
RUN python -m pip install --upgrade pip setuptools \
    && python -m pip install "poetry==$POETRY_VERSION"

# Copy pyproject first so layer caching helps
COPY pyproject.toml poetry.lock* /app/

# Use poetry to install dependencies (no-root installs only deps)
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# Copy project files
COPY . /app

EXPOSE 8000

# Run uvicorn via poetry so environment is consistent
CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--proxy-headers"]
