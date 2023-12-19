create or replace function add_transaksi(
  nominal integer default 0,
  data_author integer default 0
) returns integer language plpgsql as $$
declare
  month text := CAST ((SELECT EXTRACT(MONTH FROM CURRENT_TIMESTAMP)) AS text);
  year text := CAST ((SELECT EXTRACT(YEAR FROM CURRENT_TIMESTAMP)) AS text);
  data_id integer;
  rekap_id integer;
begin
  if (select bulan from rekap where bulan = month and tahun = year) is null then
    insert into data(data_content_integer,data_type,data_author)
    values (nominal,'rekap',data_author)
    returning id into rekap_id;
    insert into datameta(data_id,meta_key,meta_value)
    values (rekap_id,'month',month);
    insert into datameta(data_id,meta_key,meta_value)
    values (rekap_id,'year',year);
  else
    rekap_id := (select id_rekap from rekap where bulan = month and tahun = year);
    UPDATE data 
    SET data_content_integer = data_content_integer + nominal
    WHERE id = rekap_id;
  end if;
  insert into data(data_content_integer,data_type,data_author)
  values (nominal,'transaksi',data_author)
  returning id into data_id;
  return data_id;
end;
$$;

create
or replace function get_transaksi (month integer default 9, year integer default 2023) returns setof record language sql as $$
  SELECT id as id, data_content_integer as nominal FROM data WHERE EXTRACT(MONTH FROM data_date) = month and EXTRACT(YEAR FROM data_date) = year and data_type = 'transaksi';
$$;

create or replace function update_transaksi(
  nominal integer default 0,
  old_nominal integer default 0,
  month text default '',
  year text default '',
  id_transaksi integer default 0
) returns integer language plpgsql as $$
declare
  data_id integer;
  rekap_id integer;
begin
  if (select bulan from rekap where bulan = month and tahun = year) is null then
  else
    rekap_id := (select id_rekap from rekap where bulan = month and tahun = year);
    UPDATE data 
    SET data_content_integer = data_content_integer - old_nominal
    WHERE id = rekap_id;
    UPDATE data 
    SET data_content_integer = data_content_integer + nominal
    WHERE id = rekap_id;
  end if;
    UPDATE data 
    SET data_content_integer = nominal
    WHERE id = id_transaksi;
  return id_transaksi;
end;
$$;

create or replace function delete_transaksi(
  id_transaksi integer default 0
) returns integer language plpgsql as $$
declare
  month text;
  year text;
  data_id integer;
  rekap_id integer;
  old_nominal integer;
begin
  month := (SELECT EXTRACT(MONTH FROM data_date) from data where id = id_transaksi);
  year := (SELECT EXTRACT(YEAR FROM data_date) from data where id = id_transaksi);
  if (select bulan from rekap where bulan = month and tahun = year) is null then
  else
    rekap_id := (select id_rekap from rekap where bulan = month and tahun = year);
    old_nominal := (select data_content_integer from data where id = id_transaksi);

    UPDATE data 
    SET data_content_integer = data_content_integer - old_nominal
    WHERE id = rekap_id;

  end if;
  
  DELETE FROM data WHERE id = id_transaksi;

  return id_transaksi;
end;
$$;
