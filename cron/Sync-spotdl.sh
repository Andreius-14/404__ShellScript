#!/bin/bash
source __Shared-Cron.sh
# ---------------------------------------------------------------------------

# ═══════════════════════════════
#           Variables
# ═══════════════════════════════
ruta_Error="/home/carlos/Documentos/Sync-spotdl.log"

ruta_prueba="/home/carlos/Música/"
ruta_playlist="/media/carlos/Personal/101__Musica/Spotify - Mis Playlist/"
# ═══════════════════════════════
#           Funciones
# ═══════════════════════════════

msm() {
    echo "==== $(date '+%Y-%m-%d %H:%M:%S') → Sincronizando $1 ====" >>"$ruta_Error"
}

spotdl_pull() {
    local rutaPrincipal=$1
    local spotdl="/home/carlos/.local/bin/spotdl"

    # Bucle
    while IFS= read -r -d '' ruta_File; do
        # VAR
        local ruta_Parent="$($dirname "$ruta_File")"
        local formato=$($ls "$ruta_Parent" 2>/dev/null | $grep -Eo "(opus|mp3|m4a|ogg)$" | $sort | $uniq -c | $sort -nr | $head -n1 | $awk '{print $2}')

        # Verificado
        [[ -z "$formato" ]] && formato="opus"

        if $spotdl --format "$formato" sync "$ruta_File" --overwrite skip --output "$ruta_Parent" >>"$ruta_Error" 2>&1; then
            /usr/bin/notify-send "Spotdl ✅" "Sincronizado: $($basename "$ruta_File")"
        else
            /usr/bin/notify-send "Spotdl ❌" "Error en: $($basename "$ruta_File")"
        fi

    done < <($find "$rutaPrincipal" -name "*.spotdl" -print0 2>/dev/null) # Maneja si no hay

}

# ═══════════════════════════════
#             clean
# ═══════════════════════════════

[ -f "$ruta_Error" ] && [ $(stat -c%s "$ruta_Error") -gt 5000000 ] && : >"$ruta_Error"

# ═══════════════════════════════
#             Main
# ═══════════════════════════════
# msm "Prueba"
# spotdl_pull "$ruta_prueba"

msm "Playlist"
spotdl_pull "$ruta_playlist"
