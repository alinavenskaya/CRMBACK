-- Deploy fresh database tables:
-- @ts-ignore
\i '/docker-entrypoint-initdb.d/tables/CRM.sql'
\i '/docker-entrypoint-initdb.d/procedures/procedures.sql'

\i '/docker-entrypoint-initdb.d/triggers/triggers.sql'
-- For testing purposes only. This file will add dummy data
\i '/docker-entrypoint-initdb.d/seed/seed.sql'
