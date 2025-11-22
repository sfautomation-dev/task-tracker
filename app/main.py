from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy import select
from sqlalchemy.orm import Session

from .deps import get_db
from .models import Task, Base
from .database import engine

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Task Tracker - SFAutomation")

class TaskIn(BaseModel):
    title: str

class TaskOut(BaseModel):
    id: int
    title: str
    done: bool

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/tasks", response_model=list[TaskOut])
def list_tasks(db: Session = Depends(get_db)):
    stmt = select(Task).order_by(Task.id)
    results = db.execute(stmt).scalars().all()
    return results

@app.post("/tasks", response_model=TaskOut, status_code=201)
def create_task(payload: TaskIn, db: Session = Depends(get_db)):
    new = Task(title=payload.title, done=False)
    db.add(new)
    db.commit()
    db.refresh(new)
    return new
