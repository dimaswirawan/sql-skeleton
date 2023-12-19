create or replace view rekap as
  SELECT
    p.id AS id_rekap,
    p.data_content_integer AS nominal,
    MAX(CASE WHEN meta.meta_key = 'month' THEN meta.meta_value END) AS bulan,
    MAX(CASE WHEN meta.meta_key = 'year' THEN meta.meta_value END) AS tahun
  FROM data AS p
  JOIN datameta AS meta ON meta.data_id = p.id
  WHERE p.data_type = 'rekap'
  AND meta.meta_key IN ('month', 'year')
  GROUP BY p.id
