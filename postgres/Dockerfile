FROM postgres:10.3

ADD /tables/ /docker-entrypoint-initdb.d/tables/
ADD /procedures/ /docker-entrypoint-initdb.d/procedures/
ADD /triggers/ /docker-entrypoint-initdb.d/triggers/
ADD /seed/ /docker-entrypoint-initdb.d/seed/
ADD deploy_schemas.sql /docker-entrypoint-initdb.d/