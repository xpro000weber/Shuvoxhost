-- Run in Supabase SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  role text not null default 'user' check (role in ('user', 'admin')),
  created_at timestamptz not null default now()
);

create table if not exists public.bots (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  status text not null default 'stopped'
    check (status in ('stopped', 'queued', 'running', 'failed')),
  entry_file text not null default 'main.py',
  created_at timestamptz not null default now()
);

create table if not exists public.deployments (
  id uuid primary key default gen_random_uuid(),
  bot_id uuid not null references public.bots(id) on delete cascade,
  status text not null default 'queued',
  created_at timestamptz not null default now(),
  finished_at timestamptz
);

create table if not exists public.bot_logs (
  id bigserial primary key,
  bot_id uuid not null references public.bots(id) on delete cascade,
  level text not null default 'info',
  message text not null,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.bots enable row level security;
alter table public.deployments enable row level security;
alter table public.bot_logs enable row level security;

create policy "read own profile" on public.profiles
  for select using (auth.uid() = id);
create policy "read own bots" on public.bots
  for select using (auth.uid() = user_id);
create policy "create own bots" on public.bots
  for insert with check (auth.uid() = user_id);
create policy "read deployments for own bots" on public.deployments
  for select using (
    exists (select 1 from public.bots b where b.id = bot_id and b.user_id = auth.uid())
  );
create policy "read logs for own bots" on public.bot_logs
  for select using (
    exists (select 1 from public.bots b where b.id = bot_id and b.user_id = auth.uid())
  );
