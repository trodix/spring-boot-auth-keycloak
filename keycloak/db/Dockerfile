FROM postgres

ARG BACKUP_FILE=./dbexport.sql

COPY ${BACKUP_FILE} /docker-entrypoint-initdb.d/

