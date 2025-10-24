#!/bin/bash

#════════════════════════════════════════════════════════════════════
#                   Habilitando Modo Grafico
#════════════════════════════════════════════════════════════════════
# Variables necesarias para que cron hable con tu sesión gráfica
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export XAUTHORITY="$HOME/.Xauthority" # <-- esta asegura el acceso a tu sesión

#════════════════════════════════════════════════════════════════════
#                  Variables de configuración
#════════════════════════════════════════════════════════════════════
ruta_log="$HOME/Documentos/Sync-spotdl.log"
ruta_prueba="$HOME/Música/"
ruta_playlist="/media/carlos/Personal/101__Musica/Spotify - Mis Playlist/"

spotdl="$HOME/.local/bin/spotdl"

#════════════════════════════════════════════════════════════════════
#                       Function
#════════════════════════════════════════════════════════════════════
msm_log() {
    echo "==== $(date '+%Y-%m-%d %H:%M:%S') → Sincronizando $1 ====" >>"$ruta_log"
}

msm(){ 
    /usr/bin/notify-send "Sincronizacion Spotdl - $1" 
}

run() {
    local ruta=$1
    #Bucle
    while IFS= read -r -d '' ruta_File; do

        #Variables
        local carpeta="$(dirname "$ruta_File")"
        local titulo="$(basename "$carpeta")"
        local formato=$(ls "$carpeta" | grep -Eo "(opus|mp3|m4a|ogg)$" | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')

        #Contingencia
        [[ -z "$formato" ]] && formato="opus"

        #Ejecucion
        msm_log "$titulo (formato: $formato)"

        if $spotdl --format "$formato" sync "$ruta_File" --overwrite skip --output "$carpeta" >>"$ruta_log" 2>&1; then
            msm "✅ $titulo completado"
        else
            msm "❌ Error en $titulo"
        fi

    done < <(find "$ruta" -name "*.spotdl" -print0 )

}

# ═══════════════════════════════
#             clean
# ═══════════════════════════════

[ -f "$ruta_log" ] && [ $(stat -c%s "$ruta_log") -gt 5000000 ] && : >"$ruta_log"

#════════════════════════════════════════════════════════════════════
#                      Ejecucion de Comandos
#════════════════════════════════════════════════════════════════════


# msm "Prueba"
# run "$ruta_prueba"

msm "Playlist"
run "$ruta_playlist"

msm "Proceso completado"
msm_log "Fin de sincronización"
