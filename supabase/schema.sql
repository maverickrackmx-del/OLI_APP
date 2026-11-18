-- Esquema inicial de OLI para guardar proyectos en Supabase.
-- Ejecuta este archivo en el SQL Editor del proyecto Supabase.
-- No contiene claves ni contraseñas.

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  name text not null check (char_length(name) between 1 and 80),
  files jsonb not null default '{}'::jsonb check (jsonb_typeof(files) = 'object'),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint projects_files_size_limit check (octet_length(files::text) <= 524288)
);

create index if not exists projects_user_updated_idx
  on public.projects (user_id, updated_at desc);

alter table public.projects enable row level security;

revoke all on table public.projects from anon;
grant select, insert, update, delete on table public.projects to authenticated;

drop policy if exists "Users can read their own projects" on public.projects;
create policy "Users can read their own projects"
  on public.projects for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own projects" on public.projects;
create policy "Users can create their own projects"
  on public.projects for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own projects" on public.projects;
create policy "Users can update their own projects"
  on public.projects for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own projects" on public.projects;
create policy "Users can delete their own projects"
  on public.projects for delete to authenticated
  using ((select auth.uid()) = user_id);

create or replace function public.set_project_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_project_updated_at on public.projects;
create trigger set_project_updated_at
  before update on public.projects
  for each row execute function public.set_project_updated_at();
