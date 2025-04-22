#!/bin/bash
set -e

# if cluster if empty — launch restoring a backup
if [ ! -s "$PGDATA/PG_VERSION" ]; then
  echo "Starting base backup from master..."

  PGPASSWORD=${POSTGRES_PASSWORD} pg_basebackup -h pg-master -U ${POSTGRES_USER} -D "$PGDATA" -Fp -Xs -P -R

  echo "Base backup completed."
fi

# Starting PostgreSQL
exec docker-entrypoint.sh postgres