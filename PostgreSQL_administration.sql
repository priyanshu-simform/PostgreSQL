--CREATE DATABASE
CREATE DATABASE new_db
WITH
	OWNER postgres
-- 	TEMPLATE
	ENCODING 'UTF8';
-- 	ALLOW_CONNECTIONS = true
-- 	CONNECTION LIMIT 10
-- 	IS_TEMPLATE = true;

CREATE DATABASE mydb
WITH
	OWNER postgres
-- 	TEMPLATE
	ENCODING 'UTF8';
-- 	ALLOW_CONNECTIONS = true
-- 	CONNECTION LIMIT 10
-- 	IS_TEMPLATE = true;


--ALTER DATABASE 
ALTER DATABASE mydb
WITH 
IS_TEMPLATE = FALSE;

ALTER DATABASE mydb
WITH
	CONNECTION LIMIT 20;
--rename
ALTER DATABASE mydb
RENAME TO mydatabase;

ALTER DATABASE mydatabase
OWNER TO ps;

ALTER DATABASE mydatabase
OWNER TO postgres;


--DROP DATABASE

--check activities on db
SELECT * FROM pg_stat_activity
WHERE datname='new_db';

--terminate active connection
SELECT pg_terminate_backend(pid)
FROM  pg_stat_activity
WHERE pg_stat_activity.datname='new_db';

--now drop actual db
DROP DATABASE new_db;


--COPY DATABASE
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname ='mydatabase';

CREATE DATABASE temp2
WITH TEMPLATE mydatabase;

--getting object size

SELECT pg_size_pretty(pg_relation_size('film'));
SELECT pg_size_pretty(pg_database_size('sample'));

SELECT pg_size_pretty(
	pg_database_size(pg_database.datname)) 
FROM pg_database;


--SCHEMA 
SELECT current_schema();

CREATE SCHEMA IF NOT EXISTS temp_sch
AUTHORIZATION newbie; 
--DROP SCHEMA
DROP SCHEMA temp_sch CASCADE;

--ROLES
SELECT * FROM pg_roles;

CREATE ROLE fam
CREATEDB
LOGIN 
PASSWORD 'fam'
VALID UNTIL '2024-01-01'
CONNECTION LIMIT 20;
SELECT * FROM 
information_schema.tables;


--GRANT PRIVILEGES
SELECT * FROM post4;
GRANT ALL
ON TABLE post4
TO fam;
--REVOKE PRIVILEGES
REVOKE ALL
ON TABLE post4
FROM fam;

--DROP ROLE
DROP ROLE fam;

SELECT * FROM pg_catalog.pg_user;


