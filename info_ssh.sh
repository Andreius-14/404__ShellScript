#!/bin/bash
source __FuncionesCompartidas.sh

info_ssh() {
    txt_color "\n
══════════════════════════════════════════════
nota: Tener Instalado [openssh, nmap]
nota: El sistema debe tener Password
nota: El sistema debe tener Corriendo sshd
══════════════════════════════════════════════
    " blue

    # Informacion
    local inf_name=$(whoami)
    local inf_ip=$(ip a | grep "192.168" | awk '{$1=$1};1')

    # Colorear
    inf_name=$(txt_color "$inf_name" green)
    inf_ip=$(txt_color "$inf_ip" green)

    echo "Name -> $inf_name "
    echo "IP   -> $inf_ip   "

    txt_color "\n
══════════════════════════════════════════════
Los Puertos Habiertos ⮯
══════════════════════════════════════════════
    " blue

    # Ejecucion
     nmap localhost || ss -tuln
}

main() {
    info_ssh
}

main
