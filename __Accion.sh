source __Base.sh

# ═══════════════════════════════
#         VERIFICADORES
# ═══════════════════════════════

__CrearCarpeta() {
    local directorio="$1"

    if [ ! -d "$directorio" ]; then
        __preguntaDeConfirmacion "¿Desea crear la Carpeta [$directorio] ?" #|| return 1

        sudo mkdir -p "$directorio"
        echo "Carpeta '$directorio' creada."
    else
        echo "'$directorio' Existe."
    fi
}

# ═══════════════════════════════
#         Ejecutar
# ═══════════════════════════════

__instalarPaquete() {
    # Variables
    local paquete="$1"
    local gestor="${2:-$(__detectarGestorPaquetes)}" || return 1 # Si falla, termina con error

    if __EstaInstalado "$paquete"; then
        return 0 # Ya está instalado, no hace falta hacer nada
    fi

    # MSM
    txt_color "⬇️ Instalando '$paquete' con $gestor..." "yellow"

    # INSTALL
    case "$gestor" in
    "pacman")
        sudo pacman -S --needed --noconfirm "$paquete" || {
            __Error "No se pudo instalar '$paquete' con pacman."
            return 1
        }
        ;;
    "pkg")
        pkg install -y "$paquete" || {
            __Error "No se pudo instalar '$paquete' con pkg."
            return 1
        }
        ;;
    esac

    return 0

}

__instalarPaquetesArray() {

    local paquetes=("$@")
    local gestorDeDistro=$(__detectarGestorPaquetes) || exit 0
    # Iterar sobre cada paquete y llamar a __instalarPaquete
    for item in "${paquetes[@]}"; do
        __instalarPaquete "$item" "$gestorDeDistro" || __Error "Fallo con $item..."
    done

}

__seleccionar_archivo() {
    local carpeta="$1"
    mapfile -t archivos < <(ls -1A "$carpeta")
    # local archivos=($(ls "$carpeta"))

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

# Psdt: Facilita Solicitar un Imput al Usuario, Formato Bucle Nose puede Salta Solo Ingresa el Formato Correcto
input_validador() {
    local mensaje="$1" # Mensaje que se muestra al usuario
    local tipo="$2"    # Tipo de validación (numeros, texto, mixto)
    local validado     # Expresión regular para validar el input
    local input        # Variable para almacenar el input del usuario

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
    local pregunta="${1:-"¿Deseas continuar?"}"
    local pregunta_coloreada=$(txt_color "$pregunta" "cyan")
    # Solicitar confirmación
    while true; do

        read -p "$pregunta_coloreada (yes/no): " respuesta

        # Paso: Switch
        case "$respuesta" in
        [Yy]* | [Ss]*) return 0 ;; # Acepta "yes", "y", "s", "si"
        [Nn]*)
            echo "Operación cancelada."
            return 1
            ;; # Cancela si es "no", "n"
        *)
            echo "Por favor, responde 'yes' o 'no'."
            ;;
        esac
    done
}
