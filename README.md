# Task Tracker

A production-ready FastAPI microservice for task management with PostgreSQL, SQLAlchemy ORM, and complete Docker Compose setup. Part of the SFAutomation portfolio demonstrating modern Python backend architecture.

---

## 🚀 Features

- **FastAPI Framework** - Fast, modern Python web framework with automatic API documentation
- **Task Management** - Create and list tasks with simple REST endpoints
- **PostgreSQL Integration** - Persistent data storage with SQL database
- **SQLAlchemy ORM 2.0** - Clean ORM using modern `select()` query syntax
- **Dependency Injection** - Clean, testable architecture with dependency management
- **Poetry** - Deterministic Python dependency management with lockfile
- **Docker & Docker Compose** - Complete containerized environment (web + database)
- **Health Check Endpoint** - Ready for orchestration and monitoring
- **Development & Production Ready** - Works locally and in containerized environments

---

## 📋 Prerequisites

- **Docker** and **Docker Compose** (recommended)
- **Python 3.11+** (for local development)
- **Poetry** (for local dependency management)
- **.env file** with database credentials

---

## ⚡ Quick Start

### Option 1: Docker Compose (Recommended)

1. **Clone the repository**

   ```bash
   git clone https://github.com/sfautomation-dev/task-tracker.git
   cd task-tracker
   ```

2. **Create `.env` file**

   ```bash
   cp .env.example .env
   ```

   Or manually create `.env`:

   ```env
   DATABASE_URL=postgresql://taskuser:taskpass@db:5432/taskdb
   POSTGRES_USER=taskuser
   POSTGRES_PASSWORD=taskpass
   POSTGRES_DB=taskdb
   ```

3. **Start services**

   ```bash
   docker-compose up --build
   ```

4. **Run migrations** (in another terminal)

   ```bash
   bash migrate.sh
   ```

5. **Access the API**
   - Web: http://localhost:8000
   - Interactive Docs: http://localhost:8000/docs
   - ReDoc: http://localhost:8000/redoc

---

### Option 2: Local Development

1. **Install dependencies**

   ```bash
   poetry install
   ```

2. **Create `.env` file**

   ```env
   DATABASE_URL=postgresql://taskuser:taskpass@localhost:5432/taskdb
   ```

3. **Ensure PostgreSQL is running** on localhost:5432

4. **Run the application**

   ```bash
   poetry run uvicorn app.main:app --reload
   ```

5. **Access the API** at http://localhost:8000

---

## 📚 API Endpoints

### Health Check

```http
GET /health
```

Returns application status.

**Response (200)**

```json
{
  "status": "ok"
}
```

---

### List Tasks

```http
GET /tasks
```

Retrieve all tasks ordered by ID.

**Response (200)**

```json
[
  {
    "id": 1,
    "title": "Complete project documentation",
    "done": false
  },
  {
    "id": 2,
    "title": "Deploy to production",
    "done": true
  }
]
```

---

### Create Task

```http
POST /tasks
Content-Type: application/json

{
  "title": "Learn FastAPI"
}
```

**Response (201)**

```json
{
  "id": 3,
  "title": "Learn FastAPI",
  "done": false
}
```

---

## 🏗️ Project Structure

```
task-tracker/
├── app/
│   ├── main.py           # FastAPI application, routes
│   ├── models.py         # SQLAlchemy ORM models
│   ├── database.py       # Database engine and session factory
│   ├── deps.py           # Dependency injection (get_db)
│   └── __pycache__/
├── docker-compose.yml    # Multi-container orchestration
├── Dockerfile            # Container image definition
├── pyproject.toml        # Poetry dependencies and config
├── poetry.lock           # Locked dependency versions
├── migrate.sh            # Database migration script
├── .env.example          # Environment variables template
├── README.md             # This file
└── LICENSE
```

---

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the project root:

```env
# Database Connection
DATABASE_URL=postgresql://taskuser:taskpass@db:5432/taskdb
POSTGRES_USER=taskuser
POSTGRES_PASSWORD=taskpass
POSTGRES_DB=taskdb
```

For local development without Docker, use:

```env
DATABASE_URL=postgresql://taskuser:taskpass@localhost:5432/taskdb
```

---

## 📦 Dependencies

**Core**

- `fastapi` ^0.100.0 - Web framework
- `uvicorn[standard]` ^0.22.0 - ASGI server
- `sqlalchemy` ^2.0.0 - ORM
- `psycopg2-binary` ^2.9.0 - PostgreSQL driver
- `python-dotenv` ^1.0.0 - Environment variable management

**Python Version**: ^3.11

See `pyproject.toml` for complete dependency list.

---

## 🐳 Docker

### Build Image

```bash
docker build -t task-tracker:latest .
```

### Run Container

```bash
docker run -p 8000:8000 --env-file .env task-tracker:latest
```

### Using Docker Compose

```bash
# Start services
docker-compose up --build

# Stop services
docker-compose down

# View logs
docker-compose logs -f web

# Run migrations
bash migrate.sh
```

---

## 🗄️ Database

### Schema

**tasks table**
| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PRIMARY KEY, AUTO INCREMENT |
| title | VARCHAR | NOT NULL |
| done | BOOLEAN | DEFAULT FALSE |

### Migrations

Tables are automatically created on application startup via SQLAlchemy's `Base.metadata.create_all()`.

For more control, run:

```bash
bash migrate.sh
```

---

## 🚀 Development

### Code Structure

- **`app/main.py`** - FastAPI application instance and route handlers
- **`app/models.py`** - SQLAlchemy ORM model definitions
- **`app/database.py`** - Database connection and session management
- **`app/deps.py`** - Dependency injection functions

### Running Tests

```bash
poetry run pytest
```

### Code Formatting

```bash
poetry run black app/
poetry run isort app/
```

### Type Checking

```bash
poetry run mypy app/
```

---

## 📈 Scaling & Production

### Recommendations

1. **Database Connection Pooling** - Consider `SQLAlchemy` connection pooling for production
2. **CORS Middleware** - Add CORS if frontend is on different domain
3. **Authentication** - Implement JWT or OAuth2 for security
4. **Logging** - Use Python's `logging` module with centralized aggregation
5. **Monitoring** - Add Prometheus metrics and health checks
6. **Database Migrations** - Use Alembic for version-controlled migrations
7. **Load Balancing** - Deploy multiple instances behind nginx/load balancer

---

## 🐛 Troubleshooting

### Port Already in Use

```bash
# Free port 8000
sudo lsof -ti:8000 | xargs kill -9

# Use different port
poetry run uvicorn app.main:app --port 8001
```

### Database Connection Failed

- Verify PostgreSQL is running
- Check DATABASE_URL in `.env`
- Ensure credentials match PostgreSQL setup
- For Docker: `docker-compose logs db`

### Docker Build Fails

```bash
# Clear cache and rebuild
docker-compose down --volumes
docker-compose build --no-cache
```

---

## 📝 License

See `LICENSE` file for details.

---

## 👤 Author

Built by **SFAutomation** as a demonstration of modern Python backend architecture and best practices.
