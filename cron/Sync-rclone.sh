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

drive="Carma_379"
ruta="/media/carlos/Personal"

drive_arte="$drive:/101__Arte"
drive_book="$drive:/Files/Mis-Libros"
drive_music="$drive:/101__Musica"

ruta_arte="$ruta/101__Arte"
ruta_book="$ruta/101__Libros"
ruta_music="$ruta/101__Musica"

flag=(--progress --track-renames)

#════════════════════════════════════════════════════════════════════
#                       Function
#════════════════════════════════════════════════════════════════════

msm(){
    echo "==== $(date '+%Y-%m-%d %H:%M:%S') → Sincronizando $1 ====" >> "$ruta_log"
}

run(){
    /usr/bin/rclone bisync "$1" "$2" "${flag[@]}" >>"$ruta_log" 2>&1  \
 || /usr/bin/notify-send "Rclone ❌" "Error en: $1"
}

#════════════════════════════════════════════════════════════════════
#                      Ejecucion de Comandos
#════════════════════════════════════════════════════════════════════

msm "Arte"
run "$ruta_arte" "$drive_arte" 

msm "Libros"
run "$ruta_book" "$drive_book"

msm "Musica"
run "$ruta_music" "$drive_music"
