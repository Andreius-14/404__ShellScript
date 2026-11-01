# #!/bin/bash
#
# # Imagenes - Columnas
# GRID_COLS=4
#
# # Imagenes - Tamaño
# WIDTH=40
# HEIGHT=20
#
# # Obtener las imágenes del directorio actual
# IMAGES=("$PWD"/*.jpg "$PWD"/*.png)
#
# # Comprobar si hay imágenes disponibles
# if [ ${#IMAGES[@]} -eq 0 ]; then
#   echo "No se encontraron imágenes en el directorio actual."
#   exit 1
# fi
#
# # Mostrar imágenes en la cuadrícula
# for i in "${!IMAGES[@]}"; do
#
#   # Modulo   [Lo que Falpa para resultado redondo]
#   # Division [No Muestra Decimales]
#   #
#   # Los Numero Empiezan 0
#   col=$((i % GRID_COLS)) #Asigna Numero de Columna
#   row=$((i / GRID_COLS)) #Asigna Numero de Fila
#   # echo "[$row , $col]"
#
#   # Posicion
#   x_posicion=$((col * WIDTH))
#   y_posicion=$((row * HEIGHT))
#
#
#
#
#   # Comando Principal
#   kitten icat --place "${WIDTH}x${HEIGHT}@${x_posicion}x${y_posicion}" "${IMAGES[$i]}"
#
# done
#
# # Mensaje final
# echo "Se han mostrado ${#IMAGES[@]} imágenes en la cuadrícula."
