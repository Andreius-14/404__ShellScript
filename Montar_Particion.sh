#!/bin/bash
source __FuncionesCompartidas.sh

Menu_Seleccionable() {
  echo "╔════════════════════════════╗ "
  echo "║       MENÚ PRINCIPAL       ║ "
  echo "╚════════════════════════════╝ "
  echo "1) Mostrar Informacion [Particiones]"
  echo "2) Empezar Proceso: Montar una Particion por Defecto"
  echo "3) Salir"
  echo "========================="
  read -p "Seleccione una opción [1-3]:" Opcion_Elegida
}


Mostrar_Particiones() {
  txt_color "\n Informacion de Particiones - 001" blue
  blkid -o list
  txt_color "\n Informacion de Particiones - 002" blue
  lsblk
  txt_color "\n Informacion de Particiones Montadas por Defecto" blue
  bat /etc/fstab || cat /etc/fstab
}

#======================================
# Funciones 
#======================================

Crear_Ubicacion_De_Montaje() {
  # local rutaBase="/mnt"
  local rutaBase="/run/media/$(whoami)"
  local NombreCarpeta="$1"
  local rutaMontada="$rutaBase/$NombreCarpeta"

  mkdir -p "$rutaMontada"  &&  chmod 777 "$rutaMontada"
  echo "$rutaMontada"
}

Main() {
  clear
  txt_color "==> Mostrado Informacion" green
  Mostrar_Particiones

  # Variables

  NombreParticion=$(input_validador "==> Ingresa un Nombre para la Partición (solo texto)" "texto")
  name_Particion=$(input_validador "==> Selecciona la Partición a Montar sda1 | sda2 ..." "mixto")



  # txt_color "\n==> Creando Recipiente donde se Montara \n" green

  rutaMontaje=$(Crear_Ubicacion_De_Montaje "$NombreParticion")
  valorUUID=$(blkid -s UUID -o value /dev/"$name_Particion"  )
  valorTYPE=$(blkid -s TYPE -o value /dev/"$name_Particion"  )
  parametrosExtra="defaults 0 0"
  
  clear 
  txt_color "\n==>Ingrese la siguiente Linea en el archivo /etc/fstab\n" blue
  echo "UUID=$valorUUID     $rutaMontaje      $valorTYPE    $parametrosExtra" 
  
  bat /etc/fstab || cat /etc/fstab


  # sudo echo "UUID=$valorUUID     $rutaMontaje      $valorTYPE    $parametrosExtra" >> /etc/fstab 

}

#======================================
# [MENU DE SELECCION]
#======================================
while true; do
  Menu_Seleccionable

  # Opcion Elegida
  case "$Opcion_Elegida" in
  1) Mostrar_Particiones ;;
  2) Main ;;
  3) __salir ;;
  *) txt_color "Opcion Incorrecta - Elija de Nuevo" green ;;
  esac
done
