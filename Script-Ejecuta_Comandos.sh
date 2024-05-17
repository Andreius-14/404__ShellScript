#!/bin/bash

# Función para ejecutar comandos
function ejecutar_comando() {
  # Expandir la variable $linea para obtener su valor real
  comando="$1"

  # Ejecutar el comando
  echo "Ejecutando: $comando"
  eval "$comando"

  # Verificar el código de salida del comando
  if [ $? -ne 0 ]; then
    echo "Error al ejecutar el comando: $comando"
  fi
}

# Mostrar un menú de opciones para seleccionar el archivo
echo "Seleccione el archivo de comandos:"
select archivo in *; do
  # Verificar si el archivo existe
  if [ -f "$archivo" ]; then
    # Leer el archivo línea por línea
    while IFS= read -r line; do
      # Ejecutar la función para cada línea
      ejecutar_comando "$line"
    done < "$archivo"
  else
    # Mostrar error si el archivo no existe
    echo "Error: El archivo '$archivo' no se encuentra."
  fi
done

