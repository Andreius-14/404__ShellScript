#!/bin/bash
source __Shared.sh

main() {

    local base="$HOME/Descargas"
    local contenedor="AppImages"
    local ruta="$base/$contenedor"
    local permisos="u+x"

    # Crear carpeta si no existe
    __CrearCarpeta "$ruta"

    echo "✅ Iniciando Proceso"
    # Mover AppImages
    for aplicacion in "$base"/*.App[Ii]mage; do
        [ -f "$aplicacion" ] || continue # por si no hay ninguno
        echo "Moviendo appImage: $aplicacion"
        mv "$aplicacion" "$ruta"
    done

    echo "Buscando AppImages en $ruta..."

    for archivo in "$ruta"/*.App[Ii]mage; do
        [ -f "$archivo" ] || continue
        chmod "$permisos" "$archivo"
        echo "Permisos Habilitado: $archivo"
    done

    echo "✅ Proceso finalizado."
}

main
