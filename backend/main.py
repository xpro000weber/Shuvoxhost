from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import os

app = FastAPI(title="ShuvoX Hosting Web API", version="0.1.0")

# Restrict this to your deployed frontend domain before production.
allowed_origins = os.getenv("ALLOWED_ORIGINS", "*").split(",")
app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PATCH", "DELETE"],
    allow_headers=["Authorization", "Content-Type"],
)

class BotCreate(BaseModel):
    name: str

@app.get("/")
def root():
    return {"name": "ShuvoX Hosting Web", "status": "starter"}

@app.get("/health")
def health():
    return {"ok": True}

@app.get("/bots")
def list_bots():
    # TODO: return only bots owned by the authenticated user from Supabase.
    return {"items": [], "note": "Connect authentication and Supabase before production."}

@app.post("/bots")
def create_bot(payload: BotCreate):
    # TODO: create a bot record and enqueue a worker deployment job.
    return {
        "accepted": False,
        "bot_name": payload.name,
        "note": "Deployment pipeline is not connected yet."
    }
