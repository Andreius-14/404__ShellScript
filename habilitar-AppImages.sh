#!/bin/bash
source __Shared.sh

main() {

    local main="$HOME/Descargas"
    local contenedor="AppImages"
    local ruta="$main/$contenedor"
    local permisos="+x"

    # Crear carpeta si no existe
    __CrearCarpeta "$ruta"

    echo "✅ Iniciando Proceso"
    # Mover AppImages
    for aplicacion in "$main"/*.AppImage; do
        [ -f "$aplicacion" ] || continue # por si no hay ninguno
        echo "Moviendo appImage: $aplicacion"
        mv "$aplicacion" "$ruta"
    done

    echo "Buscando AppImages en $ruta..."

    for archivo in "$ruta"/*.AppImage; do
        [ -f "$archivo" ] || continue
        chmod "$permisos" "$archivo"
        echo "Permisos Habilitado: $archivo"
    done

    echo "✅ Proceso finalizado."
}

main
