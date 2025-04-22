#!/bin/bash
set -e

# Если кластер пустой — делаем бэкап с мастера
if [ ! -s "$PGDATA/PG_VERSION" ]; then
  echo "Starting base backup from master..."

  PGPASSWORD=root pg_basebackup -h pg-master -U root -D "$PGDATA" -Fp -Xs -P -R

  echo "Base backup completed."
fi

# Старт PostgreSQL
exec docker-entrypoint.sh postgres