-- Cursada · Ingeniería Industrial
-- Pegá todo esto en Supabase → SQL Editor → New query → Run. Se corre una sola vez.

-- 1) Tabla donde se guardan tus datos, repartidos en filas (una por materia, la carrera, la configuración, etc.)
create table if not exists public.cursada_docs (
  user_id    uuid not null references auth.users(id) on delete cascade,
  key        text not null,
  data       jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);

-- Solo vos podés leer y escribir tus filas.
alter table public.cursada_docs enable row level security;

drop policy if exists "leer lo propio"      on public.cursada_docs;
drop policy if exists "crear lo propio"     on public.cursada_docs;
drop policy if exists "modificar lo propio" on public.cursada_docs;
drop policy if exists "borrar lo propio"    on public.cursada_docs;

create policy "leer lo propio"      on public.cursada_docs for select using (auth.uid() = user_id);
create policy "crear lo propio"     on public.cursada_docs for insert with check (auth.uid() = user_id);
create policy "modificar lo propio" on public.cursada_docs for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "borrar lo propio"    on public.cursada_docs for delete using (auth.uid() = user_id);

-- 2) Depósito privado para PDFs y fotos (cada usuario solo ve su carpeta).
insert into storage.buckets (id, name, public, file_size_limit)
values ('archivos', 'archivos', false, 20971520)
on conflict (id) do nothing;

-- Solo PDFs e imágenes, hasta 20 MB.
update storage.buckets set allowed_mime_types = array['application/pdf','image/*'], file_size_limit = 20971520 where id = 'archivos';

drop policy if exists "archivos: leer lo propio"   on storage.objects;
drop policy if exists "archivos: subir lo propio"  on storage.objects;
drop policy if exists "archivos: cambiar lo propio" on storage.objects;
drop policy if exists "archivos: borrar lo propio" on storage.objects;

create policy "archivos: leer lo propio"   on storage.objects for select using (bucket_id = 'archivos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "archivos: subir lo propio"  on storage.objects for insert with check (bucket_id = 'archivos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "archivos: cambiar lo propio" on storage.objects for update using (bucket_id = 'archivos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "archivos: borrar lo propio" on storage.objects for delete using (bucket_id = 'archivos' and (storage.foldername(name))[1] = auth.uid()::text);
