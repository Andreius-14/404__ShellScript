# ═══════════════════════════════
#         MENSAJES
# ═══════════════════════════════
# --- GUARD ---
[[ -n "${__BASE_SH_LOADED:-}" ]] && return
__BASE_SH_LOADED=1
# -------------

# Tus funciones y código de base aquí...
MSM_BASE="BASE"

## Muestra un texto coloreado en la terminal
# @param msg   => $1
# --- El texto
# @param color => $2
# --- El color
# --- (red, green, yellow, blue, magenta, cyan, white)
txt_color() {
  local msg="$1"   # El texto que será coloreado
  local color="$2" # El color en inglés
  local num_color  # Código de color ANSI correspondiente

  # Mapeo de colores a códigos ANSI
  case "$color" in
  "red") num_color=31 ;;
  "green") num_color=32 ;;
  "yellow") num_color=33 ;;
  "blue") num_color=34 ;;
  "magenta") num_color=35 ;;
  "cyan") num_color=36 ;;
  "white") num_color=37 ;;
  *)
    echo "Color no reconocido. Usando rojo por defecto." >&2
    num_color=31
    ;;
  esac

  # Imprimir el texto con el color seleccionado
  echo -e "\e[${num_color}m${msg}\e[0m"
}

__Error() {
  # Validar que se pase un mensaje
  if [ -z "$1" ]; then
    echo -e "\e[31mError: No se proporcionó ningún mensaje.\e[0m" >&2
    return 1
  fi

  local msg="$1"          # Mensaje de error
  local color="${2:-red}" # Color en inglés, por defecto rojo

  # Usar la función txt_color para manejar colores
  txt_color "Error: $msg" "$color" >&2
  return 1
}

# Mensaje de Finalizacion
__salir() {
  txt_color "Saliendo del programa. ¡Adiós!" green
  exit 0
}

# ALIAS
# ──────────────────────────────────────────────────────────────────────

__echo() {
  txt_color "$@"
}
