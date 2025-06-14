source __Base.sh
# Psdt: Mensaje Personalizado si Esta Instalado O no el Comando
__EstaInstalado() {
    local comando="$1" # El comando a verificar

    if command -v "$comando" &>/dev/null; then
        txt_color "🌱 $comando está instalado." blue
        return 0
    elif command -v pacman &>/dev/null && pacman -Q "$comando" &>/dev/null; then
        txt_color "🌱 $comando está instalado (pacman)." blue
        return 0
    else
        txt_color "💀 $comando no está instalado." red
        return 1
    fi

}

__EstaInstaladoArray() {
    local valor=0
    for item in "$@"; do
        __EstaInstalado "$item" || valor=1
    done
    return "$valor"
}

__DirectorioExiste() {
    local directorio="$1"

    [[ -d "$directorio" ]] && {
        txt_color "🌱 $directorio (Existe)" blue
        return 0
    }

    txt_color "\n $directorio (no existe) \n" "red"

    return 1
    # __CrearCarpeta "$directorio"
}
