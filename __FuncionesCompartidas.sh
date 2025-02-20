# Mensaje de Finalizacion
__salir() {
  txt_color "Saliendo del programa. ¡Adiós!" green
  exit 0
}

# ═══════════════════════════════
#         VERIFICADORES
# ═══════════════════════════════

# Psdt: Mensaje Personalizado si Esta Instalado O no el Comando
__EstaInstalado() {
  local comando="$1" # El comando a verificar

  if command -v "$comando" &>/dev/null || pacman -Q "$comando" &>/dev/null; then
    txt_color "🌱 $comando está instalado." blue
    return 0 # Éxito
  else
    txt_color "💀 $comando no está instalado." red
    return 1 # Fallo
  fi
}

__DirectorioExiste(){
  local directorio="$1"

  [[ -d "$directorio" ]] && return 0

  txt_color "\n 💀 El directorio '$directorio' no existe. \n" "red"
  return 1
}


# ═══════════════════════════════
#         MENSAJES
# ═══════════════════════════════

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


Error() {
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


# ═══════════════════════════════
# Funciones - Grandes
# ═══════════════════════════════

# Psdt: Facilita Solicitar un Imput al Usuario, Formato Bucle Nose puede Salta Solo Ingresa el Formato Correcto
input_validador() {
  local mensaje="$1"        # Mensaje que se muestra al usuario
  local tipo="$2"           # Tipo de validación (numeros, texto, mixto)
  local validado            # Expresión regular para validar el input
  local input               # Variable para almacenar el input del usuario

  case "$tipo" in
  "numeros") validado="^[0-9]+$" ;;
  "texto") validado="^[a-zA-Z]+$" ;;
  "email" | "correo") validado="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" ;;
  *)
    #"Cualquier Input Valido"
    validado="^[a-zA-Z0-9]+$"
    ;;
  esac

  while true; do
    read -p "$mensaje: " input
    if [[ "$input" =~ $validado ]]; then
      break
    else
      echo "El input contiene caracteres no permitidos. Inténtalo de nuevo."
    fi
  done
  
  # Retornar el resultado como salida de la función
  echo "$input"
}


__preguntaDeConfirmacion() {
  local pregunta="${1:-¿Deseas continuar?}"

  # Solicitar confirmación
  while true; do

    read -p "$pregunta (yes/no): " respuesta

    # Paso: Switch
    case "$respuesta" in
      [Yy]* | [Ss]*) return 0 ;;  # Acepta "yes", "y", "s", "si"
      [Nn]*) 
        echo "Operación cancelada."
        return 1 ;;  # Cancela si es "no", "n"
      *) 
        echo "Por favor, responde 'yes' o 'no'." ;;
    esac  
  done
}


# ═══════════════════════════════
#         Ejecutar
# ═══════════════════════════════

__instalarPaquete() {
  local paquete="$1"

  if __EstaInstalado "$paquete"; then
    return 0  # Ya está instalado, no hace falta hacer nada
  fi

  if __EstaInstalado "pacman"; then
    sudo pacman -S --needed --noconfirm "$paquete"
  elif __EstaInstalado "pkg"; then
    pkg install -y "$paquete"
  else
    txt_color "❌ No se encontró un gestor de paquetes compatible." red
    return 1
  fi
}

__seleccionar_archivo() {
  local carpeta="$1"
  local archivos=($(ls "$carpeta"))
  
  # Mostrar opciones y permitir selección
  select archivo in "${archivos[@]}"; do
    if [ -n "$archivo" ]; then
      # echo "Seleccionaste el archivo: $archivo"
      echo "$archivo"
      break
    else
      echo "Selección no válida, intenta nuevamente."
    fi
  done
}
