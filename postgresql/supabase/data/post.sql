create or replace function post_data(title text, slug text, type text, status text, parent text, content text,data_meta json,taxonomy json)
returns integer
language plpgsql
as $$
declare
  i json;
  data_id integer;
begin
  insert into data(data_title,data_content,data_slug,data_type,data_status,data_parent)
  values (title,content,slug,type,status,parent)
  returning id into data_id;
  FOR i IN SELECT * FROM json_array_elements(data_meta)
  LOOP
      INSERT INTO datameta(data_id,meta_key, meta_value)
      VALUES (data_id,i->>'key', i->>'value');
  END LOOP;
  return data_id;
end;
$$;
