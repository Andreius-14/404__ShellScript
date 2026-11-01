
#!/bin/bash

# Si no se pasa un argumento, usar la carpeta actual como ruta por defecto
carpeta="${1:-$(pwd)}"

# Listar los archivos numerados en la carpeta
archivos=$(ls "$carpeta" | sort -n)  # Los archivos deben tener nombres numéricos

# Bucle infinito
while true; do
  for archivo in $archivos; do
    clear  # Limpiar la consola
    cat "$carpeta/$archivo"  # Imprimir el archivo
    sleep 0.05  # Esperar 0.1 segundos (puedes ajustar el tiempo para que sea más rápido o lento)
  done
done

echo "Animación terminada."

