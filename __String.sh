source __Base.sh
# EXTRA

__detectarGestorPaquetes() {
    local gestor

    # Lista de gestores de paquetes a verificar (en orden de preferencia)
    if command -v pacman >/dev/null 2>&1; then
        gestor="pacman"
    elif command -v pkg >/dev/null 2>&1; then
        gestor="pkg"
    elif command -v apt >/dev/null 2>&1; then
        gestor="apt"
    elif command -v dnf >/dev/null 2>&1; then
        gestor="dnf"
    elif command -v yum >/dev/null 2>&1; then
        gestor="yum"
    elif command -v zypper >/dev/null 2>&1; then
        gestor="zypper"
    else
        gestor=""
    fi

    # Si se encontró un gestor, devolverlo; si no, error
    if [ -n "$gestor" ]; then
        txt_color "🌱 Gestor de paquetes detectado: $gestor" "green" >&2
        echo "$gestor" # Retorna el nombre del gestor como salida
        return 0
    else
        __Error "No se encontró un gestor de paquetes compatible."
        return 1
    fi
}

__SeleccionaOpcion() {
    local opciones=("$@")        # Captura todas las opciones en un array
    PS3="Selecciona un Numero: " # Mensaje del prompt

    select opcion in "${opciones[@]}"; do
        if [[ -n $opcion ]]; then
            echo "$opcion" # Imprime la opción seleccionada
            break          # Sale del select
        else
            __Error "Opción inválida, intenta de nuevo."
        fi
    done
}

__SeleccionaOpcion_FZF() {
    local opciones=("$@")
    printf "%s\n" "${opciones[@]}" | fzf --prompt="Selecciona una opción: "
}
