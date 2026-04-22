# Ejecutar respaldo todos los días a las 02:00 AM
00 02 * * * /bin/bash $HOME/scripts/backup_edudata.sh

# (Opcional) Restauración automática todos los lunes a las 06:00 AM
# Útil para "limpiar" la base de datos en entornos de prueba
00 06 * * 1 /bin/bash $HOME/scripts/restore_edudata.sh
