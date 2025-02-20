#======================================
# [ Import - Export ]
#======================================
#!/bin/bash
source __FuncionesCompartidas.sh

#======================================
# [Funciones - Small]
#======================================

Msm_Menu() {
  echo "╔════════════════════════════╗ "
  echo "║       MENÚ PRINCIPAL       ║ "
  echo "╚════════════════════════════╝ "
  echo "1) Convertir: Gif ==> Frame"
  echo "2) Convertir: Gif ==> Ascii"
  echo "3) Salir"
  echo "========================="
  read -p "Seleccione una opción [1-3]: " opcion
}


#======================================
# [Funciones - Long]
#======================================

FrameAscii() {

  # Validar que se ha proporcionado un archivo GIF como argumento
  local input_file="${1:?"Error: Ingrese el Archivo gif"}"

  # Obtener el path_nombre del archivo sin la extensión
  local base_name="$(basename "$input_file" .gif)"
  local path_nombre="Frame_$base_name"
  local folder="Ascii_$base_name"

  Frame $input_file

  mkdir -p $folder

  ascii-image-converter $path_nombre/*.png --save-txt $folder || Error "Imagen a Ascii"

  rename "ascii-art" "" $folder/* && rename "-" "" $folder/* || Error "Al Renombrar"

  echo "Conversión completada"
}

Frame() {
  local input_frame="${1:?"Error: Ingrese el Archivo GIF como argumento."}"

  # Obtener el nombre base y el directorio de salida
  local base_name="$(basename "$input_frame" .gif)"
  local folder="Frame_$base_name"

  mkdir -p $folder

  ffmpeg -i "$input_frame" "$folder/%03d.png" || Error "Extraccion Frames"

  echo "Extracción completada. '$folder'."
}

#======================================
# [MENU DE SELECCION]
#======================================
while true; do
  Msm_Menu
  case "$opcion" in
  1)
    echo "Ingrese el archivo GIF: "
    read -e archivo
    Frame "$archivo"
    ;;
  2)
    echo "Ingrese el archivo GIF:"
    read -e archivo
    FrameAscii "$archivo"
    ;;
  3) __salir ;;
  *)
    echo "Opción no válida. Intente de nuevo."
    ;;
  esac
done
