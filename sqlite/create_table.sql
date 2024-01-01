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
