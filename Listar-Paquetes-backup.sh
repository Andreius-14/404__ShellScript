#!/bin/bash
source __FuncionesCompartidas.sh

# ═══════════════════════════════
#     Variables -- Simples
# ═══════════════════════════════
Dir_Main="$HOME/.Dotfile/.Archivos-Temporales"
Dir_Termux="Package_Termux"
Dir_Arch="Package_Arch"
Dir_final="$Dir_Main"
# ═══════════════════════════════
#     Variables -- Array
# ═══════════════════════════════
ejecutar=(
  "pacman -Qqe"
  "pamac list -qe"
  "npm list -g --json | jq -r '.dependencies | keys[]' "
  "pnpm list -g  --json | jq -r '.[].dependencies | keys[]' "
  "brew leaves"
  "flatpak list --columns=application --app"
  "gnome-extensions list --enabled"
  "code --list-extensions "
)

package_Necesarios=(
  jq
  eza
)
# ═══════════════════════════════
#           Funciones
# ═══════════════════════════════

DefineRuta() {
  local paquete=$(__detectarGestorPaquetes)
  case "$paquete" in
  "pkg")
    Dir_final="$Dir_Main/$Dir_Termux"
    ;;
  "pacman")
    Dir_final="$Dir_Main/$Dir_Arch"
    ;;
  *)
    Dir_final="$Dir_Main"
    ;;
  esac

}

EjecucionDeComandos() {
  local ruta="${1:-"$Dir_Main"}"
  # Ejecucion Automatizada
  for comando in "${ejecutar[@]}"; do
    primera_palabra=$(echo "$comando" | awk '{print $1}')
    eval "$comando" >"$ruta/List_${primera_palabra}.txt" || __Error "${primera_palabra}"
  done
}
# ═══════════════════════════════
#             Main
# ═══════════════════════════════
main() {
  __EstaInstaladoArray "${package_Necesarios[@]}" || return 1
  __DirectorioExiste "$Dir_Main" || return 1

  DefineRuta
  EjecucionDeComandos "$Dir_final"

  txt_color "Listas de Paquetes -- Linux" blue
  eza -T --level=1 $Dir_Main

}

main
