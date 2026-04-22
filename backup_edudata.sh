#!/bin/bash

# --- CONFIGURACIÓN ---
CONTAINER_NAME="edudata-db-1" # Ejecuta 'docker ps' para ver el nombre
DB_NAME="edudatamx"
DB_USER="root"
DB_PASS="root"
BACKUP_DIR="$HOME/backups/sql"
FECHA=$(date +%Y-%m-%d_%H%M%S)
# ---------------------

mkdir -p $BACKUP_DIR

echo "Iniciando respaldo de Docker..."

# Usamos 'docker exec' para correr mysqldump dentro del contenedor
# Enviamos el resultado a un archivo comprimido en el HOST
docker exec -e MYSQL_PWD=$DB_PASS $CONTAINER_NAME /usr/bin/mysqldump --single-transaction --triggers --set-gtid-purged=OFF -u $DB_USER $DB_NAME | gzip >$BACKUP_DIR/$DB_NAME-$FECHA.sql.gz

# Limpieza: Borrar archivos de más de 7 días
find $BACKUP_DIR -type f -mtime +7 -name "*.sql.gz" -delete

echo "Respaldo completado: $BACKUP_DIR/$DB_NAME-$FECHA.sql.gz"
