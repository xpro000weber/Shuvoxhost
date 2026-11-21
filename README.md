# ShuvoX Hosting Web

Starter project for a multi-user Python Telegram bot hosting dashboard.

## Architecture
- `frontend/`: static dashboard UI (served by Vercel)
- `api/` + `backend/`: FastAPI API (Vercel serverless entrypoint)
- `worker/`: separate Docker worker service scaffold; bot processes must run here, not inside Vercel functions
- `database/schema.sql`: Supabase PostgreSQL schema

## Important
This is a starter scaffold, not a production-ready public hosting service. The UI and API structure are provided, but the worker control-plane integration, robust authentication, upload pipeline, quotas, billing/abuse controls, and production isolation still need implementation and testing.

Never expose bot tokens or admin passwords in frontend code or Git. Set secrets as environment variables. The old sample password `1111` is weak and is deliberately NOT configured as a production default.

## Deploy frontend/API to Vercel
1. Push this folder to a GitHub repository.
2. Import the repository in Vercel.
3. Set environment variables:
   - `SUPABASE_URL`
   - `SUPABASE_SERVICE_ROLE_KEY` (server-side only; never expose in browser)
   - `JWT_SECRET` (long random secret)
   - `ADMIN_USERNAME` (e.g. `shuvox`)
   - `ADMIN_PASSWORD_HASH` (bcrypt hash; do not use `1111` publicly)
4. Deploy.

The included API currently exposes a health endpoint and a placeholder bots endpoint. Add Supabase-backed auth and CRUD before public use.

## Run API locally
```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
uvicorn backend.main:app --reload
```

## Worker
Deploy `worker/` to a separate Linux VPS with Docker installed. Do not run untrusted uploaded Python directly on the host. The included worker is a safe starting-point placeholder and does not yet execute user uploads.
