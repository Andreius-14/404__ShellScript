#!/bin/bash

# Función para ejecutar comandos
function ejecutar_comando() {
  # Expandir la variable $linea para obtener su valor real
  comando="$1"

  # Verificar si el comando existe
  if command -v "$comando" >/dev/null; then
    # Ejecutar el comando
    echo "Ejecutando: $comando"
    $comando
  else
    # Mostrar error si el comando no existe
    echo "Error: El comando '$comando' no se encuentra."
  fi
}

# Solicitar nombre del archivo
echo "Ingrese el nombre del archivo de comandos:"
read archivo

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

