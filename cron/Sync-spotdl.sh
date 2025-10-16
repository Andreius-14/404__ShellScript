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
        local ruta_Parent="$(dirname "$ruta_File")"
        local name_Parent="$(basename "$ruta_Parent")"
        local formato=$(ls "$ruta_Parent" | grep -Eo "(opus|mp3|m4a|ogg)$" | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')
        [[ -z "$formato" ]] && formato="opus"

        #Ejecucion
        msm_log "$name_Parent (formato: $formato)"

        if $spotdl --format "$formato" sync "$ruta_File" --overwrite skip --output "$ruta_Parent" >>"$ruta_log" 2>&1; then
            msm "✅ $name_Parent completado"
        else
            msm "❌ Error en $name_Parent"
        fi

    done < <(find "$ruta" -name "*.spotdl" -print0 2>/dev/null) # Maneja si no hay


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
