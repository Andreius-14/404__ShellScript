#!/bin/bash
source __FuncionesCompartidas.sh

# ═══════════════════════════════
#           Variables
# ═══════════════════════════════

github=(
  "Local-PruebaDeCodigo-Bash"
  "Local-PruebaDeCodigo-Csharp"
  "Local-PruebaDeCodigo-Css"
  "Local-PruebaDeCodigo-Git"
  "Local-PruebaDeCodigo-Js"
  "Local-PruebaDeCodigo-Lua"
  "Local-PruebaDeCodigo-Py"
  "__Archivos-Temporales"
  "__Mini_Proyectos"
  "📁 Desconocidos"
  "📁 Fork"
  "📁 Librerias"
  "📁 Repositorios"
  "📁 Script"
  "📁 Sintaxis"
)

main=(
  '📁 Documentos'
  '📁 Imagenes'
  '📁 Musica'
  '📁 Videos'
  '101__Arte'
  '101__Github'
  '101__Informatica'
)

# ═══════════════════════════════
#           Funciones
# ═══════════════════════════════

Menu_Seleccionable() {
  echo "╔════════════════════════════╗ "
  echo "║       MENÚ PRINCIPAL       ║ "
  echo "╚════════════════════════════╝ "
  echo "1) Mostrar Grupos de Archivos"
  echo "2) Montar: Folder Main"
  echo "3) Montar: Folder Github"
  echo "404) Salir"
  echo "========================="
  read -p "Seleccione una opción [1-3]:" Opcion_Elegida
}

Mostrar_Grupos() {
  txt_color "\nGrupo >>>> [Main]" red
  informando "${main[@]}"
  txt_color "\nGrupo >>>> [Github]" red
  informando "${github[@]}"
}

# Preguntar al usuario si desea crear las carpetas
informando() {
  txt_color "\n Se crearán las siguientes carpetas:" blue

  # Imprimir las carpetas directamente
  for item in "$@"; do
    txt_color " - $item" white
  done
}

montarCarpetas() {

  informando "$@" || return 1 # Si la función 'informando' falla, se sale
  __preguntaDeConfirmacion || return 1

  # Crear cada carpeta si el usuario confirma
  for carpeta in "$@"; do
    mkdir -p "$carpeta" && echo "✅ Carpeta creada: $carpeta"
  done

}

# ═══════════════════════════════
#        Menu - Seleccion
# ═══════════════════════════════
while true; do
  Menu_Seleccionable

  # Opcion Elegida
  case "$Opcion_Elegida" in
  1) Mostrar_Grupos ;;
  2) montarCarpetas "${main[@]}" ;;
  3) montarCarpetas "${github[@]}" ;;
  404) __salir ;;
  *) txt_color "Opcion Incorrecta - Elija de Nuevo" green ;;
  esac
done
