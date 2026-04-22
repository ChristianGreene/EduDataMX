#!/bin/bash

# --- CONFIGURACIÓN ---
CONTAINER_NAME="edudata-db-1"
DB_NAME="edudatamx"
DB_USER="root"
DB_PASS="root"
BACKUP_DIR="$HOME/backups/sql"
# ---------------------

# Buscar el último respaldo
LATEST_BACKUP=$(ls -t $BACKUP_DIR/*.sql.gz | head -1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "No hay respaldos para restaurar."
  exit 1
fi

echo "Restaurando base de datos en Docker desde: $LATEST_BACKUP"

# Descomprimir y pasar el SQL al comando mysql dentro de docker
zcat $LATEST_BACKUP | docker exec -i -e MYSQL_PWD=$DB_PASS $CONTAINER_NAME /usr/bin/mysql -u $DB_USER $DB_NAME

echo "Restauración finalizada con éxito."
