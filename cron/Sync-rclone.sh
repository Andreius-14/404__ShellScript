#!/bin/bash
# Fecha y hora en el log
echo "[$(date)] Iniciando sincronización..."

#════════════════════════════════════════════════════════════════════
#                   Habilitando Modo Grafico
#════════════════════════════════════════════════════════════════════
# Variables necesarias para que cron hable con tu sesión gráfica
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XAUTHORITY=/home/carlos/.Xauthority # <-- esta asegura el acceso a tu sesión

#════════════════════════════════════════════════════════════════════
#                                UI
#════════════════════════════════════════════════════════════════════
# Voz en terminal (Speech Dispatcher)
# /usr/bin/spd-say "Sincronización completada con Rclone"
/usr/bin/notify-send "Sincronizacion Rclone" "Sincronizacion Rclone y Google Drive hydra_falsa@outlook.com ✅"

#════════════════════════════════════════════════════════════════════
#                  Variables de configuración
#════════════════════════════════════════════════════════════════════

ruta_log="/home/carlos/Documentos/Sync-rclone.log"

remoto_hobby="Carma_379"

drive_arte="$remoto_hobby:/101__Arte"
drive_book="$remoto_hobby:/Files/Mis-Libros"
drive_music="$remoto_hobby:/101__Musica"

ruta_arte="/media/carlos/Personal/101__Arte"
ruta_book="/media/carlos/Personal/101__Libros"
ruta_music="/media/carlos/Personal/101__Musica"

#════════════════════════════════════════════════════════════════════
#                      Ejecucion de Comandos
#════════════════════════════════════════════════════════════════════

echo "==== $(date '+%Y-%m-%d %H:%M:%S') → Sincronizando Arte ====" >>"$ruta_log"
/usr/bin/rclone bisync "$ruta_arte" "$drive_arte" --progress >>"$ruta_log" 2>&1

echo "==== $(date '+%Y-%m-%d %H:%M:%S') → Sincronizando Libros ====" >>"$ruta_log"
/usr/bin/rclone bisync "$ruta_book" "$drive_book" --progress >>"$ruta_log" 2>&1

echo "==== $(date '+%Y-%m-%d %H:%M:%S') → Sincronizando Musica ====" >>"$ruta_log"
/usr/bin/rclone bisync "$ruta_music" "$drive_music" --progress >>"$ruta_log" 2>&1
