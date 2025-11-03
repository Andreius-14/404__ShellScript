#!/bin/bash
#════════════════════════════════════════════════════════════════════
#                   Habilitando Modo Grafico
#════════════════════════════════════════════════════════════════════
# Variables necesarias para que cron hable con tu sesión gráfica
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XAUTHORITY=/home/carlos/.Xauthority

#════════════════════════════════════════════════════════════════════
#                  Variables de configuración
#════════════════════════════════════════════════════════════════════

ruta="/media/carlos/Personal"
ruta_log="/home/carlos/Documentos/Sync-rclone.log"

main="Andreius_14"
drive="Carma_379"

#Drive
drive_arte="$drive:/101__Arte"
drive_book="$drive:/Files/Mis-Libros"
drive_music="$drive:/101__Musica"
drive_personal="$main:/__Personal"

#Local
ruta_arte="$ruta/101__Arte"
ruta_book="$ruta/101__Libros"
ruta_music="$ruta/101__Musica"
ruta_personal="$ruta/__Personal"

flag=(
    --fast-list
    --progress
    --track-renames
    --create-empty-src-dirs
    --conflict-resolve newer
    --conflict-loser delete
)

rclone="/usr/bin/rclone"
send="/usr/bin/notify-send"

#════════════════════════════════════════════════════════════════════
#                       Function
#════════════════════════════════════════════════════════════════════
msm() {
    echo -e "\n==== $(date '+%Y-%m-%d %H:%M:%S') → Sincronizando $1 ====" >>"$ruta_log"
}

verificar_ruta_correcta() {
    #Enviando Data
    if [ ! -d "$1" ]; then
        #Log
        msm "Carpeta no encontrada: $1"
        #Usuario
        $send "Rclone ⚠️" "No existe la carpeta: $1"
        #Function
        return 1
    fi
}

run() {
    verificar_ruta_correcta "$1" || return 1

    $rclone bisync "$1" "$2" "${flag[@]}" >>"$ruta_log" 2>&1 || {
        $send "Rclone ❌" "Error - $1"
        $rclone bisync "$1" "$2" "${flag[@]}" --resync  >>"$ruta_log" 2>&1
    }
}

#Limpiando Archivo Log
[ -f "$ruta_log" ] && [ $(stat -c%s "$ruta_log") -gt 5000000 ] && : >"$ruta_log"

#════════════════════════════════════════════════════════════════════
#                      Ejecucion de Comandos
#════════════════════════════════════════════════════════════════════

/usr/bin/notify-send "Sincronizacion Rclone" "Sincronizacion Rclone y Google Drive hydra_falsa@outlook.com ✅"

msm "Arte"
run "$ruta_arte" "$drive_arte"

msm "Libros"
run "$ruta_book" "$drive_book"

msm "Musica"
run "$ruta_music" "$drive_music"

msm "Personal - A14"
run "$ruta_personal" "$drive_personal"

/usr/bin/notify-send "Sincronizacion Rclone" "Finalizado"
