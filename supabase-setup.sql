-- Flip clock cloud sync: run once in Supabase → SQL Editor (same project as QuizCraft).
create table if not exists public.flipclock (
  user_id    uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.flipclock enable row level security;
drop policy if exists "own row read"   on public.flipclock;
drop policy if exists "own row insert" on public.flipclock;
drop policy if exists "own row update" on public.flipclock;
create policy "own row read"   on public.flipclock for select using (auth.uid() = user_id);
create policy "own row insert" on public.flipclock for insert with check (auth.uid() = user_id);
create policy "own row update" on public.flipclock for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
