#!/bin/bash

# Función para seleccionar un archivo
seleccionar_archivo() {
  echo "Seleccione el archivo de comandos:"
  select archivo in *; do
    if [ -f "$archivo" ]; then
      echo "Archivo seleccionado: $archivo"
      break
    else
      echo "Error: '$archivo' no se encuentra."
    fi
  done
}

# Solicitar el comando al usuario
echo "Ingresa Comando: (se ejecutara por linea)"
read -r comando

# Función para ejecutar un comando y mostrar el resultado limpio
ejecutar_comando() {
  linea="$1"
  $comando $linea
}

# Seleccionar el archivo
seleccionar_archivo

# Leer el archivo línea por línea y ejecutar el comando antes de cada línea
while IFS= read -r linea; do
  ejecutar_comando "$linea"
  echo "$linea"
done < "$archivo"

