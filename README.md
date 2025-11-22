# Task Tracker — SFAutomation (FastAPI)

A small FastAPI-based task tracker containerized with Docker and Postgres. Built with Poetry inside container.

## Quickstart

1. Copy env: `cp .env.example .env`
2. Build & run: `docker-compose up --build`
3. Health: `curl http://localhost:8000/health`
4. Create task:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"title":"Test task"}' http://localhost:8000/tasks
```
