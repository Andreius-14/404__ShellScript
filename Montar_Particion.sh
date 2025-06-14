#!/bin/bash
source __Shared.sh

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
msm_RutaMontaje() {
    txt_color "\n¿Dónde deseas montar la partición?" cyan
    echo "╭───────────────────────────────────────────────╮"
    echo "│   • media: Para montajes automáticos del      │"
    echo "│     sistema, usados por entornos gráficos.    │"
    echo "│     Ej: /media/usuario o /run/media/usuario   │"
    echo "│     (Mas Popular)                             │"
    echo "│                                               │"
    echo "│   • mnt: Para montajes manuales o temporales. │"
    echo "│     Común en servidores, scripts, o WSL.      │"
    echo "│     (Mas Tecnico no aparece en Biblioteca)    │"
    echo "│                                               │"
    echo "╰───────────────────────────────────────────────╯"
}

GeneraRutaMontaje() {

    local folder="$1"
    local rutaBase

    if [[ "$folder" == "media" ]]; then
        for base in "/run/media/$USER" "/media/$USER"; do
            if [[ -d "$base" ]]; then
                rutaBase="$base"
                break
            fi
        done
    else
        for base in "/mnt" "/mnt/wsl"; do
            if [[ -d "$base" ]]; then
                rutaBase="$base"
                break
            fi
        done
    fi

    if [[ -z "$rutaBase" ]]; then
        __Error "No se encontró una ruta válida para '$folder'."
        return 1
    fi

    echo "$rutaBase"
}

Main() {
    clear
    txt_color "==> Mostrado Informacion" green
    Mostrar_Particiones

    #===========
    # Variables
    #===========

    local seleccionado

    local ruta_Final
    local ruta_Montaje

    local name_Contenedor=$(input_validador "==> Ingresa un Nombre que se le Dara a la Partición (solo texto)" "texto")
    local name_Particion=$(input_validador "==> Selecciona la Partición a Montar sda1 | sda2 ..." "mixto")

    local valorUUID=$(blkid -s UUID -o value /dev/"$name_Particion")
    local valorTYPE=$(blkid -s TYPE -o value /dev/"$name_Particion")
    local valorExtra="defaults 0 0"

    #La variable control extra puede ser mas permisiva e eficinte que chmod 777

    #===========
    # Procesos
    #===========

    txt_color "\n==> Seleccion de Ruta Base de Montaje \n" green
    # Imprime explicación sobre opciones de montaje
    msm_RutaMontaje
    seleccionado=$(__SeleccionaOpcion "mnt" "media")
    ruta_Montaje=$(GeneraRutaMontaje "$seleccionado")

    txt_color "\n==> Generando Contenedor Dentro de la Ruta Base \n" green

    ruta_Final="$ruta_Montaje/$name_Contenedor"
    __CrearCarpeta "$ruta_Final" && sudo chmod 777 "$ruta_Final"

    #===========
    # Salida
    #===========
    txt_color "\n==> Ingrese Linea en el Siguiente Archivo /etc/fstab\n" green

    echo "UUID=$valorUUID     $ruta_Final      $valorTYPE    $valorExtra"

    bat /etc/fstab || cat /etc/fstab

    txt_color "⚠️  Recuerda ejecutar: sudo nano /etc/fstab para pegar la línea sugerida." yellow

    txt_color "Activar lo Editado ==> sudo mount -a " gray
    txt_color "Desmontar requiere ==> sudo umount <ruta>" gray
    txt_color "Lo comentado no se montara en la siguiente prendida de Maquina" gray
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
