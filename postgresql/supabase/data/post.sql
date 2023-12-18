create
or replace function post_data(
  data_title text default '',
  data_content text default '',
  data_content_integer integer default 0,
  data_type text default '',
  data_name text default '',
  data_status text default '',
  data_parent text default '',
  data_author integer default 0,
  meta json default '[]',
  taxonomy json default '[]'
) returns integer language plpgsql as $$
declare
  i json;
  data_id integer;
begin
  insert into data(data_title,data_content,data_name,data_type,data_status,data_parent)
  values (data_title,data_content,data_name,data_type,data_status,data_parent)
  returning id into data_id;
  FOR i IN SELECT * FROM json_array_elements(meta)
  LOOP
      INSERT INTO datameta(data_id,meta_key, meta_value)
      VALUES (data_id,i->>'meta_key', i->>'meta_value');
  END LOOP;
  return data_id;
end;
$$;
