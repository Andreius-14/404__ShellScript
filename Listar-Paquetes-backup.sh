#!/bin/bash
source __FuncionesCompartidas.sh

# ═══════════════════════════════
#           Variables
# ═══════════════════════════════
Directorio_Principal="$HOME/.Dotfile/.Archivos-Temporales" 

ejecutar=(
"pacman -Qqe"
"pamac list -qe"
" npm list -g --json | jq -r '.dependencies | keys[]' "
" pnpm list -g  --json | jq -r '.[].dependencies | keys[]' "
"brew leaves"
"flatpak list --columns=application --app"
)
# ═══════════════════════════════
#           Funciones
# ═══════════════════════════════

Dotfiles_paquetes   () {
  # Verificar si el directorio existe
    __EstaInstalado jq
    __EstaInstalado eza
    __DirectorioExiste "$Directorio_Principal" || return 1

    # Ejecucion Personalizada
    gnome-extensions list > "$Directorio_Principal/Gnome_All_Extensiones.txt"            || __Error "Error_Gnome"
    gnome-extensions list --enabled > "$Directorio_Principal/Gnome_Enable_Extensiones.txt"   || __Error "Error_Gnome"
    code --list-extensions > "$Directorio_Principal/List_VsCode-Ext.txt" || __Error "Vscode"

    # Ejecucion Automatizada
    for comando in "${ejecutar[@]}";do
      primera_palabra=$(echo "$comando" | awk '{print $1}')
      eval "$comando" > "$Directorio_Principal/List_${primera_palabra}.txt" || __Error "${primera_palabra}"
    done

    echo "Listas de Paquetes -- Linux"

    eza -T --level=1 $Directorio_Principal

}

# ═══════════════════════════════
#             Main
# ═══════════════════════════════
main() {
  Dotfiles_paquetes
}

main

