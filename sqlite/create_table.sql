CREATE TABLE IF NOT EXISTS "data" (
	"id"	INTEGER NOT NULL UNIQUE,
	"data_title"	TEXT,
	"data_content"	TEXT,
	"data_content_integer"	INTEGER,
	"data_type"	TEXT,
	"data_name"	TEXT,
	"data_parent"	TEXT,
	"data_status"	TEXT,
	"data_date"	TEXT,
	"data_modified"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "datameta" (
	"id"	INTEGER NOT NULL UNIQUE,
	"data_id"	INTEGER,
	"meta_key"	TEXT,
	"meta_value"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE IF NOT "term_relationships" (
	"object_id"	INTEGER,
	"term_taxonomy_id"	INTEGER,
	"term_order"	INTEGER,
	PRIMARY KEY("object_id")
);

CREATE TABLE IF NOT "terms" (
	"term_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	"slug"	TEXT,
	"term_group"	TEXT,
	PRIMARY KEY("term_id" AUTOINCREMENT)
);

CREATE TABLE IF NOT "termmeta" (
	"meta_id"	INTEGER NOT NULL UNIQUE,
	"term_id"	INTEGER,
	"meta_key"	TEXT,
	"meta_value"	TEXT,
	PRIMARY KEY("meta_id" AUTOINCREMENT)
);

CREATE TABLE IF NOT "term_taxonomy" (
	"term_taxonomy_id"	INTEGER NOT NULL UNIQUE,
	"term_id"	INTEGER,
	"taxonomy"	TEXT,
	"description"	TEXT,
	"parent"	INTEGER,
	"count"	INTEGER,
	PRIMARY KEY("term_taxonomy_id" AUTOINCREMENT)
);
