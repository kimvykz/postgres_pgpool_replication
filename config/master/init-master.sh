#!/bin/bash
set -e

# copy config
cp /configs/postgresql.conf /var/lib/postgresql/data/
cp /configs/pg_hba.conf /var/lib/postgresql/data/

# creating user for replication
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE ${POSTGRES_USER} REPLICATION LOGIN ENCRYPTED PASSWORD '${POSTGRES_PASSWORD}';
EOSQL