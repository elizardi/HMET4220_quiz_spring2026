-- Run this once in Supabase SQL Editor

create extension if not exists pgcrypto;

create table if not exists public.quiz_attempts (
  attempt_id text primary key,
  quiz_name text not null,
  total_questions integer not null,
  score integer not null,
  score_pct numeric(5,2) not null,
  answers jsonb not null,
  submitted_at timestamptz not null,
  created_at timestamptz not null default now()
);

alter table public.quiz_attempts enable row level security;

-- Public anonymous inserts from quiz page
drop policy if exists "anon can insert quiz attempts" on public.quiz_attempts;
create policy "anon can insert quiz attempts"
  on public.quiz_attempts
  for insert
  to anon
  with check (true);

-- Public anonymous read from admin dashboard page
drop policy if exists "anon can read quiz attempts" on public.quiz_attempts;
create policy "anon can read quiz attempts"
  on public.quiz_attempts
  for select
  to anon
  using (true);
