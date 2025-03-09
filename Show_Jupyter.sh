#!/bin/bash
source __FuncionesCompartidas.sh

show_ArchivoJupyter() {
    local archivo="$1"
    local celdas=$(jq -r '.cells[] | [.cell_type, (.source | join("\n"))] | @tsv' "$archivo")

    # Iterar sobre las celdas en un bucle
    while IFS=$'\t' read -r cell_type content; do
        case "$cell_type" in
        "code")
            txt_color "[CODE] ════════════════════════════════════════════════════════════╗" "green"
            echo -e "$content" "white"| bat --paging=never --language python --theme "Dracula"
            txt_color "═══════════════════════════════════════════════════════════════════╝" "green"
            ;;
        "markdown")
            txt_color "[MARKDOWN] ════════════════════════════════════════════════════════╗" "cyan"
            txt_color "$content" "cyan"
            txt_color "═══════════════════════════════════════════════════════════════════╝" "cyan"
            ;;
        *)
            __Error "Tipo de celda desconocido: $cell_type" "red"
            ;;
        esac
    done <<<"$celdas"

    txt_color "✓ Procesamiento del notebook completado." "green"
}

show_ArchivoJupyter $1
