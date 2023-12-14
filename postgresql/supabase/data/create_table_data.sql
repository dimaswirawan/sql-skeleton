create table if not exists public.data (
	id bigint generated by default as identity,
	data_title text default "",
	data_content text default "",
	data_content_integer bigint default 0,
	data_type character varying default "",
	data_name character varying default "",
	data_status character varying default "",
	data_parent character varying default "",
	data_author bigint default 0,
	data_date timestamp with time zone default timezone('utc'::text, now()) not null,
	data_update timestamp with time zone default timezone('utc'::text, now()) not null,
    constraint data_pkey primary key (id)
)tablespace pg_default;